import 'package:kgk/kgk.dart';

part 'order_details_event.dart';

part 'order_details_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  /// The current user type (default is b2cUser).
  UserType userType = UserType.b2cUser;

  /// The order number for the current context.
  String orderNumber = "";

  /// Holds the order details response.
  PlaceOrderResponse? placeOrderResponse;

  /// Controller for searching orders.
  final TextEditingController orderSearchController = TextEditingController();

  /// Current track order index.
  int currentTrackOrderIndex = 2;

  /// List of products for B2C users.
  List<ProductDetailsModel> orderProductList = [];

  /// List of products for B2B users.
  List<OrderDetailsProductModel> orderProductDetailsList = [];

  /// Available cancellation reasons.
  List<CancellationReasonModel> cancellationReasonsList = [];

  /// Selected cancellation reason.
  CancellationReasonModel? selectedReason;

  /// Constructor initializing the Bloc with event handlers.
  OrderDetailBloc() : super(const OrderDetailInitial()) {
    on<InitialOrderDetailEvent>(_initializeOrderDetails);
    on<OrderDetailRemoveProductEvent>(_removeProduct);
    on<OrderCancellationReasonsEvent>(_updateCancellationReason);
  }

  /// Initialize order details based on context and load necessary data.
  Future<void> _initializeOrderDetails(InitialOrderDetailEvent event, Emitter<OrderDetailState> emit) async {
    emit(const OrderDetailsLoadingState());

    /// Set the current user type.
    userType = BlocProvider.of<AppBloc>(event.context).userType;

    /// Extract order number from route data.
    _getRouteData(event.context);

    /// Generate cancellation reasons.
    cancellationReasonsList = _generateCancellationReasonsList();

    /// Order details api call.
    await fetchOrderDetailsData(context: event.context, emit: emit, orderNumber: orderNumber);

    /// Emit loaded state after initialization.
    emit(const OrderDetailsLoadedState());
  }

  /// Extract order number from route data.
  void _getRouteData(BuildContext context) {
    String? routeOrderNumber = context.routesData?[RoutesData.orderNumber];
    if (routeOrderNumber.isNotNullNorEmpty) {
      orderNumber = routeOrderNumber ?? "";
    }
  }

  /// Handle removing a product from the order.
  Future<void> _removeProduct(OrderDetailRemoveProductEvent event, Emitter<OrderDetailState> emit) async {
    emit(const OrderDetailsLoadingState());
    orderProductList.removeAt(event.index);
    emit(OrderDetailProductRemovedState(index: event.index));
  }

  /// Update the selected cancellation reason.
  Future<void> _updateCancellationReason(OrderCancellationReasonsEvent event, Emitter<OrderDetailState> emit) async {
    emit(const OrderDetailsLoadingState());
    selectedReason = event.cancellationReasonModel;

    if (selectedReason != null) {
      emit(OrderCancellationReasonsChangeState(selectedReason!));
    }
  }

  /// Fetches the order list data from the API
  Future<void> fetchOrderDetailsData(
      {required BuildContext context, required Emitter<OrderDetailState> emit, required String orderNumber}) async {
    Either<ErrorResponse, CommonResponse<PlaceOrderResponse>>? response = await AppRepository(context).orderDetailsApiCall(id: orderNumber);
    response?.fold((error) {
      Utils.showMessage(error.message);
      emit(const OrderDetailsLoadedState());
    }, (CommonResponse<PlaceOrderResponse> success) {
      final responseData = success.responseData as List<PlaceOrderResponse>?;
      if (responseData.isNotNullNorEmpty) {
        placeOrderResponse = responseData?.first;
        if (userType == UserType.b2bUser) {
          orderProductDetailsList = _generateOrderDetailsProductListForB2B(orderProductList: placeOrderResponse?.products ?? []);
        } else {
          orderProductList = _generateOrderDetailsListForB2C(orderProductList: placeOrderResponse?.products ?? []);
        }
      }
      emit(const OrderDetailsLoadedState());
    });
  }

  /// Generate a list of product details for B2C users.
  List<ProductDetailsModel> _generateOrderDetailsListForB2C({required List<OrderProduct> orderProductList}) {
    return List.generate(
      orderProductList.length,
      (index) {
        final product = orderProductList[index];
        return ProductDetailsModel(
          productId: product.productProductId,
          imageUrl: product.image,
          name: product.productDescription,
          originalPrice: product.originalAmount,
          productQuality: CartProductQuality(name: product.discPercentage?.toString()),
          productQuantity: CartProductQuantity(name: product.quantity?.toString()),
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
          cartProductQuantity: List.generate(99, (i) => CartProductQuantity(name: "$i")),
        );
      },
    );
  }

  /// Generate a list of product details for B2B users.
  List<OrderDetailsProductModel> _generateOrderDetailsProductListForB2B({required List<OrderProduct> orderProductList}) {
    return List.generate(
      orderProductList.length,
      (index) {
        final product = orderProductList[index];
        return OrderDetailsProductModel(
          id: product.productProductId,
          image: product.image,
          name: product.productDescription,
          price: product.originalAmount?.setCurrency,
          quantity: product.quantity?.toString(),
          sku: product.productProductId,
          status: ProjectStatus.orangeInProgress.value,
          brand: product.productId,
          deliveryDate: "deliveryDate",
        );
      },
    );
  }

  /// Generate a list of cancellation reasons.
  List<CancellationReasonModel> _generateCancellationReasonsList() {
    return List.generate(
      3,
      (index) => CancellationReasonModel(
        id: index,
        name: index == 2 ? "Other" : "Reason ${index + 1}",
      ),
    );
  }
}
