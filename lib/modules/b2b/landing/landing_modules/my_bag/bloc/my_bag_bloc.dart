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

  List<ProductDetailsModel> suggestedProductList = [];

  List<ProductDetailsModel> mostPurchaseProductList = [];

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
    on<MyBagMoveToWishListEvent>(_onMyBagMoveToWishListEvent);
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
        BlocProvider.of<LandingBloc>(context).add(LandingChangeMyBagCountEvent(r.result.length));
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
              discountPercentageString: item.discountPercentage != null && item.discountPercentage != 0
                  ? "-${item.discountPercentage == item.discountPercentage?.toInt() ? item.discountPercentage?.toInt() : item.discountPercentage?.toStringAsFixed(2)}"
                  : "",
              clarity: item.clarity,
              ctsOrGms: item.ctsOrGms,
              rappaportPrice: item.rappaportPrice,
              polish: item.polish,
              measurements: item.measurements,
              table: item.table,
              depth: item.depth,
              totalPrice: item.totalPrice,
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
              discountPercentage: item.discountPercentage,
              originalYourRate: item.originalYourRate,
              originalYourAmount: item.originalYourAmount,
              originalTotalPrice: item.originalTotalPrice,
              originalFinalPrice: item.originalFinalPrice,
              finalPrice: item.finalPrice?.setCurrency,
              originalPrice: item.totalPrice?.setCurrency,
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
    bool isConfirm = false;
    await Utils.showSmartModalBottomSheet(
      context: event.context,
      builder: (context) {
        return ConfirmationDialog(
          title: APPStrings.removeProductFromCart.tr,
          onDeniedText: APPStrings.cancel.tr,
          onApprovedText: APPStrings.remove.tr,
          onDenied: () {
            isConfirm = false;
            context.pop();
          },
          onApproved: () {
            isConfirm = true;
            context.pop();
          },
        );
      },
    );
    if (!isConfirm) return;
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

  Future<void> _onMyBagMoveToWishListEvent(MyBagMoveToWishListEvent event, Emitter<MyBagState> emit) async {
    BlocProvider.of<AppBloc>(event.context).add(ProductAddToFavoriteEvent(myBagProductList[event.index], event.context));
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
          discountPercentage: product.discountPercentage,
          yourDiscount: product.yourDiscount,
          yourRate: product.originalYourRate,
          yourAmount: product.originalYourAmount,
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
    BlocProvider.of<LandingBloc>(event.context).add(LandingChangeMyBagCountEvent(0));
  }
}
