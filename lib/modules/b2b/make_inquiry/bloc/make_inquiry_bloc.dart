import 'package:kgk/kgk.dart';

part 'make_inquiry_event.dart';

part 'make_inquiry_state.dart';

class MakeInquiryBloc extends Bloc<MakeInquiryEvent, MakeInquiryState> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController productController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode commentFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode productFocusNode = FocusNode();
  final GlobalKey targetKey = GlobalKey();
  InquiryTypeModel? selectedInquiryType;
  StatusModel? selectedStatus;

  ScrollController productScrollController = ScrollController();

  List<InquiryTypeModel> inquiryTypeList = [
    const InquiryTypeModel(id: 1, name: 'Bulk Order Discount'),
    const InquiryTypeModel(id: 2, name: 'Complaint'),
    const InquiryTypeModel(id: 3, name: 'Suggestion'),
  ];

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

  void _onMakeInquiryInitialEvent(MakeInquiryInitialEvent event, Emitter<MakeInquiryState> emit) {
    emit(MakeInquiryReloadState());
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
    if(areAllFieldsValid) {
      await apiCallForMakeInquirySubmission();
    }
    emit(const ToggleMakeInquiryState());
  }

  Future<void> apiCallForMakeInquirySubmission() async{
    
  }

  /// Validate all fields before submitting the form
  bool isAllFieldValid() {
    // Text field validations
    final Map<String, String> textFields = {
      'full name': fullNameController.text,
      'email': emailController.text,
      'comment': commentController.text,
    };

    for (var entry in textFields.entries) {
      if (entry.value.isEmpty) {
        Utils.showMessage('Please enter your ${entry.key}');
        return false;
      }
    }

    // Dropdown/select validations
    final Map<String, dynamic> selectFields = {
      'inquiry type': selectedInquiryType,
      'status': selectedStatus,
      'product': selectedProduct,
    };

    for (var entry in selectFields.entries) {
      if (entry.value == null) {
        Utils.showMessage('Please select ${entry.key}');
        return false;
      }
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
