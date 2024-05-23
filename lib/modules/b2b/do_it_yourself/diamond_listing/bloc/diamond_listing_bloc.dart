import 'package:kgk/kgk.dart';

part 'diamond_listing_event.dart';
part 'diamond_listing_state.dart';

class DiamondListingBloc extends Bloc<DiamondListingEvent, DiamondListingState> {
  bool isIndividual = true;
  bool isGrid = true;
  List<ProductDetails> productList = [];

  // List of numbers for the dropdown
  List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];

  // The selected number of pages, initialized to the first item
  String selectedPageNumber = '01';

  String diamondListingAppbarTitle = "DIY";

  DiamondListingBloc() : super(const DiamondListingInitial()) {
    on<GetDiamondProductListEvent>(_onGetDiamondProductListEvent);
    on<DiamondChangeTypeEvent>(_onDiamondChangeTypeEvent);
    on<ChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<ProductChangePageNumberEvent>(_onPageNumberChanged);
  }

  Future<void> _onGetDiamondProductListEvent(GetDiamondProductListEvent event, Emitter<DiamondListingState> emit) async {
    emit(const LoadingState());
    await Future.delayed(const Duration(seconds: 0), () {
    List.generate(20, (index) => productList.add( ProductDetails(
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl:
          "https://s3-alpha-sig.figma.com/img/9ebd/9517/705a51c9fc5153f1dfac36afd60d16c9?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CEg00oBHot6FBC0S~Jgw7iEpQ8mNWZVdQNorFxVAef310QMk5wmJYsAJm6gNWbd9YG-WSLNPc6Q9MAPEeXz2BgYTWjrTnkQWPWCgxqJswcHGQHgnZxMZmXM96HnkylNG17Pg~WURYovysiTsZS8p7H35ha09xWKBhxQvFf8Y6I5pyO2QTiPF-xHyabnzy~6lzTJXnXrEbKli7InPVL0hXMn1EDrTSMr4BAh1y0oZYzz-VQWRuFRn7mmyBpOhrkUrBMucWnlfpB9F3rz72aAqE898LfJTKfdSILEP41fI-fVdASU9sAMhm6b9XPwXvt-VjcU0PqEdDuUh8sAgW2fDGw__",
      name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
      originalPrice: "₹ 3,000",
    ),));
  });
  emit(const DiamondListingInitial());
  }

  void _onDiamondChangeTypeEvent(DiamondChangeTypeEvent event, Emitter<DiamondListingState> emit) {
    isIndividual = event.isIndividual;
    emit(DiamondChangeTypeState(isIndividual));
  }

  void _onChangeListingTypeEvent(ChangeListingTypeEvent event, Emitter<DiamondListingState> emit) {
    isGrid = event.isGrid;
    emit(ChangeListingTypeState(event.isGrid));
  }

  void _onPageNumberChanged(ProductChangePageNumberEvent event, Emitter<DiamondListingState> emit) {
    emit(ProductReloadState());
    selectedPageNumber = event.pageNumber;
    emit(ProductChangePageNumberState());
  }
}
