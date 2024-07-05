import 'package:kgk/kgk.dart';

part 'my_bag_event.dart';

part 'my_bag_state.dart';

class MyBagBloc extends Bloc<MyBagEvent, MyBagState> {
  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  bool selectAllProduct = false;
  int selectedProductCount = 0;
  final ScrollController scrollController = ScrollController();
  final ScrollController mostPurchaseScrollController = ScrollController();

  int get totalProductCount => myBagProductList.length;

  String get selectedProductCountString => "$selectedProductCount/$totalProductCount";
  String inquiryEmail = "enquiry.diaind@kgkmail.com";
  String inquiryPhone = "+91 - 1234567830";

  // For Product menu bottom sheet
  bool showMoreDetails = false;
  String subTotalAmount = "\$90,000.00";

  List<ProductDetails> myBagProductList = List.generate(
    9,
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
      isDiamondProduct: index < 6,
      productId: index.toString(),
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: index < 3
          ? "https://i.ibb.co/8xM4BxQ/image-7.png"
          : index < 6
              ? "https://i.ibb.co/yBHHpVV/image-419.png"
              : "https://i.ibb.co/zZ6y0w4/image-7-4.png",
      name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
      originalPrice: "\$3,000.00",
      productQuality: const CartProductQuality(name: "18K Gold"),
      productQuantity: const CartProductQuantity(name: "1"),
      cartProductQuality: [
        const CartProductQuality(name: "18K Gold"),
        const CartProductQuality(name: "10K Gold"),
        const CartProductQuality(name: "14K Gold"),
        const CartProductQuality(name: "22K Gold"),
        const CartProductQuality(name: "28K Gold"),
        const CartProductQuality(name: "20K Gold"),
        const CartProductQuality(name: "24K Gold"),
        const CartProductQuality(name: "32K Gold"),
      ],
      cartProductQuantity: List.generate(100, (i) => CartProductQuantity(name: "$i")),
    ),
  );
  List<ProductDetails> suggestedProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
      name: "2.00 Carat H VS1 Excellent Cut Round Setting",
      originalPrice: "\$3,000.00",
    ),
  );

  List<ProductDetails> mostPurchaseProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl: 'https://i.ibb.co/8s6hWz2/image-414.png',
      name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
      originalPrice: "\$ 5,000.00",
    ),
  );

  List<PaymentCondition> paymentConditionList = [
    PaymentCondition(id: "1", title: "7 days"),
    PaymentCondition(id: "2", title: "15 days"),
    PaymentCondition(id: "3", title: "30 days"),
    PaymentCondition(id: "4", title: "45 days"),
    PaymentCondition(id: "5", title: "60 days"),
  ];

  PaymentCondition? selectedPaymentCondition;

  bool isReadMoreDetailsOpen = false;

  TextEditingController variationController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  FocusNode paymentConditionFocusNode = FocusNode();
  FocusNode variationFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();

  MyBagBloc() : super(MyBagInitial()) {
    on<InitialMyBagEvent>(_onInitialMyBagEvent);
    on<MyBagChangeProductQuality>(_onMyBagChangeProductQuality);
    on<MyBagChangeProductQuantity>(_onMyBagChangeProductQuantity);
    on<MyBagRemoveProductEvent>(_onMyBagRemoveProduct);
    on<MyBagSelectAllProductChangedEvent>(_onMyBagSelectAllProductChangedEvent);
    on<MyBagSelectProductChangedEvent>(_onMyBagSelectProductChangedEvent);
    on<ShowFullProductDetailsEvent>(_onShowFullProductDetailsEvent);
    on<MyBagPaymentConditionChangedEvent>(_onMyBagPaymentConditionChangedEvent);
    on<MyBagToggleReadMoreDetailsEvent>(_onMyBagToggleReadMoreDetailsEvent);
  }

  void _onInitialMyBagEvent(InitialMyBagEvent event, Emitter<MyBagState> emit) {
    userType = BlocProvider.of<AppBloc>(event.context).userType;
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

  void _onMyBagPaymentConditionChangedEvent(MyBagPaymentConditionChangedEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    selectedPaymentCondition = event.paymentCondition;
    emit(MyBagPaymentConditionChangedState(paymentCondition: selectedPaymentCondition!));
  }

  void _onMyBagToggleReadMoreDetailsEvent(MyBagToggleReadMoreDetailsEvent event, Emitter<MyBagState> emit) {
    isReadMoreDetailsOpen = !isReadMoreDetailsOpen;
    emit(MyBagToggleReadMoreDetailsState(isReadMoreDetailsOpen));
  }
}
