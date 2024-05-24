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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const SmartImage(path: AppImages.icSplashBg, fit: BoxFit.cover),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
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
                      const Expanded(
                        child: Center(
                          child: SmartImage(
                            path: AppImages.icSplashLogo,
                            height: 112,
                            width: 112,
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
                          const SizedBox(width: 16),
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
