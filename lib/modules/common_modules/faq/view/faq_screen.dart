import 'package:kgk/kgk.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FaqBloc faqBloc = BlocProvider.of<FaqBloc>(context);
    final FAQStyle style = AppTheme.of(context).faqStyle;
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.faqs.tr),
      body: SafeArea(
        child: SmartSingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.h),
                SmartText(APPStrings.frequentlyAskedQuestion.tr, style: style.titleStyle),
                SizedBox(height: 24.h),
                BlocBuilder<FaqBloc, FaqState>(
                  buildWhen: (previous, current) => current is FaqLoadedState,
                  builder: (context, state) {
                    return ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: faqBloc.faq.length,
                      itemBuilder: (_, index) => _buildFAQSection(faqBloc, style, index),
                      separatorBuilder: (_, index) => SizedBox(height: 24.h),
                    );
                  },
                ),
                SizedBox(height: 32.h),
                _buildStillNeedSection(style),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQSection(FaqBloc faqBloc, FAQStyle style, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (faqBloc.faq[index].title.isNotNullNorEmpty) SmartText(faqBloc.faq[index].title, style: style.subtitleStyle),
        ListView.separated(
          itemCount: faqBloc.faq[index].faqs?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, faqIndex) {
            final FAQ faq = faqBloc.faq[index].faqs![faqIndex];
            return SmartExpansionTile(
              title: SmartText(
                faq.question,
                style: style.questionStyle,
                optionalPadding: EdgeInsets.symmetric(vertical: 8.h),
              ),
              children: [
                SmartText(
                  faq.answer,
                  style: style.answerStyle,
                  optionalPadding: EdgeInsets.only(bottom: 17.h),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildStillNeedSection(FAQStyle style) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.stillNeedHelp.tr, style: style.titleStyle),
        SizedBox(height: 24.h),
        _buildStillNeedHelpItems(
          style,
          APPStrings.byPhone.tr,
          "Monday – Friday 9 AM – 5 PM",
          "+91 98765 43210",
        ),
        _buildStillNeedHelpItems(
          style,
          APPStrings.byEmail.tr,
          APPStrings.questionOrQueriesGetInTouch.tr,
          "support@kgk.com",
        ),
        _buildStillNeedHelpItems(
          style,
          APPStrings.findAStore.tr,
          APPStrings.findYourNearestXStore.tr.interpolate(['KGK']),
          APPStrings.storeDirectory.tr,
          onTap: () {
            //TODO: Navigate to Store Directory
          },
        ),
      ],
    );
  }

  Widget _buildStillNeedHelpItems(FAQStyle style, String title, String desc, String value, {VoidCallback? onTap}) {
    return Column(
      children: [
        SmartText(title, style: style.subtitleStyle),
        SizedBox(height: 16.h),
        SmartText(desc, style: style.contactDescriptionStyle),
        SizedBox(height: 8.h),
        SmartText(value, style: style.contactDetailsStyle, onTap: onTap),
        SizedBox(height: 24.h),
        const Divider(),
        SizedBox(height: 16.h),
      ],
    );
  }
}
