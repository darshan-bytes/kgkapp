import 'package:kgk/kgk.dart';

part 'presentation_event.dart';

part 'presentation_state.dart';

class PresentationBloc extends Bloc<PresentationEvent, PresentationState> {
  bool _isInitialized = false;
  bool isNeedToReloadListOnBack = false;
  bool canPop = false;

  // Controller for search
  final TextEditingController presentationSearchController = TextEditingController();
  List<Presentation>? presentationDataList;

  UserType userType = UserType.b2cUser;

  /// This totalNumberOfPages is used to store the total number of pages
  int? totalNumberOfPages;

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  // List of Presentation
  List<B2BCustomListingDataModel> presentationList = [];

  // Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  PresentationBloc() : super(PresentationInitial()) {
    on<InitialPresentationEvent>(_onInitialPresentationEvent);
    on<PresentationReviewStateEvent>(_onPresentationReviewStateEvent);
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
    if (_isInitialized) return;
    _isInitialized = true;
    emit(PresentationListReloadState());

    userType = BlocProvider.of<AppBloc>(event.context).userType;

    hasRouteData(event.context);
    presentationList = _generatePresentationList(presentationDataList);

    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }

    paginationScrollController.init(loadAction: (_) {});
    clearData();

    emit(PresentationLoadedState());
  }

  List<B2BCustomListingDataModel> _generateB2BListingModel(List<Presentation> presentationList) {
    return presentationList.map((concept) {
      List<String> dummy = [];
      return B2BCustomListingDataModel(
        id: concept.id,
        strConceptNumber: concept.conceptNumber,
        strConceptName: concept.conceptName,
        status: concept.status != null ? getOrderStatus(orderStatus: concept.status!) : null,
        fields: generateB2BItemFields(concept.assignedToDetails),
        strCreatedBy: concept.createdByDetails?.fullName,
        strCreatedByImageUrl: concept.createdByDetails?.profilePic,
        strCreatedOn: concept.createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),

        strName: concept.conceptName,
        descriptionImageList: dummy,

        strRevisedDate: concept.createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYY),
      );
    }).toList();
  }

  // Event for approval
  Future<void> _onPresentationReviewStateEvent(PresentationReviewStateEvent event, Emitter<PresentationState> emit) async {
    emit(PresentationListReloadState());
    await apiCallForPresentationStatus(context: event.context, index: event.index, isApproved: event.isApproved);
    emit(PresentationLoadedState());
  }

  Future<void> apiCallForPresentationStatus({required BuildContext context, required int index, required bool isApproved}) async {
    Map<String, dynamic> body = {ApiKey.presentationNumber: presentationList[index].strPresentationNumber, ApiKey.status: ApiKey.approved};
    await AppRepository(context)
        .apiCallForPresentationStatus(body: body)
        .then(
          (value) => value?.fold(
            (l) {
              if (l.code == 403) {
                Utils.showMessage(l.message);
              }
            },
            (r) {
              presentationList[index].status = ProjectStatus.approved;
              isNeedToReloadListOnBack = true;
              return null;
            },
          ),
        );
    context.pop();
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
        strConceptNumber: presentationList[index].conceptNumber,
        strConceptName: presentationList[index].conceptName,
        strCreatedBy: presentationList[index].createdByDetails?.fullName,
        strCreatedByImageUrl: presentationList[index].createdByDetails?.profilePicUrl?.setMediaUrl,
        strCreatedOn: presentationList[index].createdAt?.toLocal().dateToStringFormat(
          outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA,
        ),
        fields: generateB2BItemFields(presentationList[index].assignedToDetails),
        strApprovedBy: presentationList[index].approvedByDetails?.fullName,
        strApprovedByImageUrl: presentationList[index].approvedByDetails?.profilePicUrl?.setMediaUrl,
        status: presentationList[index].status != null ? getOrderStatus(orderStatus: presentationList[index].status!) : null,
      );
    });
  }

  static ProjectStatus getOrderStatus({required String orderStatus}) {
    switch (orderStatus) {
      case "approved":
        return ProjectStatus.approved;
      case "pending":
        return ProjectStatus.pending;
      case "completed":
        return ProjectStatus.completed;
      case "cancelled":
        return ProjectStatus.cancelled;
      case "in_progress":
      case "inprogress":
        return ProjectStatus.orangeInProgress;
      default:
        return ProjectStatus.pending;
    }
  }

  static List<B2BItemField> generateB2BItemFields(List<UserIdDetails>? assignedToDetails) {
    if (assignedToDetails == null || assignedToDetails.isEmpty) {
      return [];
    }

    return assignedToDetails.map((detail) {
      String fullName = detail.fullName;
      String? imageUrl = detail.profilePicUrl?.setMediaUrl;

      return B2BItemField(label: APPStrings.assignTo.tr, value: fullName, imageUrl: imageUrl);
    }).toList();
  }

  void popWithData(BuildContext context) {
    canPop = true;
    context.pop(arguments: {RoutesData.isNeedToReloadListOnBack: isNeedToReloadListOnBack});
  }

  /// This method is used to pull to refresh but for now it is removed from the features
  // Future<void> _onPresentationPullToRefreshEvent(PresentationPullToRefreshEvent event, Emitter<PresentationState> emit) async {
  //   emit(PresentationListReloadState());
  //   paginationScrollController.pullToRefresh();
  //   await Future.delayed(const Duration(seconds: 1));
  //   presentationList = _generatePresentationList([]);
  //   refreshCompleter.complete(true);
  //   emit(PresentationLoadedState());
  // }

  /// This method is used to pull to refresh but for now it is removed from the features
  // Future<bool> pullToRefresh() async {
  //   if (!refreshCompleter.isCompleted) {
  //     return false;
  //   }
  //   refreshCompleter = Completer<bool>();
  //   add(const PresentationPullToRefreshEvent());
  //   bool result = await refreshCompleter.future;
  //   return result;
  // }
}
