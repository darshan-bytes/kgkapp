import 'package:kgk/kgk.dart';

class ManufacturerOrderListingScreen extends StatelessWidget {
  const ManufacturerOrderListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ManufacturerOrderListingBloc manufacturerOrderListingBloc = BlocProvider.of<ManufacturerOrderListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.searchOrder.tr),
      bottomNavigationBar: _buildBottomNavigationBar(manufacturerOrderListingBloc, context),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: manufacturerOrderListingBloc.paginationScrollController.canScrollToTop,
        onTap: manufacturerOrderListingBloc.paginationScrollController.scrollToTop,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<ManufacturerOrderListingBloc, ManufacturerOrderListingState>(
            buildWhen: (previous, current) => current is ManufacturerOrderListingLoadedState,
            builder: (context, state) {
              if (state is ManufacturerOrderListingLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSearchTextField(manufacturerOrderListingBloc),
                    Expanded(child: _buildOrderList(manufacturerOrderListingBloc))
                  ],
                );
              } else {
                return const SmartCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField(ManufacturerOrderListingBloc manufacturerOrderListingBloc) {
    return SmartTextField(
      hintText: APPStrings.searchOrder.tr,
      controller: manufacturerOrderListingBloc.manufacturerOrderSearchController,
      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
      padding: EdgeInsets.symmetric(vertical: 24.w),
    );
  }

  Widget _buildOrderList(ManufacturerOrderListingBloc manufacturerOrderListingBloc) {
    return BlocBuilder<ManufacturerOrderListingBloc, ManufacturerOrderListingState>(
      buildWhen: (previous, current) => current is ManufacturerOrderListLoadedMoreState || current is ManufacturerOrderListLoadingMoreState,
      builder: (context, state) {
        return Column(
          children: [
            if (manufacturerOrderListingBloc.manufacturerOrderList.isEmpty)
              NoDataFoundWidget(text: APPStrings.noDataFound.tr)
            else
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: manufacturerOrderListingBloc.paginationScrollController.scrollController,
                  itemCount: manufacturerOrderListingBloc.manufacturerOrderList.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    B2BCustomListingDataModel orderItem = manufacturerOrderListingBloc.manufacturerOrderList[index];
                    return B2BListingItem(
                      type: B2BListingType.manufacturerOrderListingType,
                      listingItemModel: orderItem,
                      onTapMenuButton: () {},
                      onTap: () {
                        context.pushNamed(AppRoutes.designBriefsPage);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                ),
              ),
            if (state is ManufacturerOrderListLoadingMoreState) const SmartCircularProgressIndicator(),
            SizedBox(height: 17.h),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(ManufacturerOrderListingBloc manufacturerOrderListingBloc, BuildContext context) {
    return SafeArea(
      child: SelectionButton(
        borderRadius: BorderRadius.zero,
        isSelected: false,
        onTap: () {
          Utils.showSmartModalBottomSheet(
            context: context,
            builder: (context) => FilterScreen(
              onApply: () {},
            ),
          );
        },
        image: AppImages.icFilter,
        title: APPStrings.filter.tr,
      ),
    );
  }
}
