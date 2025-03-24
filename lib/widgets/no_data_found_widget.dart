import 'package:kgk/kgk.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String? text;
  final String? subText;
  final String? imagePath;
  final TextStyle? textStyle;
  final TextStyle? subTextStyle;
  final double? imageWidth;
  final double? imageHeight;
  final VoidCallback? onRetry;
  final String? retryText;

  const NoDataFoundWidget({
    super.key,
    this.text,
    this.subText,
    this.imagePath,
    this.textStyle,
    this.subTextStyle,
    this.imageWidth,
    this.imageHeight,
    this.onRetry,
    this.retryText,
  });

  @override
  Widget build(BuildContext context) {
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
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          if (subText != null) ...[
            SizedBox(height: 8.h),
            SmartText(
              subText!,
              style: subTextStyle,
            ),
          ],
          if (onRetry != null) ...[
            SizedBox(height: 16.h),
            SmartButton(
              title: retryText ?? APPStrings.retry.tr,
              onTap: () => onRetry?.call(),
            ),
          ],
        ],
      ),
    );
  }
}
