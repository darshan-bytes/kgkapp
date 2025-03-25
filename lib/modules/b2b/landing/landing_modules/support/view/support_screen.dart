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
          onNotification: () {
            context.pushNamed(AppRoutes.notificationPage);
          },
        ),
        body: BlocBuilder<SupportBloc, SupportState>(
          buildWhen: (previous, current) => current is SupportLoadedState || current is SupportLoadingState,
          builder: (context, state) {
            if (state is SupportLoadingState) {
              return const SmartCircularProgressIndicator();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 17.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    _buildSupportActionSection(supportBloc, context),
                    const Divider(),
                    SizedBox(height: 32.h),
                    if (supportBloc.faqs.isNotNullNorEmpty) ...[
                      SmartText(APPStrings.frequentlyAskedQuestion.tr, style: style.frequentlyAskedQuestionStyle),
                      SizedBox(height: 16.h),
                      _buildFAQSection(supportBloc, style),
                      SizedBox(height: 16.h),
                    ],
                    Center(
                      child: IntrinsicWidth(
                        child: SmartButton(
                          title: APPStrings.moreFaq.tr,
                          height: 40.h,
                          suffixImage: AppImages.icRight,
                          imageSize: 20.w,
                          padding: EdgeInsetsDirectional.only(start: 12.w),
                          onTap: () {
                            context.pushNamed(AppRoutes.faqPage);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _buildSupportActionSection(SupportBloc supportBloc, BuildContext context) {
    final SmartOptionTileStyle smartOptionTileStyle = AppTheme.of(context).smartOptionTileStyle;
    return ListView.separated(
      itemCount: supportBloc.supportActionList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SmartOptionTile(
          leadingImageColor: smartOptionTileStyle.primaryColor,
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
          title: SmartText(
            faq.question,
            style: style.questionStyle,
            optionalPadding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
          ),
          onExpansionChanged: (value) {},
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
    );
  }
}
