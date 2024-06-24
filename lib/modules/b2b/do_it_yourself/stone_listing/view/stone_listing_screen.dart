import 'package:kgk/kgk.dart';

class StoneListingScreen extends StatelessWidget {
  const StoneListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondListingStyle;
    final StoneListingBloc diamondListingBloc = BlocProvider.of<StoneListingBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<StoneListingBloc, StoneListingState>(
          buildWhen: (previous, current) => current is StoneProductLoadedState,
          builder: (context, state) {
            return SmartAppBar(
              title: diamondListingBloc.stoneListingAppbarTitle,
              onSearch: () {
                context.pushNamed(AppRoutes.searchPage);
              },
              onFavorite: () {
                context.pushNamed(AppRoutes.wishListPage);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: FilterBottomActionBar(
        onFilterTap: () {
          Utils.showSmartModalBottomSheet(
            context: context,
            builder: (context) => DiamondFilterScreen(onApply: () {}),
          );
        },
        onSortTap: () {
          Utils.showSmartModalBottomSheet(
            context: context,
            builder: (context) => const SortScreen(),
          );
        },
      ),
      body: BlocBuilder<StoneListingBloc, StoneListingState>(
        buildWhen: (previous, current) => current is StoneProductLoadedState,
        builder: (context, state) {
          if (state is StoneProductLoadedState) {
            return SafeArea(
                child: SmartSingleChildScrollView(
              controller: diamondListingBloc.paginationScrollController.scrollController,
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                children: [
                  if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY) SizedBox(height: 16.h),
                  if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY)
                    const DiyProgressWidget(padding: EdgeInsets.zero, selectedStep: 1),
                  SizedBox(height: 24.h),
                  _buildSelectionDiamond(diamondListingBloc),
                  SizedBox(height: 24.h),
                  _buildProductFilterCount(style, diamondListingBloc),
                  SizedBox(height: 24.h),
                  _buildProductList(style, diamondListingBloc),
                ],
              ),
            ));
          }
          return const SmartCircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildSelectionDiamond(StoneListingBloc diamondListingBloc) {
    return Row(
      children: [
        Expanded(
          child: SelectionButton(
            isSelected: diamondListingBloc.isInitialToggle,
            title: diamondListingBloc.tabOneTitle,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
            onTap: () {
              diamondListingBloc.add(const StoneChangeTypeEvent(true));
            },
          ),
        ),
        Expanded(
          child: SelectionButton(
            isSelected: !diamondListingBloc.isInitialToggle,
            title: diamondListingBloc.tabTwoTitle,
            borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
            onTap: () {
              diamondListingBloc.add(const StoneChangeTypeEvent(false));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle style, StoneListingBloc diamondListingBloc) {
    return BlocBuilder<StoneListingBloc, StoneListingState>(
      buildWhen: (previous, current) => current is StoneChangeListingTypeState,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(APPStrings.showingListLengthX.tr.interpolate(["1", "24", 100]), style: style.filterProductCountTextStyle),
              Row(
                children: [
                  SelectionButton(
                    width: 48.w,
                    isSelected: diamondListingBloc.isGrid,
                    image: AppImages.icGrid,
                    imageHeight: 24.5.w,
                    imageWidth: 24.5.w,
                    selectedButtonColor: style.gridBackgroundColor,
                    selectedButtonBorderColor: style.gridBorderColor,
                    selectedButtonIconColor: style.gridIconColor,
                    unselectedButtonIconColor: style.listIconColor,
                    unselectedButtonColor: style.listBackgroundColor,
                    unselectedButtonBorderColor: style.listBorderColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                    onTap: () {
                      diamondListingBloc.add(const StoneChangeListingTypeEvent());
                    },
                  ),
                  SelectionButton(
                    width: 48.w,
                    isSelected: !diamondListingBloc.isGrid,
                    image: AppImages.icList,
                    imageHeight: 18.h,
                    selectedButtonColor: style.gridBackgroundColor,
                    selectedButtonBorderColor: style.gridBorderColor,
                    selectedButtonIconColor: style.gridIconColor,
                    unselectedButtonIconColor: style.listIconColor,
                    unselectedButtonColor: style.listBackgroundColor,
                    unselectedButtonBorderColor: style.listBorderColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                    onTap: () {
                      diamondListingBloc.add(const StoneChangeListingTypeEvent());
                    },
                  ),
                  SizedBox(width: 16.w),
                  SelectionButton(
                    width: 48.w,
                    imageHeight: 24.5.w,
                    imageWidth: 24.5.w,
                    isSelected: true,
                    selectedButtonColor: style.menuBackgroundColor,
                    selectedButtonBorderColor: style.menuBorderColor,
                    selectedButtonIconColor: style.gridIconColor,
                    image: AppImages.icMenu,
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductList(DiamondListingStyle style, StoneListingBloc diamondListingBloc) {
    return BlocBuilder<StoneListingBloc, StoneListingState>(
      buildWhen: (previous, current) =>
          current is StoneProductLoadedState ||
          current is StoneChangeListingTypeState ||
          current is StoneListLoadingMoreState ||
          current is StoneListLoadedMoreState,
      builder: (context, state) {
        if (diamondListingBloc.productList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noDiamondProductFound.tr);
        } else {
          if (diamondListingBloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                    items: diamondListingBloc.productList.map((ProductDetails productDetails) {
                  return ProductGridItem(
                    productDetails: productDetails,
                    isStoneWithPrice: true,
                    onTap: () {
                      if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY) {
                        context
                            .pushNamed(AppRoutes.stoneDetailPage, arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                      } else if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDefault) {
                        context.pushNamed(AppRoutes.diamondInfoPopupPage,
                            arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                      } else {
                        context.pushNamed(AppRoutes.productDetailsPage,
                            arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                      }
                    },
                    onEyeTap: () {},
                    onFavTap: () {},
                  );
                }).toList()),
                if (state is StoneListLoadingMoreState) const SmartCircularProgressIndicator(),
                SizedBox(height: 17.h)
              ],
            );
          } else {
            return Column(
              children: [
                ListView.separated(
                  itemCount: diamondListingBloc.productList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY
                      ? ProductListItem(
                          onEyeTap: () {},
                          onFavTap: () {},
                          onAddToBagTap: () {},
                          productDetails: diamondListingBloc.productList[index],
                        )
                      : ProductInfoItem(
                          onTap360View: () => printWrapped("onTap360View"),
                          onTapDNA: () => printWrapped("onTapDNA"),
                          onTapCertificate: () => printWrapped("onTapCertificate"),
                          onTapImageViewer: () => printWrapped("onTapImageViewer"),
                          onTapUSA: () => printWrapped("onTapUSA"),
                          onTapMenuButton: () {
                            Utils.showSmartModalBottomSheet(
                              context: context,
                              builder: (context) => const ProductMenuBottomSheet(),
                            );
                          },
                          isSelectedBackground: (index % 2 != 0),
                          onTap: () {
                            if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY) {
                              context.pushNamed(AppRoutes.stoneDetailPage,
                                  arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                            } else if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDefault) {
                              context.pushNamed(AppRoutes.diamondInfoPopupPage,
                                  arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                            } else {
                              context.pushNamed(AppRoutes.productDetailsPage,
                                  arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                            }
                          },
                          productDetails: ProductDetails(
                            productInfoClarityChat: ProductInfoClarityChat(
                              productId: "1",
                              productName: "1.00 Cts Round Diamond",
                              ct: "10.04",
                              shape: "Marquise",
                              colour: "H",
                              clarity: "VVS1",
                              lotNumber: "MBFG716306",
                              certificateNumber: "230000066395",
                              measurements: "10.18 x 8.34 x 6.14",
                              lab: "GIA",
                              cut: "Excellent",
                              polish: "Excellent",
                              symmetry: "Excellent",
                              flourish: "O",
                              tablePercentage: "50",
                              depthPercentage: "50",
                              rap: "\$35,500.00",
                              discount: "-30.00",
                              perCts: "\$24,850.00",
                              amount: "\$1,24,995.50",
                            ),
                            productId: "1",
                            diamond: "1.5 gram",
                            gram: "1.5 gram",
                            imageUrl: "https://i.ibb.co/swb5gVs/Round.png",
                          )),
                  separatorBuilder: (context, index) => SizedBox(height: 17.h),
                ),
                if (state is StoneListLoadingMoreState) const SmartCircularProgressIndicator(),
                SizedBox(height: 17.h)
              ],
            );
          }
        }
      },
    );
  }
}
