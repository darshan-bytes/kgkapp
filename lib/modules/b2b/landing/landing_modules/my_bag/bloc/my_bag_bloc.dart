import 'package:kgk/kgk.dart';

part 'my_bag_event.dart';

part 'my_bag_state.dart';

class MyBagBloc extends Bloc<MyBagEvent, MyBagState> {
  Commodity? commodity;
  BagListDataModel? bagListDataModel;
  List<CustomerSalesmanModel> salesmanList = [];
  BagOrderSummaryDataModel? bagOrderSummaryData;
  List<PlaceOrderProductRequest> placeOrderProductRequestList = [];

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

  List<ProductDetailsModel> myBagProductList = [];

  /*List<ProductDetailsModel> myBagProductList = List.generate(
    9,
    (index) => ProductDetailsModel(
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

      /// Added static Product id here as my bag screen listing data is static
      productId: "DIS10", //index.toString(),
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
      showMore: false,
    ),
  );*/
  List<ProductDetailsModel> suggestedProductList = [];

  /*List<ProductDetailsModel> suggestedProductList = List.generate(
    8,
    (index) => ProductDetailsModel(
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
      name: "2.00 Carat H VS1 Excellent Cut Round Setting",
      originalPrice: "\$3,000.00",
    ),
  );*/

  List<ProductDetailsModel> mostPurchaseProductList = [];

  /*List<ProductDetailsModel> mostPurchaseProductList = List.generate(
    8,
    (index) => ProductDetailsModel(
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl: 'https://i.ibb.co/8s6hWz2/image-414.png',
      name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
      originalPrice: "\$ 5,000.00",
    ),
  );*/

