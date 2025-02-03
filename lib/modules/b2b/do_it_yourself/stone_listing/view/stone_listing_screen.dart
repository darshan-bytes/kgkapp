import 'package:kgk/kgk.dart';

class StoneListingScreen extends StatelessWidget {
  const StoneListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondListingStyle;
    final StoneListingBloc bloc = BlocProvider.of<StoneListingBloc>(context);
    return BlocBuilder<StoneListingBloc, StoneListingState>(
      buildWhen: (previous, current) => current is StoneProductLoadedState || current is StoneListLoadingState,
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: context.appBarHeight,
            child: BlocBuilder<StoneListingBloc, StoneListingState>(
              buildWhen: (previous, current) => current is StoneProductLoadedState,
              builder: (context, state) {
                return SmartAppBar(
                  title: bloc.appbarTitle,
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
            canScrollToTop: bloc.paginationScrollController.canScrollToTop,
            onTap: bloc.paginationScrollController.scrollToTop,
          ),
          bottomNavigationBar: state is StoneProductLoadedState ? _buildBottomNavigationBar(bloc) : null,
          body: BlocBuilder<StoneListingBloc, StoneListingState>(
            buildWhen: (previous, current) => current is StoneProductLoadedState || (current is StoneListLoadingState && current.isFirst),
            builder: (context, state) {
              if (state is StoneProductLoadedState) {
                return SafeArea(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY) SizedBox(height: 16.h),
                      if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY)
                        const DiyProgressWidget(padding: EdgeInsets.zero, selectedStep: 1),
                      if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY) SizedBox(height: 6.h),
                      if (bloc.displaySelection) ...[
                        SizedBox(height: 10.h),
                        _buildSelectionDiamond(bloc),
                      ],
                      SizedBox(height: 10.h),
                      _buildProductFilterCount(style, bloc),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: BlocBuilder<StoneListingBloc, StoneListingState>(
                          buildWhen: (previous, current) => current is StoneListLoadingState || current is StoneProductLoadedState,
                          builder: (context, state) {
                            return (state is StoneListLoadingState)
                                ? SmartCircularProgressIndicator()
                                : bloc.productList.isNullOrEmpty
                                    ? NoDataFoundWidget(text: APPStrings.emptyProducts.tr)
                                    : SmartSingleChildScrollView(
                                        controller: bloc.paginationScrollController.controller,
                                        onRefresh: () async {
                                          bloc.add(StoneListPullToRefreshEvent(context));
                                        },
                                        child: Column(
                                          children: [
                                            BlocBuilder<StoneListingBloc, StoneListingState>(
                                              builder: (context, state) {
                                                if (state is StoneProductReloadState) {
                                                  return const SizedBox.shrink();
                                                } else {
                                                  return _buildProductList(style, bloc);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                          },
                        ),
                      ),
                    ],
                  ),
                ));
              } else if (state is StoneListLoadingState) {
                return const SmartCircularProgressIndicator();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        );
      },
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

  Widget _buildProductFilterCount(DiamondListingStyle style, StoneListingBloc bloc) {
    return BlocBuilder<StoneListingBloc, StoneListingState>(
      buildWhen: (previous, current) =>
          current is StoneChangeListingTypeState ||
          current is StoneProductLoadedState ||
          current is StoneListLoadedMoreState ||
          current is StoneListLoadingState,
      builder: (context, state) {
        if (state is StoneListLoadingState) return SizedBox.shrink();
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(
                  APPStrings.showingListLengthX.tr.interpolate([
                    1,
                    bloc.productList.length,
                    bloc.totalFilteredRecords,
                  ]),
                  style: style.filterProductCountTextStyle),
              Row(
                children: [
                  SelectionButton(
                    width: 48.w,
                    isSelected: bloc.isGrid,
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
                      bloc.add(const StoneChangeListingTypeEvent());
                    },
                  ),
                  SelectionButton(
                    width: 48.w,
                    isSelected: !bloc.isGrid,
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
                      bloc.add(const StoneChangeListingTypeEvent());
                    },
                  ),

                  /// TODO: Currently not implemented as per discussion with JD
                  // SizedBox(width: 16.w),
                  // SelectionButton(
                  //   width: 48.w,
                  //   imageHeight: 24.5.w,
                  //   imageWidth: 24.5.w,
                  //   isSelected: true,
                  //   selectedButtonColor: style.menuBackgroundColor,
                  //   selectedButtonBorderColor: style.menuBorderColor,
                  //   selectedButtonIconColor: style.gridIconColor,
                  //   image: AppImages.icMenu,
                  //   onTap: () {},
                  // ),
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
          current is StoneDiamondListLoadedState ||
          current is StoneProductLoadedState ||
          current is StoneChangeListingTypeState ||
          current is StoneListLoadingMoreState ||
          current is StoneListLoadedMoreState,
      builder: (context, state) {
        if (diamondListingBloc.productList.isEmpty &&
            (state is StoneDiamondListLoadedState || state is StoneProductLoadedState || state is StoneChangeListingTypeState)) {
          return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
        } else {
          if (diamondListingBloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                    items: diamondListingBloc.productList.map((ProductDetailsModel productDetails) {
                  return ProductGridItem(
                    productDetails: productDetails,
                    isCrtAndGramVisible: false,
                    onTap: () {
                      if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY) {
                        context.pushNamed(AppRoutes.stoneDetailPage, arguments: {
                          RoutesData.isPageFor: diamondListingBloc.screenIdentifier,
                          RoutesData.productId: productDetails.productId
                        });
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
                    isFavourite: productDetails.isFavourite,
                    onFavTap: () {},
                    onAddToBagTap: () {},
                  );
                }).toList()),
                if (state is StoneListLoadingMoreState) const SmartCircularProgressIndicator(),
                SizedBox(height: 17.h)
              ],
            );
          } else {
            return Column(
              children: [
                //Merged
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
                            productDetails: product,
                          )
                        : ProductInfoItem(
                            isFromBag: false,
                            productFeaturesList: attributes,
                            onTap360View: () => printWrapped("onTap360View"),
                            onTapDNA: product.openDnaUrl != null
                                ? () {
                                    Utils.launchUrlFromString(product.openDnaUrl!);
                                  }
                                : null,
                            onTapCertificate: product.certificateFile != null
                                ? () {
                                    Utils.launchUrlFromString(product.certificateFile!);
                                  }
                                : null,
                            onTapImageViewer: product.shapeImage != null
                                ? () {
                                    Utils.launchUrlFromString(product.shapeImage!);
                                  }
                                : null,
                            onTapUSA: () => printWrapped("onTapUSA"),
                            onTapMenuButton: () {
                              Utils.showSmartModalBottomSheet(
                                context: context,
                                builder: (_) => ProductMenuBottomSheet(
                                  productDetails: product,
                                  onAddToBag: () {
                                    BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(product, context));
                                  },
                                  onBuyNow: () {
                                    BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(product, context, isBuyNow: true));
                                  },
                                ),
                              );
                            },
                            isSelectedBackground: (index % 2 != 0),
                            onTap: () {
                              if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY) {
                                context.pushNamed(AppRoutes.stoneDetailPage, arguments: {
                                  RoutesData.isPageFor: diamondListingBloc.screenIdentifier,
                                  RoutesData.productId: product.productId
                                });
                              } else if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDefault) {
                                context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                                  RoutesData.isPageFor: ScreenIdentifier.productForDiamonds,
                                  RoutesData.productId: product.productId
                                });
                                //Below code is commented as discussed with JD and changed the navigation flow of diamond info popup and diamond details page
                                // context.pushNamed(AppRoutes.diamondInfoPopupPage,
                                //     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                              } else {
                                context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                                  RoutesData.isPageFor: diamondListingBloc.screenIdentifier,
                                  RoutesData.productId: product.productId
                                });
                              }
                            },
                            productDetails: ProductDetailsModel(
                              suid: product.suid,
                              productInfoClarityChat: ProductInfoClarityChat(
                                carat: "36.09",
                                commodity: "Sapphire",
                                origin: "Sri Lanka",
                                rapRate: product.rappaportPrice?.setCurrency,
                                productId: product.productId,
                                productName: product.name,
                                ct: "10.04",
                                shape: product.shape,
                                colour: "H",
                                clarity: "VVS1",
                                lotNumber: product.productSku,
                                certificateNumber: "230000066395",
                                measurements: "10.18 x 8.34 x 6.14",
                                lab: product.labs,
                                cut: "Excellent",
                                polish: "Excellent",
                                symmetry: "Excellent",
                                flourish: "O",
                                tablePercentage: "50",
                                depthPercentage: "50",
                                rap: product.lsp?.setCurrency ?? "\$24,850.00",
                                discount: product.discountPercentageString,
                                perCts: "\$24,850.00",
                                amount: product.finalPrice?.setCurrency ?? "\$1,24,995.50",
                                fluorescence: product.fluorescence ?? '0',
                              ),
                              productId: product.productId,
                              diamond: "1.5 gram",
                              gram: "1.5 gram",
                              imageUrl: diamondListingBloc.screenIdentifier == ScreenIdentifier.productForGemstones
                                  ? (index % 2 == 0
                                      ? "https://i.ibb.co/477f41r/Group-1410089379.png"
                                      : "https://i.ibb.co/sggT4PJ/Group-1410089378.png")
                                  : product.imageUrl ?? "https://i.ibb.co/swb5gVs/Round.png",
                              isForAuction: product.isForAuction,
                            ),
                            isAutoSizeText: false,
                            isDiamond: diamondListingBloc.screenIdentifier != ScreenIdentifier.productForGemstones,
                          );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 17.h),
                ),

                // Development
                //ListView.separated(
                //                   itemCount: diamondListingBloc.productList.length,
                //                   shrinkWrap: true,
                //                   physics: const NeverScrollableScrollPhysics(),
                //                   itemBuilder: (context, index) {
                //                     final product = diamondListingBloc.productList[index];
                //
                //                     /// Attributes list for stone info
                //                     List<String> attributes = [
                //                       product.color,
                //                       product.clarity,
                //                       product.cut,
                //                     ].where((attr) => attr != null).map((attr) => attr!).toList();
                //                     return diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY
                //                         ? ProductListItem(
                //                             onTap: () {
                //                               context.pushNamed(AppRoutes.stoneDetailPage,
                //                                   arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //                             },
                //                             onEyeTap: () {},
                //                             onFavTap: () {},
                //                             productDetails: diamondListingBloc.productList[index],
                //                           )
                //                         : ProductInfoItem(
                //                             onTap360View: () => printWrapped("onTap360View"),
                //                             productFeaturesList: attributes,
                //                             onTapDNA: () {
                //                               context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                //                                 RoutesData.cmsPageData: CmsWebViewDataModel(
                //                                   url: diamondListingBloc.productList[index].openDnaUrl,
                //                                   title: APPStrings.dna.tr,
                //                                 )
                //                               });
                //                             },
                //                             onTapCertificate: () {
                //                               context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                //                                 RoutesData.cmsPageData: CmsWebViewDataModel(
                //                                   url: diamondListingBloc.productList[index].certificateFile,
                //                                   title: APPStrings.certificate.tr,
                //                                 )
                //                               });
                //                             },
                //                             onTapImageViewer: () => printWrapped("onTapImageViewer"),
                //                             onTapUSA: () => printWrapped("onTapUSA"),
                //                             onTapMenuButton: () {
                //                               Utils.showSmartModalBottomSheet(
                //                                 context: context,
                //                                 builder: (context) => const ProductMenuBottomSheet(),
                //                               );
                //                             },
                //                             isSelectedBackground: (index % 2 != 0),
                //                             onTap: () {
                //                               if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY) {
                //                                 context.pushNamed(AppRoutes.stoneDetailPage,
                //                                     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //                               } else if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDefault) {
                //                                 context.pushNamed(AppRoutes.productDetailsPage,
                //                                     arguments: {RoutesData.isPageFor: ScreenIdentifier.productForDiamonds});
                //                                 //Below code is commented as discussed with JD and changed the navigation flow of diamond info popup and diamond details page
                //                                 // context.pushNamed(AppRoutes.diamondInfoPopupPage,
                //                                 //     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //                               } else {
                //                                 context.pushNamed(AppRoutes.productDetailsPage,
                //                                     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //                               }
                //                             },
                //                             productDetails: ProductDetailsModel(
                //                               productInfoClarityChat: ProductInfoClarityChat(
                //                                   rapRate: diamondListingBloc.productList[index].rappaportPrice?.setCurrency,
                //                                   //,"\$35,500.00",
                //                                   productId: diamondListingBloc.productList[index].productId,
                //                                   productName: diamondListingBloc.productList[index].name,
                //                                   //"1.00 Cts Round Diamond",
                //                                   ct: "10.04",
                //                                   shape: diamondListingBloc.productList[index].shape,
                //                                   colour: "H",
                //                                   clarity: "VVS1",
                //                                   lotNumber: diamondListingBloc.productList[index].productSku,
                //                                   certificateNumber: "230000066395",
                //                                   measurements: "10.18 x 8.34 x 6.14",
                //                                   lab: diamondListingBloc.productList[index].labs,
                //                                   cut: "Excellent",
                //                                   polish: "Excellent",
                //                                   symmetry: "Excellent",
                //                                   flourish: "O",
                //                                   tablePercentage: "50",
                //                                   depthPercentage: "50",
                //                                   rap: diamondListingBloc.productList[index].lsp?.setCurrency,
                //                                   discount: diamondListingBloc.productList[index].discountPercentage,
                //                                   perCts: "\$24,850.00",
                //                                   amount: diamondListingBloc.productList[index].finalPrice?.setCurrency,
                //                                   fluorescence: diamondListingBloc.productList[index].fluorescence),
                //                               productId: diamondListingBloc.productList[index].productId,
                //                               diamond: "1.5 gram",
                //                               gram: "1.5 gram",
                //                               imageUrl: diamondListingBloc.productList[index].imageUrl,
                //                             ));
                //                   },
                //                   separatorBuilder: (context, index) => SizedBox(height: 17.h),
                //                 ),

                // Prototype
                // ListView.separated(
                //   itemCount: diamondListingBloc.productList.length,
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) => diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY
                //       ? ProductListItem(
                //           onTap: () {
                //             context.pushNamed(AppRoutes.stoneDetailPage,
                //                 arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //           },
                //           onEyeTap: () {},
                //           onFavTap: () {},
                //           productDetails: diamondListingBloc.productList[index],
                //         )
                //       : ProductInfoItem(
                //           onTap360View: () => printWrapped("onTap360View"),
                //           onTapDNA: () {
                //             if(diamondListingBloc.screenIdentifier != ScreenIdentifier.productForGemstones){
                //               context.pushNamed(AppRoutes.diamondInfoPopupPage,
                //                   arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //             }
                //           },
                //           onTapCertificate: () => printWrapped("onTapCertificate"),
                //           onTapImageViewer: () => printWrapped("onTapImageViewer"),
                //           onTapUSA: () => printWrapped("onTapUSA"),
                //           onTapMenuButton: () {
                //             Utils.showSmartModalBottomSheet(
                //               context: context,
                //               builder: (context) => const ProductMenuBottomSheet(),
                //             );
                //           },
                //           isSelectedBackground: (index % 2 != 0),
                //           onTap: () {
                //             if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDIY) {
                //               context.pushNamed(AppRoutes.stoneDetailPage,
                //                   arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //             } else if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondForDefault) {
                //               context.pushNamed(AppRoutes.productDetailsPage,
                //                   arguments: {RoutesData.isPageFor: ScreenIdentifier.productForDiamonds});
                //               //Below code is commented as discussed with JD and changed the navigation flow of diamond info popup and diamond details page
                //               // context.pushNamed(AppRoutes.diamondInfoPopupPage,
                //               //     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //             } else {
                //               context.pushNamed(AppRoutes.productDetailsPage,
                //                   arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                //             }
                //           },
                //           productDetails: ProductDetails(
                //             productInfoClarityChat: ProductInfoClarityChat(
                //               carat: "36.09",
                //                 commodity: "Sapphire",
                //                 origin: "Sri Lanka",
                //                 rapRate: "\$35,500.00",
                //                 productId: "1",
                //                 productName: diamondListingBloc.screenIdentifier == ScreenIdentifier.productForGemstones
                //                     ? "0.35 Carat Super Premium Oval Moissanite"
                //                     : "1.00 Cts Round Diamond",
                //                 ct: "10.04",
                //                 shape: "Marquise",
                //                 colour: "H",
                //                 clarity: "VVS1",
                //                 lotNumber: "MBFG716306",
                //                 certificateNumber: "230000066395",
                //                 measurements: "10.18 x 8.34 x 6.14",
                //                 lab: "GRS",
                //                 cut: "Excellent",
                //                 polish: "Excellent",
                //                 symmetry: "Excellent",
                //                 flourish: "O",
                //                 tablePercentage: "50",
                //                 depthPercentage: "50",
                //                 rap: "\$24,850.00",
                //                 discount: "-30.00",
                //                 perCts: "\$24,850.00",
                //                 amount: "\$1,24,995.50",
                //                 fluorescence: '0'),
                //             productId: "1",
                //             diamond: "1.5 gram",
                //             gram: "1.5 gram",
                //             imageUrl: diamondListingBloc.screenIdentifier == ScreenIdentifier.productForGemstones
                //                 ? index % 2 == 0
                //                     ? "https://i.ibb.co/477f41r/Group-1410089379.png"
                //                     : "https://i.ibb.co/sggT4PJ/Group-1410089378.png"
                //                 : "https://i.ibb.co/swb5gVs/Round.png",
                //             isForAuction: index % 2 == 0,
                //           ),
                //           isAutoSizeText: false,
                //           isDiamond: diamondListingBloc.screenIdentifier != ScreenIdentifier.productForGemstones,
                //         ),
                //   separatorBuilder: (context, index) => SizedBox(height: 17.h),
                // ),
                if (state is StoneListLoadingMoreState) const SmartCircularProgressIndicator(),
                SizedBox(height: 17.h)
              ],
            );
          }
        }
      },
    );
  }

  Widget _buildBottomNavigationBar(StoneListingBloc bloc) {
    return BlocBuilder<StoneListingBloc, StoneListingState>(
      buildWhen: (previous, current) => current is StoneProductLoadedState || current is StoneListLoadingState,
      builder: (context, state) {
        if (state is StoneProductLoadedState) {
          return FilterBottomActionBar(
            controller: bloc.paginationScrollController.controller,
            onFilterTap: () {
              BlocProvider.of<SortFilterBloc>(context).add(AddSortFilterDataEvent(filterOptionList: bloc.filterData, context: context));
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => FilterScreen(
                  onApply: (value) {
                    if (value != null && value is List<FilterData>) {
                      bloc.add(StoneListingFilterEvent(context: context, filterData: value));
                    }
                  },
                ),
              );
            },
            onSortTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => SortScreen(sortData: bloc.sortOptions),
              ).then((onValue) {
                if (onValue != null) {
                  bloc.add(StoneSortEvent(context: context, sortData: onValue[RoutesData.sortData]));
                }
              });
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
