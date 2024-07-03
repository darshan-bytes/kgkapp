import 'package:kgk/kgk.dart';

part 'manufacturer_order_listing_event.dart';

part 'manufacturer_order_listing_state.dart';

class ManufacturerOrderListingBloc extends Bloc<ManufacturerOrderListingEvent, ManufacturerOrderListingState> {
  //Controller for search
  final TextEditingController manufacturerOrderSearchController = TextEditingController();

  //List of orders
  List<B2BCustomListingDataModel> manufacturerOrderList = _generateManufacturerOrderList();

  //Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  ManufacturerOrderListingBloc() : super(ManufacturerOrderListingInitial()) {
    on<InitialManufacturerOrderListingEvent>(_onInitialManufacturerOrderListEvent);
    on<ManufacturerOrderListLoadMoreEvent>(_onManufacturerOrderListLoadMoreEvent);
  }

  void _onInitialManufacturerOrderListEvent(InitialManufacturerOrderListingEvent event, Emitter<ManufacturerOrderListingState> emit) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ManufacturerOrderListLoadMoreEvent(currentPage));
      },
    );
    clearData();
    emit(ManufacturerOrderListingLoadedState());
  }

  void clearData() {
    manufacturerOrderSearchController.clear();
    manufacturerOrderList = _generateManufacturerOrderList();
  }

  Future<void> _onManufacturerOrderListLoadMoreEvent(
      ManufacturerOrderListLoadMoreEvent event, Emitter<ManufacturerOrderListingState> emit) async {
    emit(const ManufacturerOrderListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    manufacturerOrderList.addAll(_generateManufacturerOrderList());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(ManufacturerOrderListLoadedMoreState(event.currentPage + 1));
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  static List<B2BCustomListingDataModel> _generateManufacturerOrderList() {
    return List.generate(10, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strProjectNumber: '1254875',
        strDesign: '1',
        strProjectName: 'Full blue moon',
        status: ProjectStatus.blueInProgress,
        strCustomer: 'Jenny Wilson',
        strCustomerImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        holdStatus: ProjectStatus.released,
        strCreatedOn: '23/03/2023, 10:46',
        strCreatedBy: 'Jenny Wilson',
        strCreatedByImageUrl: 'https://i.ibb.co/BLyLVHS/Frame-3978.png',
      );
    });
  }
}
