import 'package:kgk/kgk.dart';

class PresentationsTabviewListTile extends StatelessWidget {
  final MonitoringBloc monitoringBloc;

  const PresentationsTabviewListTile({super.key, required this.monitoringBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.0.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            SmartTextField(
              controller: monitoringBloc.presentationsSearchController,
              hintText: APPStrings.searchX.tr.interpolate([APPStrings.presentation.tr.toLowerCase()]),
              onFieldSubmitted: (value) => monitoringBloc.add(MonitoringListingSearchEvent()),
              onTapOutside: (p) {},
              suffixIcon: SmartImage(
                path: AppImages.icSearchThin,
                padding: EdgeInsets.all(14.w),
              ),
            ),
            SizedBox(height: 24.h),
            monitoringBloc.buildListView(context, MonitoringTab.presentations),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<MonitoringBloc, MonitoringState>(
        buildWhen: (previous, current) => current is MonitoringListLoadedState || current is MonitoringOnTabChangedState,
        builder: (context, state) {
          if (state is MonitoringListLoadedState) {
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
