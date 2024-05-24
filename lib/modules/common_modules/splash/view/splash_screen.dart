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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const SmartImage(path: AppImages.icSplashBg, fit: BoxFit.cover),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: SmartImage(
                  path: AppImages.icSplashLogo,
                  height: 112,
                  width: 112,
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
