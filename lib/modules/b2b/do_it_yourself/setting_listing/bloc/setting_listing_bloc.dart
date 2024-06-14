import 'package:kgk/kgk.dart';

part 'setting_listing_event.dart';

part 'setting_listing_state.dart';

class SettingListingBloc extends Bloc<SettingListingEvent, SettingListingState> {
  bool isInitialToggle = true;
  bool isGrid = true;
  List<ProductDetails> productList = [];

  // List of numbers for the dropdown
  List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];

  // The selected number of pages, initialized to the first item
  String selectedPageNumber = '01';

  String settingListingAppbarTitle = "DIY";

  SettingListingBloc() : super(const SettingListingInitial()) {
    on<GetSettingProductListEvent>(_onGetSettingProductListEvent);
    on<SettingChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<SettingProductChangePageNumberEvent>(_onPageNumberChanged);
  }

  Future<void> _onGetSettingProductListEvent(GetSettingProductListEvent event, Emitter<SettingListingState> emit) async {
    emit(const SettingLoadingState());
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
    emit(const SettingListingInitial());
  }

  void _onChangeListingTypeEvent(SettingChangeListingTypeEvent event, Emitter<SettingListingState> emit) {
    isGrid = event.isGrid;
    emit(SettingChangeListingTypeState(event.isGrid));
  }

  void _onPageNumberChanged(SettingProductChangePageNumberEvent event, Emitter<SettingListingState> emit) {
    emit(const SettingProductReloadState());
    selectedPageNumber = event.pageNumber;
    emit(SettingProductChangePageNumberState());
  }
}
