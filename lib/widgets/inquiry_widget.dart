import 'package:kgk/kgk.dart';

class InquiryWidget extends StatelessWidget {
  const InquiryWidget({super.key, required this.phone, required this.email, this.title, this.description, this.isRightArrow = false});

  final String? title;
  final String? description;
  final bool isRightArrow;
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).inquiryWidgetStyle;
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: colors(context).colorD3DAE0, width: 1.w), borderRadius: BorderRadius.circular(8.r)),
      padding: EdgeInsets.all(16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(
                  title ?? APPStrings.haveAQuestion.tr,
                  style: style.haveAQuestionStyle,
                ),
                SizedBox(height: 8.h),
                SmartText(description ?? APPStrings.reachoutToOurExpert.tr, style: style.reachOutStyle),
                SizedBox(height: 12.h),
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
                    SizedBox(width: 8.w),
                    SmartText(email, style: style.emailStyle),
                  ],
                ),
              ],
            ),
          ),
          if (isRightArrow)
            Container(
              height: 32.w,
              width: 32.w,
              alignment: Alignment.center,
              child: SmartImage(path: AppImages.icArrowRight, height: 14.w, width: 14.w),
            )
        ],
      ),
    );
  }
}
