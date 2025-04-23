import 'package:kgk/kgk.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LandingBloc landingBloc = BlocProvider.of<LandingBloc>(context);
    return BlocBuilder<LandingBloc, LandingState>(
      buildWhen: (previous, current) => current is LandingLoadedState,
      builder: (context, state) {
        if (state is LandingLoadedState) {
          return Scaffold(
            body: BlocBuilder<LandingBloc, LandingState>(
              buildWhen: (previous, current) => current is LandingChangeTabState,
              builder:
                  (context, state) => PopScope(
                    canPop: false,
                    onPopInvokedWithResult: (didPop, result) {
                      if (didPop) {
                        return;
                      }
                      if (landingBloc.currentIndex != 0) {
                        landingBloc.add(LandingChangeTabEvent(0, context: context));
                        return;
                      }

                      DateTime now = DateTime.now();
                      if (landingBloc.lastExitTime == null || now.difference(landingBloc.lastExitTime!) > landingBloc.exitTimeGap) {
                        landingBloc.lastExitTime = now;
                        Utils.showMessage(APPStrings.pressBackAgainToExit.tr, autoCloseDuration: landingBloc.exitTimeGap);
                      } else {
                        SystemNavigator.pop();
                      }
                    },
                    child: landingBloc.pages[landingBloc.currentIndex],
                  ),
            ),
            bottomNavigationBar: const SmartBottomNavigationBar(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
