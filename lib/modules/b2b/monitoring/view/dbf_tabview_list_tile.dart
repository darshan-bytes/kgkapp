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
              hintText: APPStrings.searchX.tr.interpolate([APPStrings.dbf.tr.toLowerCase()]),
              onFieldSubmitted: (value) => monitoringBloc.add(MonitoringListingSearchEvent()),
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
      bottomNavigationBar: SafeArea(
        child: SelectionButton(
          borderRadius: BorderRadius.zero,
          isSelected: false,
          onTap: () {},
          image: AppImages.icFilter,
          title: APPStrings.filter.tr,
        ),
      ),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: monitoringBloc.currentController.canScrollToTop,
        onTap: monitoringBloc.currentController.scrollToTop,
      ),
    );
  }
}
