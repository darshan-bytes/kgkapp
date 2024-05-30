import 'package:kgk/kgk.dart';

class GetReadyScreen extends StatelessWidget {
  const GetReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashScreenStyle style = AppTheme.of(context).splashScreenStyle;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: context.height,
            width: context.width,
            child: const SmartImage(path: AppImages.icSplashBg, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SmartText(
                    APPStrings.skip.tr,
                    style: style.skipTextStyle,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboardPage, (route) => false);
                    },
                    textAlign: TextAlign.end,
                  ),
                  Expanded(
                    child: Center(
                      child: SmartImage(
                        path: AppImages.icSplashLogo,
                        height: 112.w,
                        width: 112.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SmartButton(
                          onTap: () {
                            context.pushNamed( AppRoutes.signInPage);
                          },
                          activeBackgroundColor: style.activeBackgroundColor,
                          titleStyle: style.titleStyle,
                          title: APPStrings.login.tr,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: SmartButton(
                          onTap: () {
                            context.pushNamed( AppRoutes.signUpPage);
                          },
                          activeBackgroundColor: style.activeBackgroundColor,
                          titleStyle: style.titleStyle,
                          title: APPStrings.register.tr,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
