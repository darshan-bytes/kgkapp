import 'package:kgk/kgk.dart';

part 'contact_us_event.dart';

part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  bool isInitialized = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode commentFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  List<InquiryTypeModel> inquiryTypeList = [];

  ProductModel? selectedProduct;
  InquiryTypeModel? selectedInquiryType;

  bool isIndividual = true;
 // List<TextEditingController> contactNumberControllers = [TextEditingController()];

  TextEditingController contactNumberController = TextEditingController();

  // List<String?> contactNumberErrors = [null];
  // List<FocusNode> contactNumberFocusNodes = [FocusNode()];
  FocusNode contactNumberFocusNode = FocusNode();
  Country selectedCountry =
    Country.from(json: {
      "e164_cc": "91",
      "iso2_cc": "IN",
      "e164_sc": 0,
      "geographic": true,
      "level": 1,
      "name": "India",
      "example": "9123456789",
      "display_name": "India (IN) [+91]",
      "full_example_with_plus_sign": "+919123456789",
      "display_name_no_e164_cc": "India (IN)",
      "e164_key": "91-IN-0",
    })
  ;

  List<ProductModel> productList = [
    const ProductModel(id: 1, name: 'SKUC097973'),
    const ProductModel(id: 2, name: 'SKUC097944'),
    const ProductModel(id: 3, name: 'SKUC097955'),
  ];

  ContactUsBloc() : super(ContactUsInitial()) {
    on<ContactUsInitialEvent>(_onContactUsInitialEvent);
    on<ContactUsChangeInquiryTypeEvent>(_onChangeInquiryTypeEvent);
    on<ContactUsChangeSelectProductEvent>(_onChangeSelectProductEvent);
    on<ContactUsSubmitEvent>(_onSubmitEvent);
    on<ContactUsChangeCountryCodeEvent>(_onChangeCountryCodeEvent);
  }

  void _onChangeCountryCodeEvent(ContactUsChangeCountryCodeEvent event, Emitter<ContactUsState> emit) {
    emit(ContactUsReloadState());
    selectedCountry = event.country;
    emit(ContactUsFieldValidationState(fieldType: FieldTypeValidationEnum.contactNumber));
    emit(ContactUsChangeCountryCodeState(country: selectedCountry, index: event.index));
  }

  Future<void> _onContactUsInitialEvent(ContactUsInitialEvent event, Emitter<ContactUsState> emit) async {
    if (isInitialized) return;
    emit(const ContactUsReloadState());
    isInitialized = true;
    await fetchInquiryType(event.context, emit);
    emit(const ContactUsChangeInquiryTypeState());
    emit(const ContactUsChangeSelectProductState());
  }

  Future<void> fetchInquiryType(context, Emitter<ContactUsState> emit) async {
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

  Future<void> _onSubmitEvent(ContactUsSubmitEvent event, Emitter<ContactUsState> emit) async {
    if (!checkValidation(event.context, emit)) return;
    await submitContactUs(event.context, emit);
    emit(const ContactUsSubmitState());
  }

  Future<void> submitContactUs(context, Emitter<ContactUsState> emit) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, dynamic> params = {
      ApiKey.fullName: fullNameController.text,
      ApiKey.email: emailController.text,
      ApiKey.phone: "${selectedCountry.countryCode}${contactNumberController.text}",
      ApiKey.subject: "",
      ApiKey.message: commentController.text,
      ApiKey.inquiryType: selectedInquiryType?.name,
    };
    await AppRepository(context).submitContactUs(body: params).then((value) {
      value?.fold((l) {
        Utils.showMessage(l.message);
      }, (r) {
        clearData();
        Utils.showMessage(r.message);
        getNavigatorKeyContext.pop();
      });
    });
  }

  bool checkValidation(context, Emitter<ContactUsState> emit) {
    if (fullNameController.text.isEmpty) {
      Utils.showMessage(APPStrings.errorFullNameRequired.tr);
      return false;
    }
    if (emailController.text.isEmpty) {
      Utils.showMessage(APPStrings.emailRequired.tr);
      return false;
    }
    if (contactNumberController.text.isEmpty) {
      Utils.showMessage(APPStrings.errorContactNumberRequired.tr);
      return false;
    }
    if (selectedInquiryType == null) {
      Utils.showMessage(APPStrings.errorSelectInquiryType.tr);
      return false;
    }
    if (commentController.text.isEmpty) {
      Utils.showMessage(APPStrings.errorEnterYourComment.tr);
      return false;
    }
    emit(const ContactUsSubmitState());
    return true;
  }

  void clearData() {
    fullNameController.clear();
    commentController.clear();
    emailController.clear();
    selectedProduct = null;
    selectedInquiryType = null;
  }
}
