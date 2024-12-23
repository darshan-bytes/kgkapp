import 'package:kgk/kgk.dart';

part 'order_details_event.dart';

part 'order_details_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  UserType userType = UserType.b2cUser;

  String? orderNumber;

  // controllers
  final TextEditingController orderSearchController = TextEditingController();

  int currentTrackOrderIndex = 2;

  // Orders lists
  List<ProductDetailsModel> orderProductList = [];
  List<OrderDetailsProductModel> orderProductDetailsList = [];
  List<CancellationReasonModel> cancellationReasonsList = [];

  int get productListLength => userType == UserType.b2cUser ? orderProductList.length : orderProductDetailsList.length;
  CancellationReasonModel? selectedReason;

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  OrderDetailBloc() : super(const OrderDetailInitial()) {
    on<InitialOrderDetailEvent>(_onInitialOrderDetailEvent);
    on<OrderDetailChangeProductQuality>(_onOrderDetailChangeProductQuality);
    on<OrderDetailChangeProductQuantity>(_onOrderDetailChangeProductQuantity);
    on<OrderDetailRemoveProductEvent>(_onOrderDetailRemoveProduct);
    on<OrderCancellationReasonsEvent>(_onOrderCancellationReasonsChange);
    on<OrderDetailsLoadMoreProductsEvent>(_onLoadMoreProducts);
  }

  void _onInitialOrderDetailEvent(InitialOrderDetailEvent event, Emitter<OrderDetailState> emit) {
    emit(const OrderDetailReloadState());
    //TODO: Write code get Data from API
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    orderNumber = event.context.routesData?[RoutesData.orderNumber];
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    if (userType == UserType.b2bUser) {
      orderProductDetailsList = _generateOrdersDetailsProductList();
    } else {
      orderProductList = _generateOrdersDetailsList();
    }
    cancellationReasonsList = _generateCancellationReasonsList();
    paginationScrollController.init(loadAction: (int currentPage) async {
      add(OrderDetailsLoadMoreProductsEvent(currentPage));
    });
    emit(const OrderDetailsLoadedState());
  }

  void _onOrderDetailChangeProductQuality(OrderDetailChangeProductQuality event, Emitter<OrderDetailState> emit) {
    emit(const OrderDetailReloadState());
    if (orderProductList[event.index].productQuality?.name != event.productQuality.name) {
      orderProductList[event.index].productQuality = event.productQuality;
      emit(OrderDetailProductQualityChangedState(index: event.index, productQuality: event.productQuality));
    }
  }

  void _onOrderDetailChangeProductQuantity(OrderDetailChangeProductQuantity event, Emitter<OrderDetailState> emit) {
    emit(const OrderDetailReloadState());
    if (orderProductList[event.index].productQuantity?.name != event.productQuantity.name) {
      orderProductList[event.index].productQuantity = event.productQuantity;
      emit(OrderDetailProductQuantityChangedState(index: event.index, productQuantity: event.productQuantity));
    }
  }

  void _onOrderDetailRemoveProduct(OrderDetailRemoveProductEvent event, Emitter<OrderDetailState> emit) {
    emit(const OrderDetailReloadState());
    orderProductList.removeAt(event.index);
    emit(OrderDetailProductRemovedState(index: event.index));
  }

  Future<void> _onOrderCancellationReasonsChange(OrderCancellationReasonsEvent event, Emitter<OrderDetailState> emit) async {
    emit(const OrderDetailReloadState());
    selectedReason = event.cancellationReasonModel;
    if (selectedReason != null) {
      emit(OrderCancellationReasonsChangeState(selectedReason!));
    }
  }

  Future<void> _onLoadMoreProducts(OrderDetailsLoadMoreProductsEvent event, Emitter<OrderDetailState> emit) async {
    emit(const OrderDetailsLoadingMoreProductsState());
    await Future.delayed(const Duration(seconds: 2));
    if (userType == UserType.b2bUser) {
      orderProductDetailsList.addAll(_generateOrdersDetailsProductList());
    } else {
      orderProductList.addAll(_generateOrdersDetailsList());
    }
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(OrderDetailsLoadedMoreProductsState(event.currentPage + 1));
  }

  // Helper methods
  List<ProductDetailsModel> _generateOrdersDetailsList() {
    return List.generate(
      8,
      (index) => ProductDetailsModel(
        productId: index.toString(),
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/8xM4BxQ/image-7.png" : "https://i.ibb.co/zZ6y0w4/image-7-4.png",
        name: "DERC03RDA 1${index + 4}k White & Gold Engagement Ring",
        originalPrice: "\$2,300.00",
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
        cartProductQuantity: List.generate(99, (i) => CartProductQuantity(name: "$i")),
      ),
    );
  }

  List<CancellationReasonModel> _generateCancellationReasonsList() {
    return List.generate(
      3,
      (index) {
        if (index == 2) {
          return CancellationReasonModel(
            id: index,
            name: "Other",
          );
        } else {
          return CancellationReasonModel(
            id: index,
            name: "Reason ${index + 1}",
          );
        }
      },
    );
  }

  List<OrderDetailsProductModel> _generateOrdersDetailsProductList() {
    return List.generate(
      8,
      (index) => OrderDetailsProductModel(
        id: index.toString(),
        image: index % 2 == 0 ? "https://i.ibb.co/8xM4BxQ/image-7.png" : "https://i.ibb.co/zZ6y0w4/image-7-4.png",
        name: "Diamond Vine Ring in 18k Gold",
        price: "\$2,300.00",
        quantity: "${Random().nextInt(100)}",
        sku: "1254875",
        status: "orange_in_progress",
        brand: "Martin Flyer",
        deliveryDate: "12/12/2021",
      ),
    );
  }

  @override
  Future<void> close() {
    orderSearchController.dispose();
    paginationScrollController.dispose();
    return super.close();
  }
}
