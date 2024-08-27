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
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: diamondListingBloc.paginationScrollController.canScrollToTop,
        onTap: diamondListingBloc.paginationScrollController.scrollToTop,
      ),
      bottomNavigationBar: BlocBuilder<StoneListingBloc, StoneListingState>(
        buildWhen: (previous, current) => current is StoneProductLoadedState,
        builder: (context, state) {
          if (state is StoneProductLoadedState) {
            return FilterBottomActionBar(
              controller: diamondListingBloc.paginationScrollController.controller,
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
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      body: BlocBuilder<StoneListingBloc, StoneListingState>(
        buildWhen: (previous, current) => current is StoneProductLoadedState,
        builder: (context, state) {
          if (state is StoneProductLoadedState) {
            return SafeArea(
                child: SmartSingleChildScrollView(
              controller: diamondListingBloc.paginationScrollController.scrollController,
              onRefresh: () async {
                await diamondListingBloc.pullToRefresh(context);
              },
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
    return BlocBuilder<StoneListingBloc, StoneListingState>(
      buildWhen: (previous, current) => current is StoneChangeTypeState,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: SelectionButton(
                isSelected: diamondListingBloc.isInitialToggle,
                title: diamondListingBloc.tabOneTitle,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                onTap: () {
                  diamondListingBloc.add(StoneChangeTypeEvent(true, context));
                },
              ),
            ),
            Expanded(
              child: SelectionButton(
                isSelected: !diamondListingBloc.isInitialToggle,
                title: diamondListingBloc.tabTwoTitle,
                borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                onTap: () {
                  diamondListingBloc.add(StoneChangeTypeEvent(false, context));
                },
              ),
            ),
          ],
        );
      },
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
        if (diamondListingBloc.productList.isEmpty && state is StoneDiamondListLoadedState) {
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
                        context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                          RoutesData.isPageFor: ScreenIdentifier.productForDiamonds,
                          RoutesData.productId: productDetails.productId
                        });
                        //Below code is commented as discussed with JD and changed the navigation flow of diamond info popup and diamond details page
                        // context.pushNamed(AppRoutes.diamondInfoPopupPage,
                        //     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                      } else {
                        context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                          RoutesData.isPageFor: diamondListingBloc.screenIdentifier,
                          RoutesData.productId: productDetails.productId
                        });
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
                  itemBuilder: (context, index) {
                    final product = diamondListingBloc.productList[index];

                    /// Attributes list for stone info
                    List<String> attributes = [
                      product.color,
                      product.clarity,
                      product.cut,
                    ].where((attr) => attr != null).map((attr) => attr!).toList();
                    return diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY
                        ? ProductListItem(
                            onTap: () {
                              context.pushNamed(AppRoutes.stoneDetailPage,
                                  arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                            },
                            onEyeTap: () {},
                            onFavTap: () {},
                            productDetails: diamondListingBloc.productList[index],
                          )
                        : ProductInfoItem(
                            onTap360View: () => printWrapped("onTap360View"),
                            productFeaturesList: attributes,
                            onTapDNA: () {
                              context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                                RoutesData.cmsPageData: CmsWebViewDataModel(
                                  url: diamondListingBloc.productList[index].openDnaUrl,
                                  title: APPStrings.dna.tr,
                                )
                              });
                            },
                            onTapCertificate: () {
                              context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                                RoutesData.cmsPageData: CmsWebViewDataModel(
                                  url: diamondListingBloc.productList[index].certificateFile,
                                  title: APPStrings.certificate.tr,
                                )
                              });
                            },
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
                                context.pushNamed(AppRoutes.productDetailsPage,
                                    arguments: {RoutesData.isPageFor: ScreenIdentifier.productForDiamonds});
                                //Below code is commented as discussed with JD and changed the navigation flow of diamond info popup and diamond details page
                                // context.pushNamed(AppRoutes.diamondInfoPopupPage,
                                //     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                              } else {
                                context.pushNamed(AppRoutes.productDetailsPage,
                                    arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                              }
                            },
                            productDetails: ProductDetails(
                              productInfoClarityChat: ProductInfoClarityChat(
                                  rapRate: Utils.textWithCurrencySymbol(diamondListingBloc.productList[index].rappaportPrice ?? ''),
                                  //,"\$35,500.00",
                                  productId: diamondListingBloc.productList[index].productId,
                                  productName: diamondListingBloc.productList[index].name,
                                  //"1.00 Cts Round Diamond",
                                  ct: "10.04",
                                  shape: diamondListingBloc.productList[index].shape,
                                  colour: "H",
                                  clarity: "VVS1",
                                  lotNumber: diamondListingBloc.productList[index].productSku,
                                  certificateNumber: "230000066395",
                                  measurements: "10.18 x 8.34 x 6.14",
                                  lab: diamondListingBloc.productList[index].labs,
                                  cut: "Excellent",
                                  polish: "Excellent",
                                  symmetry: "Excellent",
                                  flourish: "O",
                                  tablePercentage: "50",
                                  depthPercentage: "50",
                                  rap: Utils.textWithCurrencySymbol(diamondListingBloc.productList[index].lsp ?? ''),
                                  //"\$24,851.00",
                                  discount: diamondListingBloc.productList[index].discountPercentage,
                                  //"-30.00",
                                  perCts: "\$24,850.00",
                                  amount: Utils.textWithCurrencySymbol(diamondListingBloc.productList[index].finalPrice ?? ''),
                                  //"\$1,24,995.50",
                                  fluorescence: diamondListingBloc.productList[index].fluorescence),
                              productId: "1",
                              diamond: "1.5 gram",
                              gram: "1.5 gram",
                              imageUrl: diamondListingBloc.productList[index].imageUrl, // "https://i.ibb.co/swb5gVs/Round.png",
                            ));
                  },
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
