import 'package:kgk/kgk.dart';

part 'support_event.dart';

part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  List<ProfileListModel> supportActionList = [];
  List<FAQ> faqs = [];

  SupportBloc() : super(SupportInitial()) {
    on<SupportInitialEvent>(_onInitialSupportListEvent);
  }

  void _onInitialSupportListEvent(SupportInitialEvent event, Emitter<SupportState> emit) {
    supportActionList = [
      ProfileListModel(
        image: AppImages.icNote,
        title: APPStrings.makeAnInquiry.tr,
        subTitle: APPStrings.repliesWithin24Hours.tr,
        trailingIcon: AppImages.icArrowRight,
      ),
      ProfileListModel(
        image: AppImages.icPhone,
        title: APPStrings.call.tr,
        subTitle: "Monday – Friday 9 AM – 5 PM",
        trailingIcon: AppImages.icArrowRight,
      ),
      ProfileListModel(
        image: AppImages.icContactUs,
        title: APPStrings.contactUs.tr,
        subTitle: APPStrings.getInTouchWithUs.tr,
        trailingIcon: AppImages.icArrowRight,
      ),
    ];

    faqs = [
      FAQ(
          question: "Do you offer any customization options for diamond and gemstone jewelry?",
          answer:
              "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry."),
      FAQ(
        question: "What types of diamonds and gemstones do you offer?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "What types of diamonds and gemstones do you offer?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "How can I determine the quality and authenticity of the jewelry I purchase?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      )
    ];
  }
}
