import 'package:kgk/kgk.dart';
import 'package:kgk/model/style_design_model.dart';

part 'styles_listing_event.dart';

part 'styles_listing_state.dart';

class StylesListingBloc extends Bloc<StylesListingEvent, StylesListingState> {
  List<StyleDesignModel> stylesList = [];
  TextEditingController searchController = TextEditingController();
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  StylesListingBloc() : super(StylesListingInitial()) {
    on<StylesListingInitialEvent>(_onStylesListingInitialEvent);
    on<StylesListingSearchEvent>(_onStylesListingSearchEvent);
    on<StylesListingLoadMoreEvent>(_onStylesListingLoadMoreEvent);
    on<StylesListingPullToRefreshEvent>(_onStylesListingPullToRefresh);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void _onStylesListingInitialEvent(StylesListingInitialEvent event, Emitter<StylesListingState> emit) {
    emit(StylesListingReloadState());
    searchController.clear();
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(StylesListingLoadMoreEvent(currentPage));
      },
    );
    stylesList = List.generate(
      20,
      (index) => StyleDesignModel(
        id: index.toString(),
        designId: "903405",
        styleId: "01AA6545",
        productName: "Ring",
        productImageUrl: 'https://i.ibb.co/HgjT1rt/Image.png',
        userImageUrl: "https://i.ibb.co/1Lq3YpF/Frame-3977.png",
        userName: "John",
        diamondType: "Diamond classic",
        diamondShape: "Moncao",
        status: ProjectStatus.onHold,
        firstType: "M",
        secondType: "D",
        thirdType: "C",
        firstGram: "18K/0.75 g",
        secondGram: "0.167cts/3",
        thirdGram: "0.54/2"
      ),
    ).toList();

    refreshCompleter.complete(true);
    emit(const StylesListingLoadedState());
  }

  void _onStylesListingSearchEvent(StylesListingSearchEvent event, Emitter<StylesListingState> emit) {
    //TODO: Implement search logic
  }

  Future<void> _onStylesListingLoadMoreEvent(StylesListingLoadMoreEvent event, Emitter<StylesListingState> emit) async {
    emit(const StylesListingLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    stylesList.addAll(
      List.generate(
        10,
        (index) => StyleDesignModel(
            id: index.toString(),
            designId: "903405",
            styleId: "01AA6545",
            productName: "Ring",
            userImageUrl: "https://i.ibb.co/1Lq3YpF/Frame-3977.png",
            userName: "John",
            diamondType: "Diamond classic",
            diamondShape: "Moncao",
            status: ProjectStatus.onHold,
            firstType: "M",
            secondType: "D",
            thirdType: "C",
            firstGram: "18K/0.75 g",
            secondGram: "0.167cts/3",
            thirdGram: "0.54/2",
            numberOfProduct: "3"
        ),
      ),
    );
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(StylesListingLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onStylesListingPullToRefresh(StylesListingPullToRefreshEvent event, Emitter<StylesListingState> emit) async {
    emit(StylesListingReloadState());
    await Future.delayed(const Duration(seconds: 2));
    paginationScrollController.pullToRefresh();
    stylesList = _generateStylesList();
    refreshCompleter.complete(true);
    emit(const StylesListingLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const StylesListingPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }

  List<StyleDesignModel> _generateStylesList() {
    return List.generate(
      10,
      (index) => StyleDesignModel(
          id: index.toString(),
          designId: "903405",
          styleId: "01AA6545",
          productName: "Ring",
          userImageUrl: "https://i.ibb.co/1Lq3YpF/Frame-3977.png",
          userName: "John",
          diamondType: "Diamond classic",
          diamondShape: "Moncao",
          status: ProjectStatus.onHold,
          firstType: "M",
          secondType: "D",
          thirdType: "C",
          firstGram: "18K/0.75 g",
          secondGram: "0.167cts/3",
          thirdGram: "0.54/2",
          numberOfProduct: "3"
      ),
    );
  }
}
