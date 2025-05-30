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
    on<FetchOrderSummaryDataEvent>(_onFetchOrderSummaryData);
    on<MyBagRemoveAllProductEvent>(_onMyBagRemoveAllProductEvent);
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
    if (myBagProductList.isEmpty) {
      clearData();
      return;
    }
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
    await response?.fold(
      (l) {
        if (isRetry) {
          Utils.showMessage(l.message);
        }
      },
      (r) async {
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
          BlocProvider.of<LandingBloc>(
            context.mounted ? context : getNavigatorKeyContext,
          ).add(LandingChangeMyBagCountEvent(r.result.length));
          if (r.result.isNotEmpty && bagId.isNotNullNorEmpty) {
            commodity = r.result.first.displayCommodity;
            MyBagDataModel myBagDataModel = MyBagDataModel(status: true, commodity: r.result.first.commodity, sId: bagId);
            await StorageManager().storeBagData(myBagDataModel);
            myBagProductList = List.generate(r.result.length, (index) {
              final item = r.result[index];

              if (commodity != Commodity.diy) {
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
                  discountPercentageString:
                      item.discountPercentage != null && item.discountPercentage != 0
                          ? APPStrings.percentageOffInterpolating.tr.interpolate([
                            item.discountPercentage == item.discountPercentage?.toInt()
                                ? item.discountPercentage?.toInt()
                                : item.discountPercentage?.toStringAsFixed(2),
                          ])
                          : "",
                  cut: item.cut,
                  clarity: item.clarity,
                  ctsOrGms: item.ctsOrGms,
                  cts: item.crtEXT,
                  gms: item.gms,
                  rappaportPrice: item.rappaportPrice,
                  polish: item.polish,
                  symmetry: item.symmetry,
                  measurements: item.measurements,
                  table: item.table,
                  depth: item.depth,
                  totalPrice: item.totalPrice,
                  perCaratPrice: item.rate,
                  openDnaUrl: item.openDnaUrl,
                  certificateFile: item.certificateFile,
                  fluorescence: item.fluorescence,
                  shapeImage: item.shapeImage?.setMediaUrl,
                  isOutOfStock: userType == UserType.b2cUser ? (item.stockQty ?? 0) < (item.quantity ?? 0) : false,
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
                  originalPrice: item.finalPrice?.toString().setCurrency,
                  finalPrice: item.yourAmount?.toString().setCurrency,
                  video: item.video,

                  /// Below code is commented as backend API is changing the keys
                  // finalPrice: item.finalPrice?.setCurrency,
                  // originalPrice: item.totalPrice?.setCurrency,
                );
              } else {
                return ProductDetailsModel(
                  diyBagItemProductDetailsList: [
                    DiyBagItemProductDetailsModel(
                      productNameTitle: item.jewelleryData?.jewelleryName ?? '',
                      discountPrice: '',
                      finalPrice: '',
                      skuNo: item.jewelleryData?.productId,
                      icon: AppImages.icDIYRing,
                    ),
                    DiyBagItemProductDetailsModel(
                      icon: AppImages.icDIYDiamond,
                      skuNo: item.diamondData?.productId,
                      productNameTitle: item.diamondData?.jewelleryName ?? '',
                      discountPrice: item.yourAmount?.toString().setCurrency,
                      finalPrice: item.finalPrice?.toString().setCurrency,
                      discountPercentageString:
                          item.discountPercentage != null && item.discountPercentage != 0
                              ? APPStrings.percentageOffInterpolating.tr.interpolate([
                                item.discountPercentage == item.discountPercentage?.toInt()
                                    ? item.discountPercentage?.toInt()
                                    : item.discountPercentage?.toStringAsFixed(2),
                              ])
                              : "",
                    ),
                  ],

                  /// Here we are using 200 as static for B2B user as there is no limit for B2B user for order quantity
                  stockQty: item.stockQty,
                  productId: item.productId,
                  suid: item.suid,
                  quantity: item.quantity,
                  name: item.jewelleryData?.jewelleryName,
                  commodity: item.displayCommodity,
                  imageUrl: item.jewelleryData?.image,
                  shape: item.shape,
                  color: item.color,
                  lotCode: item.lotCode,
                  discountPercentageString:
                      item.discountPercentage != null && item.discountPercentage != 0
                          ? APPStrings.percentageOffInterpolating.tr.interpolate([
                            item.discountPercentage == item.discountPercentage?.toInt()
                                ? item.discountPercentage?.toInt()
                                : item.discountPercentage?.toStringAsFixed(2),
                          ])
                          : "",
                  cut: item.cut,
                  clarity: item.clarity,
                  ctsOrGms: item.ctsOrGms,
                  cts: item.crtEXT,
                  gms: item.gms,
                  rappaportPrice: item.rappaportPrice,
                  polish: item.polish,
                  measurements: item.measurements,
                  table: item.table,
                  depth: item.depth,
                  totalPrice: item.totalPrice,
                  perCaratPrice: item.rate,
                  openDnaUrl: item.openDnaUrl,
                  certificateFile: item.certificateFile,
                  fluorescence: item.fluorescence,
                  shapeImage: item.shapeImage?.setMediaUrl,
                  isOutOfStock: userType == UserType.b2cUser ? (item.stockQty ?? 0) < (item.quantity ?? 0) : false,
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
                  originalPrice: item.finalPrice?.toString().setCurrency,
                  finalPrice: item.yourAmount?.toString().setCurrency,
                  video: item.video,

                  /// Below code is commented as backend API is changing the keys
                  // finalPrice: item.finalPrice?.setCurrency,
                  // originalPrice: item.totalPrice?.setCurrency,
                );
              }
            });
          } else {
            await clearData();
          }
        }
      },
    );
  }

  //getPaymentTermsFilter
  Future<void> getPaymentTermsFilter(BuildContext context, Emitter<MyBagState> emit) async {
    if (userType != UserType.b2bUser) return;
    final Map<String, dynamic> body = {
      ApiKey.filters: {ApiKey.dynamicObject: {}},
      ApiKey.pagination: {},
      ApiKey.search: "",
      ApiKey.sort: {ApiKey.field: ApiKey.id, ApiKey.dir: AppConst.sortValueDesc.toUpperCase()},
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

  Future<void> fetchBagOrderSummaryData(BuildContext context, Emitter<MyBagState> emit, {VoidCallback? onSuccess}) async {
    emit(MyBagReloadState());
    String id = StorageManager().getBagId() ?? "";
    if (id.isNullOrEmpty) return;
    final response = await AppRepository(context).getBagOrderSummaryData(id: id);

    response?.fold(
      (l) {
        Utils.showMessage(l.message);
        emit(MyBagOrderSummaryDataLoadedState());
      },
      (r) {
        bagOrderSummaryData = r;
        emit(MyBagOrderSummaryDataLoadedState());
        onSuccess?.call();
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
    if (!event.isFromMoveToWishList) {
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
    }
    emit(MyBagReloadState());
    String bagId = StorageManager().getBagId() ?? "";
    String suid =
        (commodity == Commodity.customization
            ? bagListDataModel?.result[event.index].customizationId
            : myBagProductList[event.index].suid) ??
        "";
    if (bagId.isEmpty || suid.isEmpty) return;
    final Map<String, dynamic> body = {ApiKey.id: bagId, ApiKey.suid: suid};
    final result = await AppRepository(event.context).deleteBag(body: body);
    await result?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        if (myBagProductList.isEmpty) {}
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
    BlocProvider.of<AppBloc>(event.context).add(
      ProductAddToFavoriteEvent(
        myBagProductList[event.index],
        event.context,
        onFavTap: () {
          if (isClosed) return;
          add(MyBagRemoveProductEvent(index: event.index, context: event.context, isFromMoveToWishList: true));
        },
      ),
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

    selectAllProduct = selectedProductCount == myBagProductList.length;
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
      final Map<String, dynamic> body = {ApiKey.promoCode_: event.promoCode, ApiKey.cartId_: id};
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
    if (StorageManager().getIsSkipLogin()) {
      bool isApproved = false;
      await Utils.showLoginRequiredDialog(
        context,
        onApproved: () {
          isApproved = true;
        },
      );
      if (!isApproved) {
        return;
      }
      // TODO: We will create a new view to highlight the feature is restricted to logged in users.
      // Utils.showMessage(
      //     "${APPStrings.loginToUseThisFeature.tr}\nWe will create a new view to highlight the feature is restricted to logged in users");
      // return;
    }
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
    if (commodity != Commodity.customization &&
        (userType == UserType.b2cUser && event.quantity > (myBagProductList[event.index].stockQty ?? 0))) {
      Utils.showMessage(APPStrings.quantityExceedsStock.tr);
      return;
    }
    emit(MyBagReloadState());
    emit(MyBagLoadedState());
    final Map<String, dynamic> body = {
      ApiKey.id: StorageManager().getBagId(),
      ApiKey.suid:
          commodity == Commodity.customization ? bagListDataModel?.result[event.index].customizationId : myBagProductList[event.index].suid,
      ApiKey.quantity: event.quantity,
      ApiKey.commodity: myBagProductList[event.index].commodity?.value,
    };

    final response = await AppRepository(event.context).updateBagItem(body);
    await response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        myBagProductList[event.index].quantity = event.quantity;
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
    await clearData();
    BlocProvider.of<LandingBloc>(event.context).add(LandingChangeMyBagCountEvent(0));
  }

  Future<void> clearData() async {
    if (!StorageManager().getIsSkipLogin()) {
      await StorageManager().clearBagData();
    }

    bagListDataModel = null;
    commodity = null;
    myBagProductList.clear();
    salesmanList.clear();
    bagOrderSummaryData = null;
  }

  /// Using this event to fetch latest order summary data
  Future<void> _onFetchOrderSummaryData(FetchOrderSummaryDataEvent event, Emitter<MyBagState> emit) async {
    await fetchBagOrderSummaryData(event.context, emit);
  }

  Future<void> _onMyBagRemoveAllProductEvent(MyBagRemoveAllProductEvent event, Emitter<MyBagState> emit) async {
    bool isConfirm = false;
    await Utils.showSmartModalBottomSheet(
      context: event.context,
      builder: (context) {
        return ConfirmationDialog(
          title: APPStrings.removeAllProductFromCart.tr,
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

    if (bagId.isEmpty) return;
    final Map<String, dynamic> body = {ApiKey.id: bagId};
    final result = await AppRepository(event.context).deleteBag(body: body);
    await result?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        clearData();
        bagListDataModel = null;
        commodity = null;
        myBagProductList.clear();
        bagOrderSummaryData = null;
        salesmanList = [];
        bagOrderSummaryData = null;
        BlocProvider.of<LandingBloc>(event.context.mounted ? event.context : getNavigatorKeyContext).add(LandingChangeMyBagCountEvent(0));
        emit(const MyBagLoadedState());
        emit(MyBagSalesmanListLoadedState());
        emit(MyBagOrderSummaryDataLoadedState());
      },
    );
  }
}
