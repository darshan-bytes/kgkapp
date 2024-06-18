import 'package:kgk/kgk.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SupportBloc supportBloc = BlocProvider.of<SupportBloc>(context);
    final SupportScreenStyle style = AppTheme.of(context).supportScreenStyle;
    return Scaffold(
        appBar: SmartAppBar(
          isBack: false,
          leadingImage: "https://i.ibb.co/cyvpMrR/KGK-Group-Logo-1.png",
          onScan: () {},
          onFavorite: () {
            context.pushNamed(AppRoutes.wishListPage);
          },
          onNotification: () {},
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                _buildSupportActionSection(supportBloc),
                const Divider(),
                SizedBox(height: 32.h),
                SmartText(APPStrings.frequentlyAskedQuestion.tr, style: style.frequentlyAskedQuestionStyle),
                SizedBox(height: 16.h),
                _buildFAQSection(supportBloc, style),
              ],
            ),
          ),
        ));
  }

  Widget _buildSupportActionSection(SupportBloc supportBloc) {
    return ListView.separated(
      itemCount: supportBloc.supportActionList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SmartOptionTile(
          profileListModel: supportBloc.supportActionList[index],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Widget _buildFAQSection(SupportBloc supportBloc, SupportScreenStyle style) {
    return ListView.separated(
      itemCount: supportBloc.faqs.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final FAQ faq = supportBloc.faqs[index];
        return SmartExpansionTile(
          key: PageStorageKey<FAQ>(supportBloc.faqs[index]),
          trailingCollapsedIconVisible: true,
          title: SmartText(
            faq.question,
            style: style.questionStyle,
            optionalPadding: EdgeInsets.symmetric(vertical: 8.h),
          ),
          onExpansionChanged: (value) {
            // Handle expansion change if necessary
          },
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
    );
  }
}
