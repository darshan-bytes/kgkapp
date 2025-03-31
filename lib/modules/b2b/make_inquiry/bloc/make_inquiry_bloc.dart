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

  ScrollController productScrollController = ScrollController();

  List<InquiryTypeModel> inquiryTypeList = [];

  List<StatusModel> statusList = [
    const StatusModel(id: 1, name: 'New'),
    const StatusModel(id: 2, name: 'Open'),
    const StatusModel(id: 2, name: 'Progress'),
    const StatusModel(id: 2, name: 'Close'),
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
    emit(const ToggleMakeInquiryState());
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
      await apiCallForMakeInquirySubmission(event.context);
    }
    emit(const ToggleMakeInquiryState());
  }

  Future<void> apiCallForMakeInquirySubmission(BuildContext context) async {
    Map<String, dynamic> params = {
      ApiKey.name: fullNameController.text,
      ApiKey.email: emailController.text,
      ApiKey.inquiryType: selectedInquiryType?.name,
      ApiKey.status: selectedStatus?.name.toUpperCase(),
      ApiKey.comments: commentController.text,
    };

    await AppRepository(context).submitMakeInquiry(body: params).then((value) {
      value?.fold((l) {
        Utils.showMessage(l.message);
      }, (r) {
        context.pop();
        clearData();
        Utils.showMessage(r.message);
      });
    });
  }

  clearData(){
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
    } else if (commentController.text.trim().isEmpty) {
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
