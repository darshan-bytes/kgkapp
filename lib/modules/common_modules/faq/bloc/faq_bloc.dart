import 'package:kgk/kgk.dart';

part 'faq_event.dart';

part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final TextEditingController searchController = TextEditingController();
  List<FaqWrapper> faq = [];

  FaqBloc() : super(FaqInitial()) {
    on<FaqInitialEvent>(_onInitialFaqListEvent);
  }

  void _onInitialFaqListEvent(FaqInitialEvent event, Emitter<FaqState> emit) {
    faq.clear();
    faq.add(FaqWrapper(title: APPStrings.generalQuestions.tr, faqs: [
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
        question: "Are your diamonds and gemstones ethically sourced and certified?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "How can I determine the quality and authenticity of the jewelry I purchase?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      )
    ]));
    faq.add(FaqWrapper(title: APPStrings.business.tr, faqs: [
      FAQ(
          question: "Are there any specific requirements needed to become an authorized seller of KGK's products?",
          answer:
              "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry."),
      FAQ(
        question: "Can you provide information about the discounts, and payment terms available for bulk purchases?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "What is your return policy for diamond and gemstone jewelry?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "Is there a minimum order quantity or value required to qualify for wholesale pricing on KGK's products?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      ),
      FAQ(
        question: "What is the registration process for becoming a B2B customer and selling KGK's products in bulk?",
        answer:
            "Yes, we provide customization options for some of our products, allowing you to customize aspects such as metal, diamond, ring heads, settings, and more to create a unique and personalized piece of jewelry.",
      )
    ]));
    emit(FaqLoadedState(faq));
  }
}
