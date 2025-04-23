import 'package:kgk/kgk.dart';

part 'user_master_listing_event.dart';

part 'user_master_listing_state.dart';

class UserMasterListingBloc extends Bloc<UserMasterListingEvent, UserMasterListingState> {
  /// This controller is used to control the search
  final TextEditingController userMasterSearchController = TextEditingController();

  /// This list is used to show the digital catalogues in screen view
  List<B2BCustomListingDataModel> userMasterList = [];
  List<UserMasterListingModelClass> userMasterDataList = [];

  /// paginationScrollController is used to control the pagination
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// totalNumberOfPages is used to store the total number of pages
  int? totalNumberOfPages;

  /// Focus node is used to control the focus
  FocusNode focusNode = FocusNode();

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  /// This modulePermission is used to store the module permission
  PermissionData? modulePermission;

  /// This selectedUserLocationType is used to store the selected user location type
  UserLocationModel? selectedUserLocationType;

  // User Location types
  final List<UserLocationModel> userLocationTypeList = [
    UserLocationModel(name: "Location"),
    UserLocationModel(name: "Ahmedabad"),
    UserLocationModel(name: "Delhi"),
    UserLocationModel(name: "Mumbai"),
  ];

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  String? passwordError;
  String? confirmPasswordError;

  UserMasterListingBloc() : super(UserMasterListingInitial()) {
    on<InitialUserMasterListingEvent>(_onInitialUserMasterListEvent);
    on<UserMasterListLoadMoreEvent>(_onUserMasterListLoadMoreEvent);
    on<UserMasterListingPullToRefreshEvent>(_onUserMasterListingPullToRefreshEvent);
    on<UserMasterListingSearchEvent>(_onUserMasterListingSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<UserMasterChangeLocationTypeEvent>(_onUserMasterChangeLocationTypeEvent);
    on<UserMasterChangeStatusEvent>(_onUserMasterChangeStatus);
    on<UserMasterChangePasswordInitialEvent>(_onUserMasterChangePasswordInitial);
    on<UserMasterChangePasswordFieldChangeEvent>(_onChangePasswordFieldChangeEvent);
    on<UserMasterChangePasswordEvent>(_onUserMasterChangePasswordEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  Future<void> _onInitialUserMasterListEvent(InitialUserMasterListingEvent event, Emitter<UserMasterListingState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onUserMasterListLoadMoreEvent(UserMasterListLoadMoreEvent event, Emitter<UserMasterListingState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onUserMasterListingPullToRefreshEvent(
    UserMasterListingPullToRefreshEvent event,
    Emitter<UserMasterListingState> emit,
  ) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _onUserMasterListingSearchEvent(UserMasterListingSearchEvent event, Emitter<UserMasterListingState> emit) async {
    emit(UserMasterLoadingState());
    paginationScrollController.pullToRefresh();
    userMasterList.clear();
    await _fetchUserMasterList(event.context, emit, isLoadMore: false, searchString: userMasterSearchController.text.trim());
    if (userMasterSearchController.text.isNotNullNorEmpty) focusNode.requestFocus();
    emit(UserMasterListingLoadedState());
  }

  /// Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<UserMasterListingState> emit) async {
    emit(UserMasterLoadingState());
    _fetchModulePermission();
    _initializePagination(context);
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await _fetchUserMasterList(context, emit, isLoadMore: false);
    }
    selectedUserLocationType = userLocationTypeList.first;
    emit(UserMasterListingLoadedState());
  }

  void _fetchModulePermission() async {
    PermissionData? permission = Utils.getPermissionByModuleName(moduleName: ModuleKey.users);
    if (permission != null) {
      modulePermission = permission;
    }
  }

  /// Initialize pagination
  void _initializePagination(BuildContext context) {
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
    }

    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(UserMasterListLoadMoreEvent(context: context, currentPage: currentPage));
      },
    );
  }

