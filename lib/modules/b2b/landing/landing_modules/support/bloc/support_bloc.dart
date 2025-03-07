import 'package:kgk/kgk.dart';

part 'support_event.dart';

part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  List<ProfileListModel> supportActionList = [];
  List<FAQ> faqs = [];

  SupportBloc() : super(SupportInitial()) {
    on<SupportInitialEvent>(_onInitialSupportListEvent);
  }

  Future<void> _onInitialSupportListEvent(SupportInitialEvent event, Emitter<SupportState> emit) async {
    emit(SupportLoadingState());
    await _getFaqList(event.context);
    emit(SupportLoadedState());
    supportActionList = [
      ProfileListModel(
        image: AppImages.icNote,
        title: APPStrings.makeAnInquiry.tr,
        subTitle: APPStrings.repliesWithin24Hours.tr,
        trailingIcon: AppImages.icArrowRight,
        onTap: (context) {
          context.pushNamed(AppRoutes.makeInquiryPage);
        },
      ),
      ProfileListModel(
        image: AppImages.icPhone,
        title: APPStrings.call.tr,
        subTitle: APPStrings.workingHours.tr,
        trailingIcon: AppImages.icArrowRight,
        onTap: (context) {},
      ),
      ProfileListModel(
        image: AppImages.icContactUs,
        title: APPStrings.contactUs.tr,
        subTitle: APPStrings.getInTouchWithUs.tr,
        trailingIcon: AppImages.icArrowRight,
        onTap: (context) {
          context.pushNamed(AppRoutes.contactUsPage);
        },
      ),
    ];
  }

  Future<void> _getFaqList(BuildContext context) async {
    if (faqs.isNullOrEmpty) {
      final FaqBloc faqBloc = BlocProvider.of<FaqBloc>(context);
      await faqBloc.getFaqList(context);

      List<FaqWrapper> faqWrappers = faqBloc.faq;
      if (faqWrappers.isNotNullNorEmpty && faqWrappers.length > 1) {
        faqs = faqWrappers[1].faqs ?? [];
      }
    }
  }
}
