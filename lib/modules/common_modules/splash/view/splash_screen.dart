import 'package:kgk/kgk.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (context) => SplashBloc()..add(LoadSplashEvent(context: context)),
        child: Stack(
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
        ),
      ),
    );
  }
}