  void _onUserMasterChangeLocationTypeEvent(UserMasterChangeLocationTypeEvent event, Emitter<UserMasterListingState> emit) {
    emit(UserMasterListReloadState());
    selectedUserLocationType = event.selectedUserLocationType;
    if (selectedUserLocationType != null) {
      emit(UserMasterChangeLocationTypeState(selectedUserLocationType!));
    }
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
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
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
      ApiKey.sort: {ApiKey.field: ApiKey.id, ApiKey.dir: AppConst.sortValueDesc.toUpperCase()},
    });
    return query;
  }

  /// Fetch digital catalogue data
  Future<void> _fetchUserMasterList(
    BuildContext context,
    Emitter<UserMasterListingState> emit, {
    bool isLoadMore = false,
    Map<String, dynamic>? query,
    String searchString = '',
  }) async {
    /// Build the query dynamically
    query = buildQuery(
      filterData: filterData,
      searchString: searchString,
      currentPage: paginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );

    Either<ErrorResponse, PaginationData<UserMasterListingModelClass>>? response = await AppRepository(
      context,
    ).staffUserMasterListApiCall(body: query, isLoadMore: isLoadMore);

    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (PaginationData<UserMasterListingModelClass> success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        userMasterDataList = success.dataList ?? [];
        userMasterList = _populateUserMasterList(userMasterDataList);
        paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      },
    );
    emit(UserMasterListingLoadedState());
  }

  List<B2BCustomListingDataModel> _populateUserMasterList(List<UserMasterListingModelClass> dataList) {
    List<B2BCustomListingDataModel> data = [];
    for (UserMasterListingModelClass staffUser in dataList) {
      data.add(
        B2BCustomListingDataModel(
          id: staffUser.id,
          strName: staffUser.customerUser?.fullName,
          strNameImageUrl: staffUser.customerUser?.profilePicUrl?.setMediaUrl,
          strBusinessType: staffUser.businessType,

          ///TODO: Need to discuss with backend team
          // strBusinessTypeImageUrl: AppImages.icDiamond,
          strCompanyRepresentative: staffUser.customerUser?.customerOrg?.name,
          strMarket: "New York, USA",

          ///TODO: Need to discuss with backend team
          // strMarketFlagImageUrl: AppImages.icFlagUSA,
          strEmail: staffUser.email,
        ),
      );
    }
    return data;
  }

  /// Handle load more
  Future<void> _handleLoadMore(BuildContext context, Emitter<UserMasterListingState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(UserMasterListLoadingMoreState());
      await _fetchUserMasterList(context, emit, isLoadMore: false);
      emit(UserMasterListLoadedMoreState(currentPage));
    }
  }

  /// Handle pull to refresh
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<UserMasterListingState> emit) async {
    emit(UserMasterListReloadState());
    paginationScrollController.pullToRefresh();
    userMasterList.clear();
    await _fetchUserMasterList(context, emit, isLoadMore: false);
    emit(UserMasterListingLoadedState());
  }

  Future<void> _onUserMasterChangeStatus(UserMasterChangeStatusEvent event, Emitter<UserMasterListingState> emit) async {
    emit(UserMasterListReloadState());
    if (userMasterDataList.isNotEmpty) {
      bool status = userMasterDataList[event.index].status;
      String id = userMasterDataList[event.index].id ?? '';
      if (id.isNotNullNorEmpty) {
        Map<String, dynamic> body = {ApiKey.status: !status};
        Either<ErrorResponse, CommonResponse>? response = await AppRepository(event.context).updateUserStatus(id, body: body);
        await response?.fold(
          (error) {
            Utils.showMessage(error.message);
          },
          (success) async {
            emit(UserMasterLoadingState());
            paginationScrollController.pullToRefresh();
            userMasterList.clear();
            await _fetchUserMasterList(event.context, emit, isLoadMore: false);
            emit(UserMasterListingLoadedState());
          },
        );
      }
    }
  }

  void _onUserMasterChangePasswordInitial(UserMasterChangePasswordInitialEvent event, Emitter<UserMasterListingState> emit) {
    emit(UserMasterListReloadState());
    newPasswordController.clear();
    confirmPasswordController.clear();
    passwordError = null;
    confirmPasswordError = null;
    newPasswordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
  }

  void _onChangePasswordFieldChangeEvent(UserMasterChangePasswordFieldChangeEvent event, Emitter<UserMasterListingState> emit) {
    emit(UserMasterListReloadState());
    switch (event.fieldType) {
      case FieldTypeValidationEnum.password:
        passwordError = null;
        break;
      case FieldTypeValidationEnum.confirmPassword:
        confirmPasswordError = null;
        break;
      default:
        break;
    }
    emit(UserMasterChangePasswordFieldErrorState(fieldType: event.fieldType));
  }

  Future<void> _onUserMasterChangePasswordEvent(UserMasterChangePasswordEvent event, Emitter<UserMasterListingState> emit) async {
    emit(UserMasterListReloadState());
    if (_validateChangePassword(emit)) {
      await _callChangePasswordApi(event: event);
    }
  }

  bool _validateChangePassword(Emitter<UserMasterListingState> emit) {
    bool isValidate = true;

    if (newPasswordController.text.trim().isEmpty) {
      passwordError = APPStrings.errorPasswordRequired.tr;
      emit(UserMasterChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.password));
      isValidate = false;
    } else if (!Utils.isValidPassword(newPasswordController.text.trim())) {
      passwordError = APPStrings.validPassword.tr;
      emit(UserMasterChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.password));
      isValidate = false;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      confirmPasswordError = APPStrings.errorConfirmPasswordRequired.tr;
      emit(UserMasterChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.confirmPassword));
      isValidate = false;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      confirmPasswordError = APPStrings.errorPasswordNotMatch.tr;
      emit(UserMasterChangePasswordFieldErrorState(fieldType: FieldTypeValidationEnum.confirmPassword));
      isValidate = false;
    }
    return isValidate;
  }

  Future<void> _callChangePasswordApi({required UserMasterChangePasswordEvent event}) async {
    final Map<String, dynamic> params = {
      ApiKey.isAdminChange: true,
      ApiKey.userId: userMasterDataList[event.index].id?.toInt,
      ApiKey.newPassword: newPasswordController.text.trim(),
      ApiKey.oldPassword: null,
    };
    event.context.setAppLoading(true);

    Either<ErrorResponse, CommonResponse>? response = await UserRepository(event.context).changePasswordApi(params);
    event.context.setAppLoading(false);
    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (success) async {
        add(UserMasterChangePasswordInitialEvent());
        event.context.pop();
        await Utils.showMessage(success.message);
      },
    );
  }
}
