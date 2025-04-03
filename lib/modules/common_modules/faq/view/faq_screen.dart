import 'package:kgk/kgk.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FaqBloc faqBloc = BlocProvider.of<FaqBloc>(context);
    final FAQStyle style = AppTheme.of(context).faqStyle;
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.faqs.tr),
      body: BlocBuilder<FaqBloc, FaqState>(
        buildWhen: (previous, current) => current is FaqLoadedState,
        builder: (context, state) {
          return SafeArea(
            child: faqBloc.isLoading
                ? SmartCircularProgressIndicator()
                : SmartSingleChildScrollView(
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 24.h),
                          SmartText(APPStrings.frequentlyAskedQuestion.tr, style: style.titleStyle),

                          /// Below code is commented as search functionality is not implemented in the API for now
                          /*SizedBox(height: 24.h),
                          SmartTextField(
                            controller: faqBloc.searchController,
                            suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsetsDirectional.all(14.w)),
                          ),*/
                          SizedBox(height: 16.h),
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
                          _buildStillNeedSection(context, style, faqBloc),
                        ],
                      ),
                    ),
                  ),
          );
        },
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
            if (faqBloc.faq[index].faqs == null && faqBloc.faq[index].faqs![faqIndex].question.isNullOrEmpty) {
              return const SizedBox.shrink();
            }
            final FAQ faq = faqBloc.faq[index].faqs![faqIndex];
            return SmartExpansionTile(
              onExpansionChanged: (value) {},
              title: SmartText(
                faq.question,
                style: style.questionStyle,
                optionalPadding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
              ),
              children: [
                SmartText(
                  faq.answer,
                  style: style.answerStyle,
                  optionalPadding: EdgeInsetsDirectional.only(bottom: 17.h),
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

  Widget _buildStillNeedHelpList(List<Support> supportList, FAQStyle style) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: supportList.length,
      itemBuilder: (context, index) {
        return _buildStillNeedHelpItems(
          style,
          supportList[index].title ?? '',
          supportList[index].description ?? '',
          supportList[index].action ?? '',
          onTap: () {
            /// Todo :: Implement the action
          },
        );
      },
    );
  }

  Widget _buildStillNeedSection(BuildContext context, FAQStyle style, FaqBloc bloc) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(bloc.stillNeedHelp, style: style.titleStyle),
        SizedBox(height: 10.h),
        _buildStillNeedHelpList(bloc.support, style),
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
        SizedBox(height: 16.h),
        const Divider(),
        SizedBox(height: 16.h),
      ],
    );
  }
}
