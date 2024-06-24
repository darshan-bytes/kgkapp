import 'package:kgk/kgk.dart';

/// `SmartPaginationScrollController` is a class that handles pagination in a scrollable list.
/// It provides methods to initialize, dispose, and listen to scroll events.
class SmartPaginationScrollController {
  late ScrollController scrollController;
  bool isLoading = false;
  bool stopLoading = false;
  int currentPage = 1;
  double boundaryOffset = 0.5;
  Completer<bool> isPageLoaded = Completer<bool>();
  ValueNotifier<bool> canScrollToTop = ValueNotifier(false);
  late Function(int currentPage) loadAction;

  void scrollToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  /// Initializes the scroll controller and sets the load action.
  /// Optionally, an init action can be provided.
  ///
  /// [initAction] is a function that is called when the scroll controller is initialized.
  /// [loadAction] is a function that is called when a new page needs to be loaded.
  void init({Function? initAction, required Function(int currentPage) loadAction}) {
    if (initAction != null) {
      initAction();
    }
    this.loadAction = loadAction;
    scrollController = ScrollController()..addListener(scrollListener);
  }

  /// Disposes the scroll controller and removes the scroll listener.
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  /// Listens to scroll events and triggers the load action when the scroll position
  /// reaches a certain boundary. It also manages the loading state and the current page.
  void scrollListener() {
    if (scrollController.offset > 0) {
      canScrollToTop.value = true;
    } else {
      canScrollToTop.value = false;
    }
    if (!stopLoading) {
      if (scrollController.offset >= scrollController.position.maxScrollExtent * boundaryOffset && !isLoading) {
        isLoading = true;
        isPageLoaded = Completer<bool>();
        loadAction(currentPage).then((value) async {
          bool shouldStop = await isPageLoaded.future;
          isLoading = false;
          currentPage++;
          boundaryOffset = 1 - 1 / (currentPage * 2);
          if (shouldStop == true) {
            stopLoading = true;
          }
        });
      }
    }
  }
}
