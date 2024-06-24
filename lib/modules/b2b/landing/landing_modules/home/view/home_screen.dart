import 'package:kgk/kgk.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SmartText(
          'View All Collection',
          onTap: () {
            context.pushNamed(AppRoutes.collectionPage);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SmartText(
          'Search screen',
          onTap: () {
            context.pushNamed(AppRoutes.searchPage);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SmartText(
          'Concept List',
          onTap: () {
            context.pushNamed(AppRoutes.conceptListPage);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SmartText(
          'Monitoring',
          onTap: () {
            context.pushNamed(AppRoutes.monitoringPage);
          },
        ),
        SmartText(
          'Project Listing',
          onTap: () {
            context.pushNamed(AppRoutes.projectListingPage);
          },
        ),
      ]),
    );
  }
}
