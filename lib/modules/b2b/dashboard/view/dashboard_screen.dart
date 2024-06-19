import 'package:kgk/kgk.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardBloc dashboardBloc = context.read<DashboardBloc>();
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => current is DashboardLoadedState,
      builder: (context, state) {
        if (state is DashboardLoadedState) {
          return Scaffold(
            body: BlocBuilder<DashboardBloc, DashboardState>(
              buildWhen: (previous, current) => current is DashboardChangeTabState,
              builder: (context, state) => dashboardBloc.pages[dashboardBloc.currentIndex],
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
