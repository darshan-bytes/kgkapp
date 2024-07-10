import 'package:kgk/kgk.dart';

part 'contact_us_event.dart';

part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode commentFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  List<InquiryTypeModel> inquiryTypeList = [
    const InquiryTypeModel(id: 1, name: 'Bulk Order Discount'),
    const InquiryTypeModel(id: 2, name: 'Complaint'),
    const InquiryTypeModel(id: 3, name: 'Suggestion'),
  ];

  ProductModel? selectedProduct;
  InquiryTypeModel? selectedInquiryType;

  List<ProductModel> productList = [
    const ProductModel(id: 1, name: 'SKUC097973'),
    const ProductModel(id: 2, name: 'SKUC097944'),
    const ProductModel(id: 3, name: 'SKUC097955'),
  ];

  ContactUsBloc() : super(ContactUsInitial()) {
    on<ContactUsInitialEvent>(_onContactUsInitialEvent);
    on<ContactUsChangeInquiryTypeEvent>(_onChangeInquiryTypeEvent);
    on<ContactUsChangeSelectProductEvent>(_onChangeSelectProductEvent);
  }

  void _onContactUsInitialEvent(ContactUsInitialEvent event, Emitter<ContactUsState> emit) {
    emit(const ContactUsReloadState());
    selectedProduct = productList.first;
    selectedInquiryType = inquiryTypeList.first;
    emit(const ContactUsChangeInquiryTypeState());
    emit(const ContactUsChangeSelectProductState());
  }

  void _onChangeInquiryTypeEvent(ContactUsChangeInquiryTypeEvent event, Emitter<ContactUsState> emit) {
    emit(const ContactUsReloadState());
    selectedInquiryType = event.inquiryTypeModel;
    emit(const ContactUsChangeInquiryTypeState());
  }

  void _onChangeSelectProductEvent(ContactUsChangeSelectProductEvent event, Emitter<ContactUsState> emit) {
    emit(const ContactUsReloadState());
    selectedProduct = event.productModel;
    emit(const ContactUsChangeSelectProductState());
  }
}
