import 'package:kgk/kgk.dart';

/// `SmartPaginationScrollController` is a class that handles pagination in a scrollable list.
/// It provides methods to initialize, dispose, and listen to scroll events.
class SmartPaginationScrollController {
  late ScrollController scrollController;
  late ScrollController secondaryScrollController;
  bool _isInitialised = false;
  bool isLoading = false;
  bool stopLoading = false;
  int currentPage = 1;
  double boundaryOffset = 0.5;
  Completer<bool> isPageLoaded = Completer<bool>();
  ValueNotifier<bool> canScrollToTop = ValueNotifier(false);
  bool isSecondaryViewSelected = false;
  bool _isSecondaryView = false;
  String? tag;
  late Function(int currentPage) loadAction;

  bool get isInitialised => _isInitialised;

  ScrollController get controller => isSecondaryViewSelected ? secondaryScrollController : scrollController;

  PageStorageKey gridKey = const PageStorageKey('gridKey');
  PageStorageKey listKey = const PageStorageKey('listKey');

  void scrollToTop() {
    controller.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void pullToRefresh() {
    isPageLoaded = Completer<bool>();
    currentPage = 1;
    // stopLoading = false;
  }

  /// Initializes the scroll controller and sets the load action.
  /// Optionally, an init action can be provided.
  ///
  /// [initAction] is a function that is called when the scroll controller is initialized.
  /// [loadAction] is a function that is called when a new page needs to be loaded.
  void init({Function? initAction, required Function(int currentPage) loadAction, String? tag, bool isSecondaryView = false}) {
    this.tag = tag;
    _isSecondaryView = isSecondaryView;
    if (isPageLoaded.isCompleted) {
      scrollController.dispose();
      scrollController.removeListener(scrollListener);
      if (_isSecondaryView) {
        secondaryScrollController.dispose();
        secondaryScrollController.removeListener(scrollListener);
      }
    }
    isPageLoaded = Completer<bool>();
    currentPage = 1;
    if (initAction != null) {
      initAction();
    }
    this.loadAction = loadAction;
    scrollController = ScrollController(onAttach: onAttach);
    scrollController.addListener(scrollListener);
    if (_isSecondaryView) {
      secondaryScrollController = ScrollController(onAttach: onAttach);
    }

    _isInitialised = true;
  }

  void onAttach(ScrollPosition position) {
    Future.delayed(const Duration(milliseconds: 50), () {
      canScrollToTop.value = controller.offset > 0;
    });
  }

  /// Disposes the scroll controller and removes the scroll listener.
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    if (_isSecondaryView) {
      secondaryScrollController.removeListener(scrollListener);
      secondaryScrollController.dispose();
    }
  }

  /// Listens to scroll events and triggers the load action when the scroll position
  /// reaches a certain boundary. It also manages the loading state and the current page.
  void scrollListener() {
    if (controller.offset > 0) {
      canScrollToTop.value = true;
    } else {
      canScrollToTop.value = false;
    }
    if (!stopLoading) {
      try {
        if (controller.offset >= controller.position.maxScrollExtent * boundaryOffset && !isLoading) {
          isLoading = true;
          isPageLoaded = Completer<bool>();
          loadAction(currentPage);
          isPageLoaded.future.then((bool shouldStop) {
            isLoading = false;
            currentPage++;
            boundaryOffset = 1 - 1 / (currentPage * 2);
            if (shouldStop == true) {
              stopLoading = true;
            }
          });
        }
      } catch (e) {
        printWrapped('Error: $e');
      }
    }
  }

  void onViewChange(bool isSecondaryViewSelected) {
    if (_isSecondaryView) {
      this.isSecondaryViewSelected = isSecondaryViewSelected;
      canScrollToTop.value = false;
      if (isSecondaryViewSelected) {
        scrollController.removeListener(scrollListener);
        secondaryScrollController.addListener(scrollListener);
      } else {
        secondaryScrollController.removeListener(scrollListener);
        scrollController.addListener(scrollListener);
      }
    }
  }
}
