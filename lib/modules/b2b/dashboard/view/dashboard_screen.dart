import 'package:kgk/kgk.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardBloc dashboardBloc = context.read<DashboardBloc>();
    return Scaffold(
      //TODO: Add the app bar title
      appBar: AppBar(
        title: const Text('Tab Bar'),
      ),
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: (previous, current) => current is DashboardChangeTabState,
          builder: (context, state) => dashboardBloc.pages[dashboardBloc.currentIndex],
        ),
      ),
      bottomNavigationBar: const SmartBottomNavigationBar(),
    );
  }
}
