import 'package:kgk/kgk.dart';

class StylesTabviewListTile extends StatelessWidget {
  final MonitoringBloc monitoringBloc;

  const StylesTabviewListTile({super.key, required this.monitoringBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.0.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            SmartTextField(
              controller: monitoringBloc.stylesSearchController,
              hintText: APPStrings.searchX.tr.interpolate([APPStrings.styles.tr.toLowerCase()]),
              onFieldSubmitted: (value) => monitoringBloc.add(MonitoringListingSearchEvent()),
              onTapOutside: (p) {},
              suffixIcon: SmartImage(
                path: AppImages.icSearchThin,
                padding: EdgeInsets.all(14.w),
              ),
            ),
            SizedBox(height: 24.h),
            monitoringBloc.buildListView(context, MonitoringTab.styles),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<MonitoringBloc, MonitoringState>(
        buildWhen: (previous, current) => current is MonitoringListLoadedState || current is MonitoringOnTabChangedState,
        builder: (context, state) {
          if (state is MonitoringListLoadedState || state is MonitoringOnTabChangedState) {
            return SafeArea(
              child: FilterBottomActionBar(
                controller: monitoringBloc.currentController.controller,
                onFilterTap: () {
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    builder: (context) => FilterScreen(
                      onApply: () {},
                    ),
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: monitoringBloc.currentController.canScrollToTop,
        onTap: monitoringBloc.currentController.scrollToTop,
      ),
    );
  }
}
