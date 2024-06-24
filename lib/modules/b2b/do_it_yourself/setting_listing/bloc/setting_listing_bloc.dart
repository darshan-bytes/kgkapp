import 'package:kgk/kgk.dart';

part 'setting_listing_event.dart';

part 'setting_listing_state.dart';

class SettingListingBloc extends Bloc<SettingListingEvent, SettingListingState> {
  bool isInitialToggle = true;
  bool isGrid = true;
  List<ProductDetails> productList = [];

  String settingListingAppbarTitle = "DIY";

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  SettingListingBloc() : super(const SettingListingInitial()) {
    on<GetSettingProductListEvent>(_onGetSettingProductListEvent);
    on<SettingChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<LoadMoreSettingProductListEvent>(_onLoadMoreSettingProductListEvent);
  }

  Future<void> _onGetSettingProductListEvent(GetSettingProductListEvent event, Emitter<SettingListingState> emit) async {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(LoadMoreSettingProductListEvent(currentPage));
      },
    );
    await Future.delayed(const Duration(seconds: 0), () {
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/CHwFm51/image-7-3.png" : "https://i.ibb.co/PGFbmSy/image-7-2.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                  originalPrice: "\$3,000.00",
                ),
              ));
    });
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
              ProductDetails(
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
}
