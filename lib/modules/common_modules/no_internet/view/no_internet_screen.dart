import 'package:kgk/kgk.dart';

class NoInternetScreen extends StatelessWidget {
  final ThemeData theme;

  const NoInternetScreen({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).noInternetScreenStyle;
    return Theme(
      data: theme,
      child: Scaffold(
        body: SizedBox(
          height: context.height,
          width: context.width,
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SmartImage(path: AppImages.icNoInternetImage),
                SizedBox(height: 32.h),
                SmartText(APPStrings.noInternetConnectionFound.tr, style: style.noInternetTitleStyle),
                SizedBox(height: 8.h),
                SmartText(APPStrings.pleaseCheckYourInternetConnection.tr, style: style.noInternetSubtitleStyle),
                SizedBox(height: 16.h),
                SmartButton(width: 200.w, title: APPStrings.tryAgain.tr, onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
