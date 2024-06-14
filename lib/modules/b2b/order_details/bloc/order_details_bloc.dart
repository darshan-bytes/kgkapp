import 'package:kgk/kgk.dart';

part 'order_details_event.dart';

part 'order_details_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  // controllers
  final TextEditingController orderSearchController = TextEditingController();

  // Dropdown and selection variables
  final List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];
  String selectedPageNumber = '01';
  int currentTrackOrderIndex = 2;

  // Orders lists
  List<ProductDetails> filteredOrdersDetailsList = _generateOrdersDetailsList();
  List<ProductDetails> originalOrdersDetailsList = _generateOrdersDetailsList();
  List<CancellationReasonModel> cancellationReasonsList = _generateCancellationReasonsList();

  CancellationReasonModel? selectedReason;

  OrderDetailBloc() : super(OrderDetailInitial()) {
    on<InitialOrderDetailEvent>(_onInitialOrderDetailEvent);
    on<OrderDetailChangeProductQuality>(_onOrderDetailChangeProductQuality);
    on<OrderDetailChangeProductQuantity>(_onOrderDetailChangeProductQuantity);
    on<OrderDetailRemoveProductEvent>(_onOrderDetailRemoveProduct);
    on<ChangeOrderDetailPageNumberEvent>(_onPageNumberChanged);
    on<FilterOrdersEvent>(_onFilterOrdersEvent);
    on<OrderCancellationReasonsEvent>(_onOrderCancellationReasonsChange);
  }

  void _onInitialOrderDetailEvent(InitialOrderDetailEvent event, Emitter<OrderDetailState> emit) {
    //TODO: Write code get Data from API
    emit(OrderDetailReloadState());
    clearData();
    emit(OrderDetailInitial());
  }

  void _onOrderDetailChangeProductQuality(OrderDetailChangeProductQuality event, Emitter<OrderDetailState> emit) {
    emit(OrderDetailReloadState());
    if (filteredOrdersDetailsList[event.index].productQuality?.name != event.productQuality.name) {
      filteredOrdersDetailsList[event.index].productQuality = event.productQuality;
      emit(OrderDetailProductQualityChangedState(index: event.index, productQuality: event.productQuality));
    }
  }

  void _onOrderDetailChangeProductQuantity(OrderDetailChangeProductQuantity event, Emitter<OrderDetailState> emit) {
    emit(OrderDetailReloadState());
    if (filteredOrdersDetailsList[event.index].productQuantity?.name != event.productQuantity.name) {
      filteredOrdersDetailsList[event.index].productQuantity = event.productQuantity;
      emit(OrderDetailProductQuantityChangedState(index: event.index, productQuantity: event.productQuantity));
    }
  }

  void _onOrderDetailRemoveProduct(OrderDetailRemoveProductEvent event, Emitter<OrderDetailState> emit) {
    emit(OrderDetailReloadState());
    filteredOrdersDetailsList.removeAt(event.index);
    emit(OrderDetailProductRemovedState(index: event.index));
  }

  void _onFilterOrdersEvent(FilterOrdersEvent event, Emitter<OrderDetailState> emit) {
    emit(OrderDetailReloadState());
    if (orderSearchController.text.isNotEmpty) {
      filteredOrdersDetailsList = originalOrdersDetailsList
          .where((ProductDetails element) => (element.name ?? '').toLowerCase().contains(orderSearchController.text.toLowerCase()))
          .toList();
    } else {
      filteredOrdersDetailsList = originalOrdersDetailsList;
    }
    emit(FilterOrdersState());
  }

  void _onPageNumberChanged(ChangeOrderDetailPageNumberEvent event, Emitter<OrderDetailState> emit) {
    emit(OrderDetailReloadState());
    selectedPageNumber = event.pageNumber;
    emit(ChangeOrderDetailPageNumberState());
  }

  void clearData() {
    orderSearchController.clear();
    filteredOrdersDetailsList = _generateOrdersDetailsList();
  }

  // Helper methods
  static List<ProductDetails> _generateOrdersDetailsList() {
    return List.generate(
      8,
      (index) => ProductDetails(
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

  static List<CancellationReasonModel> _generateCancellationReasonsList() {
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

  FutureOr<void> _onOrderCancellationReasonsChange(OrderCancellationReasonsEvent event, Emitter<OrderDetailState> emit) {
    emit(OrderDetailReloadState());
    selectedReason = event.cancellationReasonModel;
    if (selectedReason != null) {
      emit(OrderCancellationReasonsChangeState(selectedReason!));
    }
  }
}
