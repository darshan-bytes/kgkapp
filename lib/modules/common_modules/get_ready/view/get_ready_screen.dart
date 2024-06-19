import 'package:kgk/kgk.dart';

class GetReadyScreen extends StatelessWidget {
  const GetReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashScreenStyle style = AppTheme.of(context).splashScreenStyle;
    final GetReadyBloc getReadyBloc = context.read<GetReadyBloc>();
    getReadyBloc.add(LoadGetReadyEvent(context: context));
    return Scaffold(
      body: BlocBuilder<GetReadyBloc, GetReadyState>(
        builder: (context, state) {
          return Stack(
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
                          BlocProvider.of<AppBloc>(context).add(const SetUserTypeEvent(UserType.b2cUser));
                          context.pushNamedAndRemoveUntil(AppRoutes.dashboardPage, (route) => false);
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
                                Navigator.pushNamed(context, AppRoutes.signInPage)
                                    .then((value) => getReadyBloc.add(LoadGetReadyEvent(context: context)));
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
                                Navigator.pushNamed(context, AppRoutes.signUpPage)
                                    .then((value) => getReadyBloc.add(LoadGetReadyEvent(context: context)));
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
          );
        },
      ),
    );
  }
}
