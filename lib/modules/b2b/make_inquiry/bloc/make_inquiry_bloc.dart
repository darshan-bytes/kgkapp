import 'package:kgk/kgk.dart';

part 'make_inquiry_event.dart';

part 'make_inquiry_state.dart';

class MakeInquiryBloc extends Bloc<MakeInquiryEvent, MakeInquiryState> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode commentFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  InquiryTypeModel? selectedInquiryType;

  List<InquiryTypeModel> inquiryTypeList = [
    InquiryTypeModel(id: 1, name: 'Bulk Order Discount'),
    InquiryTypeModel(id: 2, name: 'Complaint'),
    InquiryTypeModel(id: 3, name: 'Suggestion'),
  ];

  ProductModel? selectedProduct;

  List<ProductModel> productList = [
    ProductModel(id: 1, name: 'SKUC097973'),
    ProductModel(id: 2, name: 'SKUC097944'),
    ProductModel(id: 3, name: 'SKUC097955'),
  ];

  MakeInquiryBloc() : super(MakeInquiryInitial()) {
    on<MakeInquiryEvent>((event, emit) {});
    on<MakeInquiryInitialEvent>(_onMakeInquiryInitialEvent);
    on<ChangeInquiryTypeEvent>(_onChangeInquiryTypeEvent);
    on<ChangeSelectProductEvent>(_onChangeSelectProductEvent);
  }

  void _onMakeInquiryInitialEvent(MakeInquiryInitialEvent event, Emitter<MakeInquiryState> emit) {
    selectedInquiryType = inquiryTypeList[0];
    selectedProduct = productList[0];
    emit(MakeInquiryReloadState());
  }

  void _onChangeInquiryTypeEvent(ChangeInquiryTypeEvent event, Emitter<MakeInquiryState> emit) {
    emit(MakeInquiryReloadState());
    selectedInquiryType = event.inquiryTypeModel;
    emit(const ToggleMakeInquiryState());
  }

  void _onChangeSelectProductEvent(ChangeSelectProductEvent event, Emitter<MakeInquiryState> emit) {
    emit(MakeInquiryReloadState());
    selectedProduct = event.productModel;
    emit(const ToggleProductState());
  }
}
