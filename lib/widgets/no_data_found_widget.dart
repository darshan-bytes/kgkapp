import 'package:kgk/kgk.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String? text;
  final String? subText;
  final String? imagePath;
  final TextStyle? textStyle;
  final TextStyle? subTextStyle;
  final double? imageWidth;
  final double? imageHeight;

  const NoDataFoundWidget({
    super.key,
    this.text,
    this.subText,
    this.imagePath,
    this.textStyle,
    this.subTextStyle,
    this.imageWidth,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final NoDataFoundStyle style = AppTheme.of(context).noDataFoundStyle;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null) ...[
            SmartImage(
              path: imagePath!,
              width: imageWidth ?? 200.w,
              height: imageHeight ?? 200.w,
            ),
            SizedBox(height: 16.h),
          ],
          SmartText(
            text ?? APPStrings.noDataFound.tr,
            style: style.titleStyle.merge(textStyle),
            textAlign: TextAlign.center,
          ),
          if (subText != null) ...[
            SizedBox(height: 8.h),
            SmartText(
              subText!,
              style: style.subTitleStyle.merge(subTextStyle),
            ),
          ],
        ],
      ),
    );
  }
}
