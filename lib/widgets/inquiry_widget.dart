import 'package:kgk/kgk.dart';

class InquiryWidget extends StatelessWidget {
  const InquiryWidget({super.key, required this.phone, required this.email});

  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).inquiryWidgetStyle;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: colors(context).colorD3DAE0, width: 1), borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(
                  APPStrings.haveAQuestion.tr,
                  style: style.haveAQuestionStyle,
                ),
                const SizedBox(height: 8),
                SmartText(APPStrings.reachoutToOurExpert.tr, style: style.reachOutStyle),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const SmartImage(path: AppImages.icPhone),
                    const SizedBox(width: 8),
                    SmartText(phone, style: style.phoneStyle)
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const SmartImage(path: AppImages.icMail),
                    const SizedBox(width: 8),
                    SmartText(email, style: style.emailStyle),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 4),
            child: SmartImage(path: AppImages.icArrowRight, height: 16, width: 16),
          )
        ],
      ),
    );
  }
}
