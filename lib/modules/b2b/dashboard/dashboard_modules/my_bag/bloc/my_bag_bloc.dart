import 'package:kgk/kgk.dart';

part 'my_bag_event.dart';
part 'my_bag_state.dart';

class MyBagBloc extends Bloc<MyBagEvent, MyBagState> {
  bool selectAllProduct = false;
  int totalPrice = 35700;
  int selectedProductCount = 0;

  int get totalProductCount => myBagProductList.length;

  String get selectedProductCountString => "$selectedProductCount/$totalProductCount";
  String inquiryEmail = "enquiry.diaind@kgkmail.com";
  String inquiryPhone = "+91 - 1234567830";

  // For Product menu bottom sheet
  bool showMoreDetails = false;
  String subTotalAmount = "\$18000";

  List<ProductDetails> myBagProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamondClarityChart: DiamondClarityChart(
        ct: "10.04",
        shape: "Marquise",
        colour: "H",
        clarity: "VVS1",
        lotNumber: "MBFG716306",
        certificateNumber: "230000066395",
        measurements: "10.18 x 8.34 x 6.14",
        lab: "GIA",
        cut: "Excellent",
        polish: "Excellent",
        symmetry: "Excellent",
        flourish: "O",
        table: "50",
        depth: "50",
        rap: "\$35,500.00",
        discount: "-30.00",
        kgkAmount: "\$24,850.00",
        your: "40",
        yourRate: "\$15,0600.00",
        yourValue: "\$24,850.00",
      ),
      isDiamondProduct: index % 2 == 0,
      productId: index.toString(),
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl:
          "https://s3-alpha-sig.figma.com/img/9ebd/9517/705a51c9fc5153f1dfac36afd60d16c9?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CEg00oBHot6FBC0S~Jgw7iEpQ8mNWZVdQNorFxVAef310QMk5wmJYsAJm6gNWbd9YG-WSLNPc6Q9MAPEeXz2BgYTWjrTnkQWPWCgxqJswcHGQHgnZxMZmXM96HnkylNG17Pg~WURYovysiTsZS8p7H35ha09xWKBhxQvFf8Y6I5pyO2QTiPF-xHyabnzy~6lzTJXnXrEbKli7InPVL0hXMn1EDrTSMr4BAh1y0oZYzz-VQWRuFRn7mmyBpOhrkUrBMucWnlfpB9F3rz72aAqE898LfJTKfdSILEP41fI-fVdASU9sAMhm6b9XPwXvt-VjcU0PqEdDuUh8sAgW2fDGw__",
      name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
      originalPrice: "\$ 3,000",
      productQuality: const CartProductQuality(name: "18K Gold"),
      productQuantity: const CartProductQuantity(name: "1"),
      cartProductQuality: [
        const CartProductQuality(name: "18K Gold"),
        const CartProductQuality(name: "10K Gold"),
        const CartProductQuality(name: "14K Gold"),
        const CartProductQuality(name: "22K Gold"),
      ],
      cartProductQuantity: List.generate(100, (i) => CartProductQuantity(name: "$i")),
    ),
  );
  List<ProductDetails> suggestedProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl:
          "https://s3-alpha-sig.figma.com/img/9ebd/9517/705a51c9fc5153f1dfac36afd60d16c9?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CEg00oBHot6FBC0S~Jgw7iEpQ8mNWZVdQNorFxVAef310QMk5wmJYsAJm6gNWbd9YG-WSLNPc6Q9MAPEeXz2BgYTWjrTnkQWPWCgxqJswcHGQHgnZxMZmXM96HnkylNG17Pg~WURYovysiTsZS8p7H35ha09xWKBhxQvFf8Y6I5pyO2QTiPF-xHyabnzy~6lzTJXnXrEbKli7InPVL0hXMn1EDrTSMr4BAh1y0oZYzz-VQWRuFRn7mmyBpOhrkUrBMucWnlfpB9F3rz72aAqE898LfJTKfdSILEP41fI-fVdASU9sAMhm6b9XPwXvt-VjcU0PqEdDuUh8sAgW2fDGw__",
      name: "2.00 Carat H VS1 Excellent Cut Round Setting",
      originalPrice: "\$ 3,000",
    ),
  );

  MyBagBloc() : super(MyBagInitial()) {
    on<InitialMyBagEvent>(_onInitialMyBagEvent);
    on<MyBagChangeProductQuality>(_onMyBagChangeProductQuality);
    on<MyBagChangeProductQuantity>(_onMyBagChangeProductQuantity);
    on<MyBagRemoveProductEvent>(_onMyBagRemoveProduct);
    on<MyBagSelectAllProductChangedEvent>(_onMyBagSelectAllProductChangedEvent);
    on<MyBagSelectProductChangedEvent>(_onMyBagSelectProductChangedEvent);
    on<ShowFullProductDetailsEvent>(_onShowFullProductDetailsEvent);
  }

  void _onInitialMyBagEvent(InitialMyBagEvent event, Emitter<MyBagState> emit) {
    //TODO: Write code get Data from API
  }

  void _onMyBagChangeProductQuality(MyBagChangeProductQuality event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    if (myBagProductList[event.index].productQuality?.name != event.productQuality.name) {
      myBagProductList[event.index].productQuality = event.productQuality;
      emit(MyBagProductQualityChangedState(index: event.index, productQuality: event.productQuality));
    }
  }

  void _onMyBagChangeProductQuantity(MyBagChangeProductQuantity event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    if (myBagProductList[event.index].productQuantity?.name != event.productQuantity.name) {
      myBagProductList[event.index].productQuantity = event.productQuantity;
      emit(MyBagProductQuantityChangedState(index: event.index, productQuantity: event.productQuantity));
    }
  }

  void _onMyBagRemoveProduct(MyBagRemoveProductEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    if (myBagProductList[event.index].isSelectedProduct) {
      selectedProductCount -= 1;
    }
    myBagProductList.removeAt(event.index);
    emit(MyBagProductRemovedState(index: event.index));
  }

  void _onMyBagSelectAllProductChangedEvent(MyBagSelectAllProductChangedEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    selectAllProduct = event.selectAllProduct;
    selectedProductCount = selectAllProduct ? myBagProductList.length : 0;
    for (ProductDetails product in myBagProductList) {
      product.isSelectedProduct = selectAllProduct;
    }
    emit(MyBagSelectAllProductChangedState(selectAllProduct: selectAllProduct));
  }

  void _onMyBagSelectProductChangedEvent(MyBagSelectProductChangedEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    final ProductDetails product = myBagProductList[event.index];
    product.isSelectedProduct = !product.isSelectedProduct;
    if (product.isSelectedProduct) {
      selectedProductCount += 1;
    } else {
      selectedProductCount -= 1;
    }
    emit(MyBagSelectProductChangedState(index: event.index, isSelectedProduct: product.isSelectedProduct));
  }

  void _onShowFullProductDetailsEvent(ShowFullProductDetailsEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    showMoreDetails = !showMoreDetails;
    emit(ShowFullProductDetailsState());
  }
}
