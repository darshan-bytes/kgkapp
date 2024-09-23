import 'package:kgk/kgk.dart';

part 'setting_listing_event.dart';

part 'setting_listing_state.dart';

class SettingListingBloc extends Bloc<SettingListingEvent, SettingListingState> {
  bool isInitialToggle = true;
  bool isGrid = true;
  List<ProductDetailsModel> productList = [];

  String settingListingAppbarTitle = "DIY";

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  SettingListingBloc() : super(const SettingListingInitial()) {
    on<GetSettingProductListEvent>(_onGetSettingProductListEvent);
    on<SettingChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<LoadMoreSettingProductListEvent>(_onLoadMoreSettingProductListEvent);
    on<SettingListPullToRefreshEvent>(_onSettingListPullToRefresh);
  }

  Future<void> _onGetSettingProductListEvent(GetSettingProductListEvent event, Emitter<SettingListingState> emit) async {
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(LoadMoreSettingProductListEvent(currentPage));
      },
    );
    await Future.delayed(const Duration(seconds: 0), () {
      List.generate(
          20,
          (index) => productList.add(
                ProductDetailsModel(
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/CHwFm51/image-7-3.png" : "https://i.ibb.co/PGFbmSy/image-7-2.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                  originalPrice: "\$3,000.00",
                ),
              ));
    });

    if (!refreshCompleter.isCompleted) {
      refreshCompleter.complete(true);
    }
    emit(const SettingLoadedState());
  }

  void _onChangeListingTypeEvent(SettingChangeListingTypeEvent event, Emitter<SettingListingState> emit) {
    emit(const SettingProductReloadState());
    isGrid = !isGrid;
    emit(SettingChangeListingTypeState());
  }

  Future<void> _onLoadMoreSettingProductListEvent(LoadMoreSettingProductListEvent event, Emitter<SettingListingState> emit) async {
    emit(const SettingLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    List.generate(
        20,
        (index) => productList.add(
              ProductDetailsModel(
                diamond: "2.5 crt",
                gram: "1.5 grms",
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/CHwFm51/image-7-3.png" : "https://i.ibb.co/PGFbmSy/image-7-2.png",
                name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                originalPrice: "\$3,000.00",
              ),
            ));
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(SettingProductLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onSettingListPullToRefresh(SettingListPullToRefreshEvent event, Emitter<SettingListingState> emit) async {
    paginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    productList = List.generate(
        10,
        (index) => ProductDetailsModel(
              diamond: "2.5 crt",
              gram: "1.5 grms",
              imageUrl: index % 2 == 0 ? "https://i.ibb.co/CHwFm51/image-7-3.png" : "https://i.ibb.co/PGFbmSy/image-7-2.png",
              name: "2.00 Carat H VS1 Excellent Cut Round Setting",
              originalPrice: "\$3,000.00",
            )).toList();
    refreshCompleter.complete(true);
    emit(const SettingLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const SettingListPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
