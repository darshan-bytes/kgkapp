import 'package:kgk/kgk.dart';

class DesignListingScreen extends StatelessWidget {
  const DesignListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DesignListingBloc designListingBloc = BlocProvider.of<DesignListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.designs.tr),
      bottomNavigationBar: _buildBottomNavigationBar(designListingBloc, context),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: designListingBloc.paginationScrollController.canScrollToTop,
        onTap: designListingBloc.paginationScrollController.scrollToTop,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<DesignListingBloc, DesignListingState>(
            buildWhen: (previous, current) => current is DesignListingLoadedState,
            builder: (context, state) {
              if (state is DesignListingLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSearchTextFieldWithSelectionButton(designListingBloc, context),
                    Expanded(child: _buildDesignList(designListingBloc)),
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

  Widget _buildSearchTextFieldWithSelectionButton(DesignListingBloc designListingBloc, BuildContext context) {
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return BlocBuilder<DesignListingBloc, DesignListingState>(
      buildWhen: (previous, current) => current is DesignChangeListingTypeState,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: SmartTextField(
                hintText: APPStrings.searchProjects.tr,
                controller: designListingBloc.designSearchController,
                suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
                padding: EdgeInsets.symmetric(vertical: 24.w),
              ),
            ),
            SizedBox(width: 16.w),
            Row(
              children: [
                SelectionButton(
                  width: 48.w,
                  isSelected: designListingBloc.isGrid,
                  image: AppImages.icGrid,
                  selectedButtonColor: diamondListingStyle.gridBackgroundColor,
                  selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
                  selectedButtonIconColor: diamondListingStyle.gridIconColor,
                  unselectedButtonIconColor: diamondListingStyle.listIconColor,
                  unselectedButtonColor: diamondListingStyle.listBackgroundColor,
                  unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                  onTap: () {
                    designListingBloc.add(const DesignChangeListingTypeEvent(isGrid: true));
                  },
                ),
                SelectionButton(
                  width: 48.w,
                  isSelected: !designListingBloc.isGrid,
                  image: AppImages.icList,
                  selectedButtonColor: diamondListingStyle.gridBackgroundColor,
                  selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
                  selectedButtonIconColor: diamondListingStyle.gridIconColor,
                  unselectedButtonIconColor: diamondListingStyle.listIconColor,
                  unselectedButtonColor: diamondListingStyle.listBackgroundColor,
                  unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                  onTap: () {
                    designListingBloc.add(const DesignChangeListingTypeEvent(isGrid: false));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDesignList(DesignListingBloc designListingBloc) {
    return BlocBuilder<DesignListingBloc, DesignListingState>(
      buildWhen: (previous, current) => current is DesignListLoadedMoreState || current is DesignListLoadingMoreState,
      builder: (context, state) {
        if (designListingBloc.designList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noDesignsFound.tr);
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                controller: designListingBloc.paginationScrollController.scrollController,
                itemCount: designListingBloc.designList.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  B2BCustomListingDataModel designItem = designListingBloc.designList[index];
                  //appears when there is isGrid
                  if (designListingBloc.isGrid) {
                    return B2BListingItem(
                      type: B2BListingType.designListingType,
                      listingItemModel: designItem,
                      margin: EdgeInsets.only(bottom: state is DesignListLoadingMoreState ? 0 : 16.h),
                      onTapMenuButton: () {},
                    );
                  } else {
                    return B2BListingItem(
                      type: B2BListingType.designListingType,
                      listingItemModel: designItem,
                      margin: EdgeInsets.only(bottom: state is DesignListLoadingMoreState ? 0 : 16.h),
                      onTapMenuButton: () {},
                    );
                  }
                },
              ),
            ),
            if (state is DesignListLoadingMoreState) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(DesignListingBloc designListingBloc, BuildContext context) {
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
