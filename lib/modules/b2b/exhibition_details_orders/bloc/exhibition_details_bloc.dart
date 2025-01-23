import 'package:kgk/kgk.dart';

part 'exhibition_details_event.dart';

part 'exhibition_details_state.dart';

class ExhibitionDetailsBloc extends Bloc<ExhibitionDetailsEvent, ExhibitionDetailsState> {
  /// Determines if the view is in grid or list mode
  bool isGrid = true;

  /// App bar title for the screen
  String appbarTitle = '';

  String exhibitionId = '';

  /// Identify Current user type
  UserType userType = UserType.b2cUser;

  /// For keeping track of the current tab and stop same tab on click event
  int currentTab = -1;

  /// TabController for managing tabs in the UI.
  late TabController tabController;

  /// List of tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.products.tr),
    Tab(text: APPStrings.orders.tr),
  ];

  /// The total number of filtered records
  int? totalFilteredRecords;

  /// Controller for managing pagination
  int? totalNumberOfPages;
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// List of exhibition products
  List<ProductDetailsModel> productList = [];

  /// List of exhibition orders
  List<B2BCustomListingDataModel> exhibitionOrdersList = [];

  /// Exhibition details
  ExhibitionListDataModel exhibitionDetails = ExhibitionListDataModel();
  ExhibitionProductDetailsDataModel exhibitionProductDetailsData = ExhibitionProductDetailsDataModel();

  ExhibitionDetailsBloc() : super(const ExhibitionDetailsInitialsState()) {
    on<ExhibitionDetailsInitialEvent>(_onInitialEvent);
    on<ExhibitionChangeTabsEvent>(_onChangeTabEvent);
    on<ExhibitionListingLoadMoreEvent>(_onExhibitionListingLoadMoreEvent);
    on<ExhibitionChangeListingTypeEvent>(_onExhibitionChangeListingTypeEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  /// Initializes the OrdersBloc by fetching order data
  Future<void> _onInitialEvent(ExhibitionDetailsInitialEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _initializeBloc(context: event.context, emit: emit);
  }

  /// Handles the ChangeOrderTabsEvent for tab switching
  Future<void> _onChangeTabEvent(ExhibitionChangeTabsEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _handleTabSelection(context: event.context, index: event.index, emit: emit);
  }

  /// Handles the load more event for order listings
  Future<void> _onExhibitionListingLoadMoreEvent(ExhibitionListingLoadMoreEvent event, Emitter<ExhibitionDetailsState> emit) async {
    // await _handleLoadMore(event.context, event.currentPage, emit);
  }

  /// Handles the change listing type event
  Future<void> _onExhibitionChangeListingTypeEvent(ExhibitionChangeListingTypeEvent event, Emitter<ExhibitionDetailsState> emit) async {
    _toggleViewType(isGridValue: event.isGrid, emit: emit);
  }

  Future<void> _initializeBloc({required Emitter<ExhibitionDetailsState> emit, required BuildContext context}) async {
    emit(const ExhibitionDetailsReloadState());

    /// Set the current user type.
    userType = BlocProvider.of<AppBloc>(context).userType;

    /// Extract exhibitionId number from route data.
    _getRouteData(context);

    /// Initialize pagination.
    _initializePagination(context);

    /// Fetch exhibition details
    await _getExhibitionDetails(context, exhibitionId);

    /// Fetch exhibition product details
    await _getExhibitionProductDetails(context, exhibitionId);

    /// Fetch exhibition product listing
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      /// Fetch exhibition product listing
    }
    emit(const ExhibitionDetailsLoadedState());
  }

  /// Extract exhibitionId number from route data.
  void _getRouteData(BuildContext context) {
    String exhibitionIdValue = context.routesData?[RoutesData.exhibitionId] ?? '';
    if (exhibitionIdValue.isNotNullNorEmpty) {
      exhibitionId = exhibitionIdValue;
    }
  }

  /// Initializes pagination for loading more order data
  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ExhibitionListingLoadMoreEvent(currentPage: currentPage, context: context));
      },
    );
  }

  /// Fetches the exhibition details data from the API
  Future<void> _getExhibitionDetails(BuildContext context, String id) async {
    Either<ErrorResponse, ExhibitionListDataModel>? response = await AppRepository(context).fetchExhibitionDetails(id: id);
    response?.fold(
      (error) => error.message.isNotNullNorEmpty ? Utils.showMessage(error.message) : null,
      (data) {
        /// Set the exhibition details.
        exhibitionDetails = data;
        appbarTitle = exhibitionDetails.name ?? '';
      },
    );
  }

  /// Fetches the exhibition product details data from the API
  Future<void> _getExhibitionProductDetails(BuildContext context, String id) async {
    Either<ErrorResponse, ExhibitionProductDetailsDataModel>? response = await AppRepository(context).fetchExhibitionProductDetails(id: id);
    response?.fold(
      (error) => error.message.isNotNullNorEmpty ? Utils.showMessage(error.message) : null,
      (data) => exhibitionProductDetailsData = data,
    );
  }

  /// Handles tab selection and reloads order data accordingly
  Future<void> _handleTabSelection(
      {required BuildContext context, required int index, required Emitter<ExhibitionDetailsState> emit}) async {
    if (currentTab == index) return;
    currentTab = index;
    emit(const ExhibitionDetailsReloadState());

    /// Reload order data
    // await _reloadOrderData(context, emit);
    emit(const ExhibitionChangeTabsState());
  }

  /// Toggle between grid and list view
  void _toggleViewType({bool isGridValue = false, required Emitter<ExhibitionDetailsState> emit}) {
    emit(const ExhibitionDetailsReloadState());
    isGrid = isGridValue;
    emit(const ExhibitionChangeListingTypeState());
  }
}