  List<PaymentCondition> paymentConditionList = [];

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
    on<MyBagToggleViewModeEvent>(_onMyBagToggleViewModeEvent);
    on<MyBagAddToWatchlistEvent>(_onMyBagAddToWatchlistEvent);
    on<MyBagRemovePromoCodeEvent>(_onMyBagRemovePromoCode);
    on<MyBagApplyPromoCodeEvent>(_onMyBagApplyPromoCode);
    on<MyBagCheckoutEvent>(_onMyBagCheckout);
    on<MyBagProductQuantityChangedEvent>(_onMyBagProductQuantityChanged);
    on<MyBagYourDiscountChangedEvent>(_onMyBagYourDiscountChanged);
    on<ClearMyBagEvent>(_onClearMyBag);
  }

  void _onMyBagToggleViewModeEvent(MyBagToggleViewModeEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    for (int i = 0; i < myBagProductList.length; i++) {
      myBagProductList[i].showMore = (i == event.index) ? !myBagProductList[i].showMore : false;
    }

    // if(myBagProductList[event.index].showMore != null) {
    //   myBagProductList[event.index].showMore = !myBagProductList[event.index].showMore!;
    // }
    emit(const MyBagToggleViewModeState());
  }

  Future<void> _onInitialMyBagEvent(InitialMyBagEvent event, Emitter<MyBagState> emit) async {
    emit(MyBagReloadState());
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    await fetchListOfBag(event.context, emit);
    emit(const MyBagLoadedState());
    if (myBagProductList.isEmpty) return;
    await fetchSalesmanList(event.context, emit);
    await fetchBagOrderSummaryData(event.context, emit);
    await getPaymentTermsFilter(event.context, emit);
  }

  /// TODO: In Future Implementation
  /// Fetch Bag Data Because Add Logic For Add To Bag
  Future<void> fetchListOfBag(BuildContext context, Emitter<MyBagState> emit, {bool isRetry = false}) async {
    String id = StorageManager().getBagId() ?? "";
    if (id.isNullOrEmpty) return;
    Either<ErrorResponse, BagListDataModel>? response;
    response = await AppRepository(context).getBagListData(id: id, isShowLoader: true);
    await response?.fold((l) {
      if (isRetry) {
        Utils.showMessage(l.message);
      }
    }, (r) async {
      if (r.isExpired == true) {
        await StorageManager().setBagId(r.bagId ?? '');
        await StorageManager().clearBagData();
        bagListDataModel = null;
        commodity = null;
        myBagProductList.clear();
        bagOrderSummaryData = null;
        await fetchListOfBag(context, emit, isRetry: true);
      } else {
        String? bagId = StorageManager().getBagId();
        myBagProductList.clear();
        bagListDataModel = r;
        if (r.result.isNotEmpty && bagId.isNotNullNorEmpty) {
          commodity = r.result.first.displayCommodity;
          MyBagDataModel myBagDataModel = MyBagDataModel(status: true, commodity: r.result.first.commodity, sId: bagId);
          await StorageManager().storeBagData(myBagDataModel);
          myBagProductList = List.generate(r.result.length, (index) {
            final item = r.result[index];

            return ProductDetailsModel(
              stockQty: item.stockQty,
              productId: item.productId,
              suid: item.suid,
              quantity: item.quantity,
              name: item.jewelleryName,
              commodity: item.displayCommodity,
              imageUrl: item.image,
              shape: item.shape,
              color: item.color,
              lotCode: item.lotCode,
              discountPercentage: item.discountPercentage != null
                  ? "-${item.discountPercentage == item.discountPercentage?.toInt() ? item.discountPercentage?.toInt() : item.discountPercentage?.toStringAsFixed(2)}"
                  : "",
              clarity: item.clarity,
              ctsOrGms: item.ctsOrGms,
              rappaportPrice: item.rappaportPrice,
              polish: item.polish,
              measurements: item.measurements,
              table: item.table,
              depth: item.depth,
              totalPrice: item.totalPrice?.toStringAsFixed(2),
              discountPrice: item.discountPrice?.toStringAsFixed(2),
              perCaratPrice: item.rate,
              openDnaUrl: item.openDnaUrl,
              certificateFile: item.certificateFile,
              fluorescence: item.fluorescence,
              shapeImage: item.shapeImage?.setMediaUrl,
              isOutOfStock: item.stockQty == 0,
              labs: item.labs,
              location: item.location,
              yourRate: item.yourRate,
              yourAmount: item.yourAmount,
              yourDiscount: item.yourDiscount,
            );
          });
        }
      }
    });
  }

  //getPaymentTermsFilter
  Future<void> getPaymentTermsFilter(BuildContext context, Emitter<MyBagState> emit) async {
    if (userType != UserType.b2bUser) return;
    final Map<String, dynamic> body = {
      ApiKey.filters: {
        ApiKey.dynamicObject: {},
      },
      ApiKey.pagination: {},
      ApiKey.search: "",
      ApiKey.sort: {
        ApiKey.field: ApiKey.id,
        ApiKey.dir: AppConst.sortValueDesc.toUpperCase(),
      },
    };
    Either<ErrorResponse, PaginationData<PaymentCondition>>? response = await AppRepository(context).getPaymentTermsFilter(body: body);
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (PaginationData<PaymentCondition> r) {
        List<PaymentCondition> paymentConditions = r.dataList as List<PaymentCondition>;
        paymentConditionList = paymentConditions;
        emit(MyBagPaymentConditionsLoadedState());
      },
    );
  }

  Future<void> fetchSalesmanList(BuildContext context, Emitter<MyBagState> emit) async {
    Either<ErrorResponse, List<CustomerSalesmanModel>>? response;
    response = await AppRepository(context).customerSalesman();
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        if (r.isNotEmpty) {
          salesmanList = r.where((element) => element.assignClient != null).toList();
          emit(MyBagSalesmanListLoadedState());
        }
      },
    );
  }

  Future<void> fetchBagOrderSummaryData(BuildContext context, Emitter<MyBagState> emit) async {
    String id = StorageManager().getBagId() ?? "";
    if (id.isNullOrEmpty) return;
    final response = await AppRepository(context).getBagOrderSummaryData(id: id);

    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        bagOrderSummaryData = r;
        emit(MyBagOrderSummaryDataLoadedState());
      },
    );
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

  Future<void> _onMyBagRemoveProduct(MyBagRemoveProductEvent event, Emitter<MyBagState> emit) async {
    emit(MyBagReloadState());
    String bagId = StorageManager().getBagId() ?? "";
    String suid = myBagProductList[event.index].suid ?? "";
    if (bagId.isEmpty || suid.isEmpty) return;
    final Map<String, dynamic> body = {
      ApiKey.id: bagId,
      ApiKey.suid: suid,
    };
    final result = await AppRepository(event.context).deleteBag(body: body);
    await result?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        await fetchListOfBag(event.context, emit);
        emit(const MyBagLoadedState());
        await fetchSalesmanList(event.context, emit);
        emit(MyBagSalesmanListLoadedState());
        await fetchBagOrderSummaryData(event.context, emit);
        emit(MyBagOrderSummaryDataLoadedState());
      },
    );

    // Temporary commented static logic
    // if (myBagProductList[event.index].isSelectedProduct) {
    //   selectedProductCount -= 1;
    // }
    // myBagProductList.removeAt(event.index);
    emit(MyBagProductRemovedState(index: event.index));
  }

  Future<void> _onMyBagAddToWatchlistEvent(MyBagAddToWatchlistEvent event, Emitter<MyBagState> emit) async {
    BlocProvider.of<AddToWatchlistBloc>(event.context).add(AddToWatchlistInitialEvent.add(myBagProductList[event.index], event.context));
    await Utils.showSmartModalBottomSheet(
      context: event.context,
      enableDrag: false,
      useRootNavigator: true,
      builder: (context) => const AddWatchlistScreen(),
    );
  }

  void _onMyBagSelectAllProductChangedEvent(MyBagSelectAllProductChangedEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    selectAllProduct = event.selectAllProduct;
    selectedProductCount = selectAllProduct ? myBagProductList.length : 0;
    for (ProductDetailsModel product in myBagProductList) {
      product.isSelectedProduct = selectAllProduct;
    }
    emit(MyBagSelectAllProductChangedState(selectAllProduct: selectAllProduct));
  }

  void _onMyBagSelectProductChangedEvent(MyBagSelectProductChangedEvent event, Emitter<MyBagState> emit) {
    emit(MyBagReloadState());
    final ProductDetailsModel product = myBagProductList[event.index];
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

  Future<void> _onMyBagRemovePromoCode(MyBagRemovePromoCodeEvent event, Emitter<MyBagState> emit) async {
    emit(MyBagReloadState());
    String id = StorageManager().getBagId() ?? "";
    if (id.isEmpty) return;
    event.context.setAppLoading(true);
    final response = await AppRepository(event.context).removePromoCode(bagId: id);
    await response?.fold(
      (l) {
        event.context.setAppLoading(false);
        Utils.showMessage(l.message);
      },
      (r) async {
        await fetchBagOrderSummaryData(event.context, emit);
        event.context.setAppLoading(false);
      },
    );
  }

  Future<void> _onMyBagApplyPromoCode(MyBagApplyPromoCodeEvent event, Emitter<MyBagState> emit) async {
    emit(MyBagReloadState());
    try {
      String id = StorageManager().getBagId() ?? "";
      if (id.isEmpty) return;
      event.context.setAppLoading(true);
      final Map<String, dynamic> body = {
        ApiKey.promoCode_: event.promoCode,
        ApiKey.cartId_: id,
      };
      final response = await AppRepository(event.context).applyPromoCode(body);
      await response?.fold(
        (l) {
          event.context.setAppLoading(false);
          Utils.showMessage(l.message);
        },
        (r) async {
          await fetchBagOrderSummaryData(event.context, emit);
          event.context.setAppLoading(false);
        },
      );
    } catch (e) {
      event.context.setAppLoading(false);
      Utils.showMessage(e.toString());
    }
  }

  Future<void> _handleCheckoutClick(BuildContext context) async {
    bool isAbleToCheckout = false;

    final response = await AppRepository(context).checkoutStatus();

    response?.fold(
      (l) {
        Utils.showMessage(l.message);
        isAbleToCheckout = false;
      },
      (r) {
        isAbleToCheckout = true;
      },
    );

    if (!isAbleToCheckout) {
      return;
    }

    if (userType == UserType.b2bUser) {
      placeOrderProductRequestList = List.generate(myBagProductList.length, (index) {
        ProductDetailsModel product = myBagProductList[index];
        return PlaceOrderProductRequest(
          name: product.name,
          image: product.imageUrl,
          suid: product.suid,
          quantity: product.quantity,
          discountPercentage: product.discountPercentage?.toDouble,
          yourDiscount: product.yourDiscount,
          yourRate: product.yourRate,
          yourAmount: product.yourAmount,
        );
      });
    }

    context.pushNamed(AppRoutes.addressListPage);
  }

  Future<void> _onMyBagCheckout(MyBagCheckoutEvent event, Emitter<MyBagState> emit) async {
    emit(MyBagReloadState());
    // Below code will be used in future implementation for B2B checkout
    // context.pushNamed(AppRoutes.addressListPage);
    await _handleCheckoutClick(event.context);
    emit(const MyBagCheckoutState());
  }

  Future<void> _onMyBagProductQuantityChanged(MyBagProductQuantityChangedEvent event, Emitter<MyBagState> emit) async {
    emit(MyBagReloadState());
    myBagProductList[event.index].quantity = event.quantity;
    emit(MyBagLoadedState());
    final Map<String, dynamic> body = {
      ApiKey.id: StorageManager().getBagId(),
      ApiKey.suid: myBagProductList[event.index].suid,
      ApiKey.quantity: event.quantity,
      ApiKey.commodity: myBagProductList[event.index].commodity?.value,
    };

    final response = await AppRepository(event.context).updateBagItem(body);
    await response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        await fetchBagOrderSummaryData(event.context, emit);
        emit(MyBagOrderSummaryDataLoadedState());
      },
    );
  }

  Future<void> _onMyBagYourDiscountChanged(MyBagYourDiscountChangedEvent event, Emitter<MyBagState> emit) async {
    emit(MyBagLoadedState());
    double percentage = event.yourDiscount.toDouble ?? 0.0;
    myBagProductList[event.index].yourDiscount = percentage;
    emit(MyBagLoadedState());
    final Map<String, dynamic> body = {
      ApiKey.id: StorageManager().getBagId(),
      ApiKey.suid: myBagProductList[event.index].suid,
      ApiKey.percentage: percentage,
      ApiKey.commodity: myBagProductList[event.index].commodity?.value,
    };

    final response = await AppRepository(event.context).updateBagItem(body);
    await response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        emit(MyBagLoadedState());
        await fetchListOfBag(event.context, emit);
        emit(MyBagLoadedState());
        await fetchBagOrderSummaryData(event.context, emit);
        emit(MyBagOrderSummaryDataLoadedState());
      },
    );
  }

  Future<void> _onClearMyBag(ClearMyBagEvent event, Emitter<MyBagState> emit) async {
    emit(MyBagReloadState());
    await StorageManager().clearBagData();
    bagListDataModel = null;
    commodity = null;
    myBagProductList.clear();
    salesmanList.clear();
    bagOrderSummaryData = null;
  }
}
