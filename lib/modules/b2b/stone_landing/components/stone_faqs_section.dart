import 'package:kgk/kgk.dart';

class StonesFAQSection extends StatelessWidget {
  final List<FAQ> faqs;
  final String title;
  final StonesLandingScreenStyle style;

  const StonesFAQSection({
    super.key,
    required this.faqs,
    required this.title,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 32.h),
      color: style.designYourOwnStoneBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(title, style: style.sectionLabelStyle),
          SizedBox(height: 8.h),
          ListView.separated(
            itemCount: faqs.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final FAQ faq = faqs[index];
              return SmartExpansionTile(
                title: SmartText(
                  faq.question,
                  optionalPadding: EdgeInsets.symmetric(vertical: 8.h),
                  style: style.designOwnEarringTextStyle,
                ),
                onExpansionChanged: (value) {
                  // Handle expansion change if necessary
                },
                children: [
                  SmartText(
                    faq.answer,
                    optionalPadding: EdgeInsets.only(bottom: 17.h),
                    style: style.originSectionSubTitleStyle,
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ],
      ),
    );
  }
}
