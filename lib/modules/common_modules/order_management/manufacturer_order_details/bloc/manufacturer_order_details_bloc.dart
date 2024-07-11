import 'package:kgk/kgk.dart';

part 'manufacturer_order_details_event.dart';

part 'manufacturer_order_details_state.dart';

class ManufacturerOrderDetailsBloc extends Bloc<ManufacturerOrderDetailsEvent, ManufacturerOrderDetailsState> {
  TextEditingController searchController = TextEditingController();
  List<ManufacturerOrderDetailsModel> orderList = [];
  List<CancellationReasonModel> cancellationReasonsList = [];
  SmartPaginationScrollController scrollController = SmartPaginationScrollController();

  int currentTrackOrderIndex = 2;

  CancellationReasonModel? selectedReason;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.cancelOrderForRetailer;

  ManufacturerOrderDetailsBloc() : super(ManufacturerOrderDetailsInitial()) {
    on<ManufacturerOrderDetailsInitialEvent>(_manufacturerOrderDetailsInitialEvent);
    on<ManufacturerOrderDetailsLoadMoreEvent>(_manufacturerOrderDetailsLoadMoreEvent);
    on<ManufacturerOrderCancellationReasonsEvent>(_onManufacturerOrderCancellationReasonsChange);
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      screenIdentifier = data[RoutesData.isPageFor] ?? ScreenIdentifier.cancelOrderForRetailer;
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  Future<void> _manufacturerOrderDetailsLoadMoreEvent(
      ManufacturerOrderDetailsLoadMoreEvent event, Emitter<ManufacturerOrderDetailsState> emit) async {
    emit(ManufacturerOrderLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));

    orderList.addAll(List.generate(
        6,
        (index) => ManufacturerOrderDetailsModel(
              id: index.toString(),
              orderId: "MBFG716306",
              orderProductShape: "Marquise",
              orderProductImage: 'https://i.ibb.co/yfdTjFL/Frame-1410089200.png',
              orderProductCertificateNumber: "230000066395",
              orderProductMeasurements: "10.18 x 8.34 x 6.14",
              orderProductLab: "GIA",
              orderProductCt: "10.04",
              orderProductColour: "H",
              orderProductClarity: "VVS1",
              orderProductCut: "Excellent",
              orderProductRap: "\$35,500.00",
              orderProductDiscount: "-30.00",
              orderProductKgkAmount: "\$24,850.00",
              orderProductYourPercentage: "40",
              orderProductYourRate: "\$15,0600.00",
              orderProductYourValue: "\$24,850.00",
            )));

    scrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(ManufacturerOrderListLoadedState(event.currentPage + 1));
  }

  Future<void> _manufacturerOrderDetailsInitialEvent(
      ManufacturerOrderDetailsInitialEvent event, Emitter<ManufacturerOrderDetailsState> emit) async {
    scrollController.init(
      loadAction: (int currentPage) async {
        add(ManufacturerOrderDetailsLoadMoreEvent(currentPage: currentPage));
      },
    );

    getRouteData(event.context);

    emit(ManufacturerOrderReloadState());
    orderList = List.generate(
        10,
        (index) => ManufacturerOrderDetailsModel(
              id: index.toString(),
              orderId: "MBFG716306",
              orderProductShape: "Marquise",
              orderProductImage: 'https://i.ibb.co/yfdTjFL/Frame-1410089200.png',
              orderProductCertificateNumber: "230000066395",
              orderProductMeasurements: "10.18 x 8.34 x 6.14",
              orderProductLab: "GIA",
              orderProductCt: "10.04",
              orderProductColour: "H",
              orderProductClarity: "VVS1",
              orderProductCut: "Excellent",
              orderProductRap: "\$35,500.00",
              orderProductDiscount: "-30.00",
              orderProductKgkAmount: "\$24,850.00",
              orderProductYourPercentage: "40",
              orderProductYourRate: "\$15,0600.00",
              orderProductYourValue: "\$24,850.00",
            ));

    cancellationReasonsList = _generateCancellationReasonsList();
    emit(ManufacturerOrderDataFetchedState());
  }

  Future<void> _onManufacturerOrderCancellationReasonsChange(
      ManufacturerOrderCancellationReasonsEvent event, Emitter<ManufacturerOrderDetailsState> emit) async {
    emit(ManufacturerOrderReloadState());
    selectedReason = event.cancellationReasonModel;
    if (selectedReason != null) {
      emit(ManufacturerCancellationReasonsChangeState(selectedReason!));
    }
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
}
