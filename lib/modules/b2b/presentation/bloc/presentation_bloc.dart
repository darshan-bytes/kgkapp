import 'package:kgk/kgk.dart';

part 'presentation_event.dart';

part 'presentation_state.dart';

class PresentationBloc extends Bloc<PresentationEvent, PresentationState> {
  // Controller for search
  final TextEditingController presentationSearchController = TextEditingController();
  List<Presentation>? presentationDataList;

  /// This totalNumberOfPages is used to store the total number of pages
  int? totalNumberOfPages;

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  // List of Presentation
  List<B2BCustomListingDataModel> presentationList = [];

  // Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  PresentationBloc() : super(PresentationInitial()) {
    on<InitialPresentationEvent>(_onInitialPresentationEvent);
    on<PresentationLoadMoreEvent>(_onPresentationLoadMoreEvent);
    on<PresentationPullToRefreshEvent>(_onPresentationPullToRefreshEvent);
  }

  bool hasRouteData(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      presentationDataList = data[RoutesData.presentationList];
      return true;
    }
    return false;
  }

  Future<void> _onInitialPresentationEvent(InitialPresentationEvent event, Emitter<PresentationState> emit) async {
    emit(PresentationListReloadState());

    bool hasData = hasRouteData(event.context);
    presentationList = _generatePresentationList(presentationDataList);

    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }

    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }

    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(PresentationLoadMoreEvent(currentPage));
      },
    );
    clearData();
    refreshCompleter.complete(true);
    emit(PresentationLoadedState());
  }

  /// Build the complete query dynamically
  Map<String, dynamic> buildQuery({
    required List<FilterData> filterData,
    required String searchString,
    required int currentPage,
    required int pageLimit,
  }) {
    Map<String, dynamic> query = {};
    query[ApiKey.filters] = buildFilters(filterData);

    /// Add pagination, search, and sorting parameters
    query.addAll({
      ApiKey.pagination: {ApiKey.page: currentPage, ApiKey.limit: pageLimit},
      ApiKey.search: searchString,
      ApiKey.sort: {
        ApiKey.field: ApiKey.id,
        ApiKey.dir: AppConst.sortValueDesc.toUpperCase(),
      },
    });
    return query;
  }

  /// Build the filters dynamically
  Map<String, dynamic> buildFilters(List<FilterData> filterData) {
    Map<String, dynamic> filters = {ApiKey.dynamicObject: {}};

    for (FilterData element in filterData) {
      switch (element.filterType) {
        case FilterType.dateRange:
          if (element.dateRange != null) {
            filters[ApiKey.dynamicObject]?[element.code ?? ''] = [
              element.dateRange?.start.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD)
            ];
          }
          break;
        case FilterType.createdBySearch:
        case FilterType.checkbox:
          List<String?>? selectedCodes = element.secondaryFilterData?.where((e) => e.isSelected).map((e) => e.code).toList();
          if (selectedCodes != null && selectedCodes.isNotEmpty) {
            filters[ApiKey.dynamicObject]?[element.code ?? ''] = selectedCodes;
          }
          break;

        default:
          break;
      }
    }

    return filters;
  }

  List<B2BCustomListingDataModel> _generateB2BListingModel(List<Presentation> presentationList) {
    return presentationList.map(
      (concept) {
        // Use map and spread operator for cleaner list transformation
        // List<String> dummy = concept.files.map((file) => file['path'].toString().setMediaUrl).toList();
        List<String> dummy = [];
        return B2BCustomListingDataModel(
            id: concept.id,
            strConceptNumber: concept.conceptNumber,
            strConceptName: concept.conceptName,
            status: concept.status != null ? getOrderStatus(orderStatus: concept.status!) : null,
            fields: generateB2BItemFields(concept.assignedToDetails),
            strCreatedBy: '${concept.createdByDetails?['firstname'] ?? ''} ${concept.createdByDetails?['lastname'] ?? ''}',
            strCreatedByImageUrl: concept.createdByDetails?['profile_pic'],
            strCreatedOn: concept.createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
            strPresentationNumber: "-",
            strConceptBy: "-",
            strName: concept.conceptName,
            strDescription: '-',
            descriptionImageList: dummy,
            presentationList: [],
            strRevisedDate: concept.createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYY));
      },
    ).toList();
  }

  Future<void> _onPresentationLoadMoreEvent(PresentationLoadMoreEvent event, Emitter<PresentationState> emit) async {
    emit(const PresentationListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    presentationList.addAll(_generatePresentationList([]));
    paginationScrollController.isPageLoaded.complete(event.currentPage == 5);
    emit(PresentationListLoadedMoreState(event.currentPage + 1));
  }

  void clearData() {
    presentationSearchController.clear();
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  static List<B2BCustomListingDataModel> _generatePresentationList(List<Presentation>? presentationList) {
    if (presentationList == null) {
      return [];
    }
    return List.generate(presentationList.length, (index) {
      return B2BCustomListingDataModel(
        id: presentationList[index].id,
        strPresentationNumber: presentationList[index].presentationNumber,
        strProject: "1",
        strConceptNumber: presentationList[index].conceptNumber,
        strConceptName: presentationList[index].conceptName,
        strCreatedBy:
            '${presentationList[index].createdByDetails?['firstname'] ?? ''} ${presentationList[index].createdByDetails?['lastname'] ?? ''}',
        strCreatedByImageUrl: presentationList[index].createdByDetails?['profile_pic_url'].toString().setMediaUrl,
        strCreatedOn: presentationList[index].createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
        fields: generateB2BItemFields(presentationList[index].assignedToDetails),
        strApprovedBy:
            '${presentationList[index].approvedByDetails?['firstname'] ?? ''} ${presentationList[index].approvedByDetails?['lastname'] ?? ''}',
        strApprovedByImageUrl: presentationList[index].approvedByDetails?['profile_pic'] ?? '',
        status: presentationList[index].status != null ? getOrderStatus(orderStatus: presentationList[index].status!) : null,
      );
    });
  }

  static ProjectStatus getOrderStatus({required String orderStatus}) {
    print("Order Status: $orderStatus");
    switch (orderStatus) {
      case "approved":
        return ProjectStatus.approval;
      case "pending":
        return ProjectStatus.pending;
      case "completed":
        return ProjectStatus.completed;
      case "cancelled":
        return ProjectStatus.cancelled;
      case "in_progress":
        return ProjectStatus.orangeInProgress;
      default:
        return ProjectStatus.pending;
    }
  }

  static List<B2BItemField> generateB2BItemFields(List<Map<String, String>>? assignedToDetails) {
    if (assignedToDetails == null || assignedToDetails.isEmpty) {
      return [];
    }

    return assignedToDetails.map((detail) {
      String firstname = detail['firstname'] ?? '';
      String lastname = detail['lastname'] ?? '';
      String fullName = '$firstname $lastname'.trim();
      String imageUrl = detail['profile_pic'] ?? '';

      return B2BItemField(
        label: APPStrings.assignTo.tr,
        value: fullName,
        imageUrl: imageUrl,
      );
    }).toList();
  }

  Future<void> _onPresentationPullToRefreshEvent(PresentationPullToRefreshEvent event, Emitter<PresentationState> emit) async {
    emit(PresentationListReloadState());
    paginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    presentationList = _generatePresentationList([]);
    refreshCompleter.complete(true);
    emit(PresentationLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const PresentationPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
