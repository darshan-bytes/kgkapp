import 'package:kgk/kgk.dart';

class DbfTabviewListTile extends StatelessWidget {
  final MonitoringBloc monitoringBloc;

  const DbfTabviewListTile({super.key, required this.monitoringBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.0.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            SmartTextField(
              controller: monitoringBloc.dbfSearchController,
              hintText: APPStrings.searchX.tr.interpolate([APPStrings.dbf.tr.toUpperCase()]),
              onFieldSubmitted: (value) => monitoringBloc.add(MonitoringListingSearchEvent()),
              onTapOutside: (p) {},
              suffixIcon: SmartImage(
                path: AppImages.icSearchThin,
                padding: EdgeInsets.all(14.w),
              ),
            ),
            SizedBox(height: 24.h),
            monitoringBloc.buildListView(context, MonitoringTab.dbf),
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
