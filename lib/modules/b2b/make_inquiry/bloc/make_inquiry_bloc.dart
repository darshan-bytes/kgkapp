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

  ScrollController productScrollController = ScrollController();

  List<InquiryTypeModel> inquiryTypeList = [
    const InquiryTypeModel(id: 1, name: 'Bulk Order Discount'),
    const InquiryTypeModel(id: 2, name: 'Complaint'),
    const InquiryTypeModel(id: 3, name: 'Suggestion'),
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
    on<ChangeSelectProductEvent>(_onChangeSelectProductEvent);
  }

  void _onMakeInquiryInitialEvent(MakeInquiryInitialEvent event, Emitter<MakeInquiryState> emit) {
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
