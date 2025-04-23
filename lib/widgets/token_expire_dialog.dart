import 'package:kgk/kgk.dart';

class TokenExpireDialog extends StatelessWidget {
  const TokenExpireDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final EditWatchlistStyle style = AppTheme.of(context).editWatchlistStyle;
    return PopScope(
      canPop: false,
      child: Container(
        padding: EdgeInsetsDirectional.all(16.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SmartText(APPStrings.sessionExpired.tr, style: style.titleStyle),
            SizedBox(height: 6.h),
            SmartText(APPStrings.sessionExpiredDesc.tr, style: style.subTitleStyle),
            SizedBox(height: 20.h),
            SmartButton(
              onTap: () {
                context.pop();
                context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
              },
              title: APPStrings.login.tr,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
