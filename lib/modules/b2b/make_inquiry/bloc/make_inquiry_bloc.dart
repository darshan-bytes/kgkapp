import 'package:kgk/kgk.dart';

part 'make_inquiry_event.dart';

part 'make_inquiry_state.dart';

class MakeInquiryBloc extends Bloc<MakeInquiryEvent, MakeInquiryState> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController productController = TextEditingController();

  bool isInitialized = false;

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode commentFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode productFocusNode = FocusNode();
  final GlobalKey targetKey = GlobalKey();
  InquiryTypeModel? selectedInquiryType;
  StatusModel? selectedStatus;
  String? inquiryId;

  String? inquiryContextId;
  String? contextId;
  String? commodity;

  ScrollController productScrollController = ScrollController();

  List<InquiryTypeModel> inquiryTypeList = [];

  bool isUpdateInquiry = false;

  List<StatusModel> statusList = [
    StatusModel(id: 1, name: APPStrings.strNew.tr),
    StatusModel(id: 2, name: APPStrings.open.tr),
    StatusModel(id: 2, name: APPStrings.progress.tr),
    StatusModel(id: 2, name: APPStrings.close.tr),
  ];

  ProductModel? selectedProduct;

  List<ProductModel> productList = [
    const ProductModel(id: 1, name: 'SKUC097973'),
    const ProductModel(id: 2, name: 'SKUC097944'),
    const ProductModel(id: 3, name: 'SKUC097955'),
    const ProductModel(id: 4, name: 'SKUC097966'),
    const ProductModel(id: 5, name: 'SKUC097977'),
    const ProductModel(id: 6, name: 'SKUC097988'),
  ];

  MakeInquiryBloc() : super(MakeInquiryInitial()) {
    on<MakeInquiryInitialEvent>(_onMakeInquiryInitialEvent);
    on<ChangeInquiryTypeEvent>(_onChangeInquiryTypeEvent);
    on<ChangeSelectTypeEvent>(_onChangeSelectTypeEvent);
    on<ChangeSelectProductEvent>(_onChangeSelectProductEvent);
    on<MakeInquirySubmitEvent>(_onMakeInquirySubmitEvent);
  }

  Future<void> _onMakeInquiryInitialEvent(MakeInquiryInitialEvent event, Emitter<MakeInquiryState> emit) async {
    if (isInitialized) return;
    emit(MakeInquiryReloadState());
    isInitialized = true;
    setupInitialData();
    await fetchInquiryType(event.context);
    getArgumentsData(event.context);
    emit(const ToggleMakeInquiryState());
  }

  getArgumentsData(BuildContext context) {
    final routesData = context.routesData;
    B2BCustomListingDataModel? inquiryData = routesData?[RoutesData.inquiryData] as B2BCustomListingDataModel?;

    if (routesData?[RoutesData.inquiryContextId] != null &&
        routesData?[RoutesData.contextId] != null &&
        routesData?[RoutesData.commodity] != null) {
      inquiryContextId = routesData?[RoutesData.inquiryContextId] as String?;
      contextId = routesData?[RoutesData.contextId] as String?;
      commodity = routesData?[RoutesData.commodity] as String?;
    }

    if (inquiryData == null) {
      return;
    }
    isUpdateInquiry = true;
    inquiryId = inquiryData.strInquiryId;
    fullNameController.text = inquiryData.strName ?? '';
    emailController.text = inquiryData.strEmail ?? '';

    selectedInquiryType = inquiryTypeList.cast<InquiryTypeModel?>().firstWhere(
          (type) => type?.name == inquiryData.strType,
          orElse: () => null,
        );

    StatusModel? selectedStatus = statusList.cast<StatusModel?>().firstWhere(
          (status) => status?.name.toLowerCase() == inquiryData.status?.value,
          orElse: () => null,
        );

    if (selectedStatus != null) {
      this.selectedStatus = selectedStatus;
    }
  }

  setupInitialData() {
    UserIdDetails? userResponse = StorageManager().getUserData();
    fullNameController.text = userResponse?.fullName ?? '';
    emailController.text = userResponse?.email ?? '';
  }

  Future<void> fetchInquiryType(context) async {
    await AppRepository(context).fetchInquiryType().then((value) {
      value?.fold((l) {
        Utils.showMessage(l.message);
      }, (r) {
        List<String> list = r;
        for (int i = 0; i < list.length; i++) {
          inquiryTypeList.add(InquiryTypeModel(id: i, name: list[i]));
        }
      });
    });
  }

  void _onChangeInquiryTypeEvent(ChangeInquiryTypeEvent event, Emitter<MakeInquiryState> emit) {
    emit(MakeInquiryReloadState());
    selectedInquiryType = event.inquiryTypeModel;
    emit(const ToggleMakeInquiryState());
  }

  void _onChangeSelectTypeEvent(ChangeSelectTypeEvent event, Emitter<MakeInquiryState> emit) {
    emit(MakeInquiryReloadState());
    selectedStatus = event.statusModel;
    emit(const ToggleMakeInquiryState());
  }

  void _onChangeSelectProductEvent(ChangeSelectProductEvent event, Emitter<MakeInquiryState> emit) {
    emit(MakeInquiryReloadState());
    selectedProduct = event.productModel;
    emit(const ToggleProductState());
  }

  Future<void> _onMakeInquirySubmitEvent(MakeInquirySubmitEvent event, Emitter<MakeInquiryState> emit) async {
    emit(MakeInquiryReloadState());
    bool areAllFieldsValid = isAllFieldValid();
    if (areAllFieldsValid) {
      await apiCallForMakeInquirySubmission(event.context, event.inquiryId);
    }
    emit(const ToggleMakeInquiryState());
  }

  /// API call for make inquiry submission & update
  Future<void> apiCallForMakeInquirySubmission(BuildContext context, String? inquiryId) async {
    final params = {
      ApiKey.name: fullNameController.text,
      ApiKey.email: emailController.text,
      ApiKey.inquiryType: selectedInquiryType?.name,
      ApiKey.status: selectedStatus?.name.toUpperCase(),
      if (!isUpdateInquiry) ApiKey.comments: commentController.text, // Remove conditionally
    };

    if(inquiryContextId != null && contextId != null && commodity != null) {
      params[ApiKey.inquiryContextId] = inquiryContextId;
      params[ApiKey.contextId] = contextId;
      params[ApiKey.commodity] = commodity;
      params[ApiKey.comments] = commentController.text;
    }

    final repository = AppRepository(context);

    final response = isUpdateInquiry && inquiryId.isNotNullNorEmpty
        ? await repository.editMakeInquiry(body: params, inquiryId: inquiryId!)
        : await repository.submitMakeInquiry(body: params);

    response?.fold(
      (l) => Utils.showMessage(l.message),
      (r) {
        clearData();
        context.pop(arguments: {RoutesData.isInquiryUpdated: true});
        Utils.showMessage(r.message);
      },
    );
  }

  clearData() {
    selectedInquiryType = null;
    selectedStatus = null;
    selectedProduct = null;
    fullNameController.clear();
    emailController.clear();
    commentController.clear();
  }

  /// Validate all fields before submitting the form
  bool isAllFieldValid() {
    if (fullNameController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorFullNameRequired.tr);
      return false;
    } else if (emailController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.emailRequired.tr);
      return false;
    } else if (!Utils.isValidEmail(emailController.text)) {
      Utils.showMessage(APPStrings.validEmail.tr);
      return false;
    } else if (selectedInquiryType == null) {
      Utils.showMessage(APPStrings.errorSelectInquiryType.tr);
      return false;
    } else if (selectedStatus == null) {
      Utils.showMessage(APPStrings.errorSelectStatus.tr);
      return false;
    } else if (commentController.text.trim().isEmpty && !isUpdateInquiry) {
      Utils.showMessage(APPStrings.errorEnterComment.tr);
      return false;
    }
    return true;
  }

  void scrollToKey() {
    RenderBox? renderBox = targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        alignment: -100.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }
}
