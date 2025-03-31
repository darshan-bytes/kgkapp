import 'package:kgk/kgk.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (context) => SplashBloc()..add(LoadSplashEvent(context: context)),
        child: BlocBuilder<SplashBloc, SplashState>(
          buildWhen: (previous, current) => current is SplashVideoInitialized || current is SplashVideoCompleteState,
          builder: (context, state) {
            SplashBloc bloc = BlocProvider.of<SplashBloc>(context);
            if (state is SplashVideoInitialized && bloc.playerController.value.isInitialized) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(onTap: (){
                    String? authToken = StorageManager().getAuthToken();
                    String route = (authToken != null) ? AppRoutes.landingPage : AppRoutes.signInPage;
                    context.pushNamedAndRemoveUntil(route, (route) => false);
                  },child: VideoPlayer(bloc.playerController)),
                  SizedBox(
                    height: context.height,
                    width: context.width,
                    child: Center(
                      child: SmartImage(
                        path: AppImages.icSplashLogoWithSvg,
                        height: 112.w,
                        width: 112.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Stack(
              children: [
                SizedBox(
                  height: context.height,
                  width: context.width,
                  child: const SmartImage(path: AppImages.icSplashBg, fit: BoxFit.cover),
                ),
                SizedBox(
                  height: context.height,
                  width: context.width,
                  child: Center(
                    child: SmartImage(
                      path: AppImages.icSplashLogo,
                      height: 112.w,
                      width: 112.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
