import 'package:kgk/kgk.dart';

class ExhibitionDetailsProductsTabViewList extends StatelessWidget {
  final ExhibitionDetailsBloc bloc;

  const ExhibitionDetailsProductsTabViewList({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final ExhibitionDetailsItemStyle style = AppTheme.of(context).exhibitionDetailsItemStyle;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24.h),
          _buildProductDisplay(bloc, style),
          SizedBox(height: 24.h),
          SmartText(
            APPStrings.showingListLengthX.tr.interpolate([
              bloc.paginationScrollController.currentPage,
              bloc.totalNumberOfPages,
              bloc.totalFilteredRecords,
            ]),
            style: style.listStatusStyle,
          ),
          SizedBox(height: 24.h),
          _buildExhibitionFilterCount(bloc, context),
          SizedBox(height: 24.h),
          _buildExhibitionList(bloc),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildProductDisplay(ExhibitionDetailsBloc bloc, ExhibitionDetailsItemStyle style) {
    return B2BListingItem(
        listingItemModel: B2BCustomListingDataModel(
          strItemSold: bloc.exhibitionProductDetailsData.itemsSold.toString(),
          strOrdersReceived: bloc.exhibitionProductDetailsData.totalOrders.toString(),
          strTotalSell: bloc.exhibitionProductDetailsData.totalSales?.setCurrency,
          strAverageOrderValue: bloc.exhibitionProductDetailsData.avgOrder?.setCurrency,
          strLeads: bloc.exhibitionProductDetailsData.leads.toString(),
        ),
        type: B2BListingType.exhibitionDetailPageProductsType);
  }

  Widget _buildExhibitionFilterCount(ExhibitionDetailsBloc bloc, BuildContext context) {
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen: (previous, current) => current is ExhibitionChangeListingTypeState,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(APPStrings.showingListLengthX.tr.interpolate(["1", "24", 100]),
                  style: diamondListingStyle.filterProductCountTextStyle),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SelectionButton(
                      width: 48.w,
                      isSelected: bloc.isGrid,
                      image: AppImages.icGrid,
                      selectedButtonColor: diamondListingStyle.gridBackgroundColor,
                      selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
                      selectedButtonIconColor: diamondListingStyle.gridIconColor,
                      unselectedButtonIconColor: diamondListingStyle.listIconColor,
                      unselectedButtonColor: diamondListingStyle.listBackgroundColor,
                      unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                      onTap: () {
                        bloc.add(const ExhibitionChangeListingTypeEvent(isGrid: true));
                      },
                    ),
                    SelectionButton(
                      width: 48.w,
                      isSelected: !bloc.isGrid,
                      image: AppImages.icList,
                      selectedButtonColor: diamondListingStyle.gridBackgroundColor,
                      selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
                      selectedButtonIconColor: diamondListingStyle.gridIconColor,
                      unselectedButtonIconColor: diamondListingStyle.listIconColor,
                      unselectedButtonColor: diamondListingStyle.listBackgroundColor,
                      unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                      onTap: () {
                        bloc.add(const ExhibitionChangeListingTypeEvent(isGrid: false));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildExhibitionList(ExhibitionDetailsBloc bloc) {
    return BlocBuilder<ExhibitionDetailsBloc, ExhibitionDetailsState>(
      buildWhen: (previous, current) =>
          current is ExhibitionChangeListingTypeState ||
          current is ExhibitionListingLoadedMoreState ||
          current is ExhibitionListingLoadingMoreState,
      builder: (context, state) {
        if (bloc.productList.isEmpty) {
          return _buildEmptyState();
        }
        return _buildListOrGridView(bloc, state, context);
      },
    );
  }

  Widget _buildEmptyState() {
    return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
  }

  Widget _buildListOrGridView(ExhibitionDetailsBloc bloc, ExhibitionDetailsState state, BuildContext context) {
    return bloc.isGrid ? _buildGridView(bloc, state, context) : _buildListView(bloc, state);
  }

  Widget _buildGridView(ExhibitionDetailsBloc bloc, ExhibitionDetailsState state, BuildContext context) {
    return SmartGridView(
      items: bloc.productList.map((ProductDetailsModel productDetails) {
        return ProductGridItem(
          productDetails: productDetails,
          isOutOfStock: false,
          onEyeTap: () {
            Utils.showSmartModalBottomSheet(
              context: context,
              enableDrag: false,
              useRootNavigator: true,
              builder: (context) {
                return const AddWatchlistScreen();
              },
            );
          },
          onFavTap: () {},
          onTap: () {},
        );
      }).toList(),
      isLoadingMore: state is ExhibitionListingLoadingMoreState,
    );
  }

  Widget _buildListView(ExhibitionDetailsBloc bloc, ExhibitionDetailsState state) {
    return ListView.separated(
      key: bloc.paginationScrollController.listKey,
      shrinkWrap: true,
      itemCount: bloc.productList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            ProductListItem(
              onEyeTap: () {},
              onFavTap: () {},
              onTap: () {},
              productDetails: bloc.productList[index],
            ),
            if (state is ExhibitionListingLoadingMoreState && index == bloc.productList.length - 1) const SmartCircularProgressIndicator(),
          ],
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 17.h),
    );
  }
}
