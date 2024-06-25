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
              controller: monitoringBloc.searchController,
              hintText: APPStrings.searchStyles.tr,
              onFieldSubmitted: (value) => monitoringBloc.add(MonitoringListingSearchEvent()),
              suffixIcon: SmartImage(
                path: AppImages.icSearchThin,
                padding: EdgeInsets.all(12.w),
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
                child: BlocBuilder<MonitoringBloc, MonitoringState>(
              buildWhen: (previous, current) => current is MonitoringListLoadedState || current is MonitoringLoadingMoreState,
              builder: (context, state) {
                if (monitoringBloc.stylesList.isEmpty) {
                  return NoDataFoundWidget(text: APPStrings.noStyleFound.tr);
                }
                return ListView.separated(
                  itemCount: monitoringBloc.stylesList.length,
                  controller: monitoringBloc.paginationScrollController.scrollController,
                  itemBuilder: (context, index) {
                    return BlocBuilder<MonitoringBloc, MonitoringState>(
                      buildWhen: (previous, current) => current is MonitoringLoadingMoreState || current is MonitoringListLoadedMoreState,
                      builder: (context, state) {
                        return Column(
                          children: [
                            B2BListingItem(
                              onTap: () {},
                              onTapMenuButton: () {},
                              type: B2BListingType.monitoringStylesType,
                              listingItemModel: monitoringBloc.stylesList[index],
                            ),
                            if (state is MonitoringLoadingMoreState && index == monitoringBloc.stylesList.length - 1)
                              const SmartCircularProgressIndicator(),
                          ],
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                );
              },
            ))
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
        canScrollToTop: monitoringBloc.paginationScrollController.canScrollToTop,
        onTap: monitoringBloc.paginationScrollController.scrollToTop,
      ),
    );
  }
}
