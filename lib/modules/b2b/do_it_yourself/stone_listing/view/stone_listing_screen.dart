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
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ||
                            bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY)
                          SizedBox(height: 16.h),
                        if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ||
                            bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY)
                          DiyProgressWidget(
                            diyType: bloc.diyType,
                            padding: EdgeInsetsDirectional.zero,
                            selectedStep: bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ? 1 : 2,
                            screenIdentifier: bloc.screenIdentifier,
                          ),
                        if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ||
                            bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY)
                          SizedBox(height: 6.h),
                        if (bloc.displaySelection) ...[SizedBox(height: 10.h), _buildSelectionDiamond(bloc)],
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
                  ),
                );
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
      buildWhen:
          (previous, current) => current is StoneChangeTypeState || current is StoneListLoadingState || current is StoneProductLoadedState,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: SelectionButton(
                isSelected: diamondListingBloc.isInitialToggle,
                title: diamondListingBloc.tabOneTitle,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                onTap: () {
                  if (state is! StoneListLoadingState) {
                    diamondListingBloc.add(StoneChangeTypeEvent(true, context));
                  }
                },
              ),
            ),
            Expanded(
              child: SelectionButton(
                isSelected: !diamondListingBloc.isInitialToggle,
                title: diamondListingBloc.tabTwoTitle,
                borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
                onTap: () {
                  if (state is! StoneListLoadingState) {
                    diamondListingBloc.add(StoneChangeTypeEvent(false, context));
                  }
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
      buildWhen:
          (previous, current) =>
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
                APPStrings.showingListLengthX.tr.interpolate([bloc.totalFilteredRecords]),
                style: style.filterProductCountTextStyle,
              ),
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
                      bloc.add(StoneChangeListingTypeEvent(true));
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
                    borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
                    onTap: () {
                      bloc.add(StoneChangeListingTypeEvent(false));
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
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductList(DiamondListingStyle style, StoneListingBloc bloc) {
    return BlocBuilder<StoneListingBloc, StoneListingState>(
      buildWhen:
          (previous, current) =>
              current is StoneDiamondListLoadedState ||
              current is StoneProductLoadedState ||
              current is StoneChangeListingTypeState ||
              current is StoneListLoadingMoreState ||
              current is StoneListLoadedMoreState,
      builder: (context, state) {
        if (bloc.productList.isEmpty &&
            (state is StoneDiamondListLoadedState || state is StoneProductLoadedState || state is StoneChangeListingTypeState)) {
          return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
        } else {
          if (bloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                  items:
                      bloc.productList.map((ProductDetailsModel productDetails) {
                        return ProductGridItem(
                          productDetails: productDetails,
                          isCrtAndGramVisible: false,
                          isForAuction: productDetails.isForAuction,
                          onTap: () {
                            if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ||
                                bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY) {
                              context.pushNamed(
                                AppRoutes.stoneDetailPage,
                                arguments: {
                                  RoutesData.isPageFor: bloc.screenIdentifier,
                                  RoutesData.productId: productDetails.productId,
                                  RoutesData.type: bloc.diyType,
                                },
                              );
                            } else if (bloc.screenIdentifier == ScreenIdentifier.diamondForDefault) {
                              context.pushNamed(
                                AppRoutes.productDetailsPage,
                                arguments: {
                                  RoutesData.isPageFor: ScreenIdentifier.productForDiamonds,
                                  RoutesData.productId: productDetails.productId,
                                },
                              );
                              //Below code is commented as discussed with JD and changed the navigation flow of diamond info popup and diamond details page
                              // context.pushNamed(AppRoutes.diamondInfoPopupPage,
                              //     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                            } else {
                              context.pushNamed(
                                AppRoutes.productDetailsPage,
                                arguments: {RoutesData.isPageFor: bloc.screenIdentifier, RoutesData.productId: productDetails.productId},
                              );
                            }
                          },
                          onEyeTap: bloc.isFavWatchListNotEnableForDIY ? () {} : null,
                          isFavourite: productDetails.isFavourite,
                          onFavTap: bloc.isFavWatchListNotEnableForDIY ? () {} : null,
                          onAddToBagTap:
                              (productDetails.isForAuction ||
                                      (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ||
                                          bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY))
                                  ? null
                                  : () {},
                        );
                      }).toList(),
                ),
                if (state is StoneListLoadingMoreState) const SmartCircularProgressIndicator(),
                SizedBox(height: 17.h),
              ],
            );
          } else {
            return Column(
              children: [
                //Merged
                ListView.separated(
                  itemCount: bloc.productList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = bloc.productList[index];

                    /// Attributes list for stone info
                    List<String> attributes =
                        [product.color, product.clarity, product.cut].where((attr) => attr != null).map((attr) => attr!).toList();

                    return bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ||
                            bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY
                        ? ProductListItem(
                          onTap: () {
                            if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ||
                                bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY) {
                              context.pushNamed(
                                AppRoutes.stoneDetailPage,
                                arguments: {
                                  RoutesData.isPageFor: bloc.screenIdentifier,
                                  RoutesData.productId: product.productId,
                                  RoutesData.type: bloc.diyType,
                                },
                              );
                            }
                          },
                          // onEyeTap: () {},
                          // onFavTap: () {},
                          productDetails: product,
                        )
                        : ProductInfoItem(
                          isFromBag: false,
                          productFeaturesList: attributes,
                          onTap360View: () {
                            if (product.video.isNotNullNorEmpty) {
                              Utils.launchUrlFromString(product.video!);
                            } else {
                              Utils.showMessage(APPStrings.no3DViewAvailable.tr);
                            }
                          },
                          onTapDNA: () {
                            if (product.openDnaUrl != null) {
                              Utils.launchUrlFromString(product.openDnaUrl!);
                            } else {
                              Utils.showMessage(APPStrings.noDnaAvailable.tr);
                            }
                          },
                          onTapCertificate: () {
                            if (product.certificateFile != null) {
                              Utils.launchUrlFromString(product.certificateFile!);
                            } else {
                              Utils.showMessage(APPStrings.noCertificateAvailable.tr);
                            }
                          },
                          onTapImageViewer: () {
                            if (product.imageUrl != null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog.fullscreen(
                                    backgroundColor: Colors.transparent,
                                    child: ProductPhotoViewGallery(imageUrls: [product.imageUrl ?? '']),
                                  );
                                },
                              );
                            } else {
                              Utils.showMessage(APPStrings.noImageAvailable.tr);
                            }
                          },
                          onTapUSA: () => printWrapped("onTapUSA"),
                          onTapMenuButton:
                              product.isForAuction
                                  ? null
                                  : () async {
                                    final value = await Utils.showSmartModalBottomSheet(
                                      context: context,
                                      builder:
                                          (_) => ProductMenuBottomSheet(
                                            mainContext: context,
                                            productDetails: product,
                                            onAddToBag: () {
                                              BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(product, context));
                                            },
                                            onBuyNow: () {
                                              BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(product, context, isBuyNow: true));
                                            },
                                          ),
                                    );
                                    if (value != null && value is Map<RoutesData, dynamic> && value[RoutesData.isGoToBag] == true) {
                                      if (context.mounted) {
                                        BlocProvider.of<LandingBloc>(
                                          context,
                                        ).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context));
                                        context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
                                      }
                                    }
                                  },
                          isSelectedBackground: (index % 2 != 0),
                          onTap: () {
                            if (bloc.screenIdentifier == ScreenIdentifier.diamondForDIY ||
                                bloc.screenIdentifier == ScreenIdentifier.jewelleryForDIY) {
                              context.pushNamed(
                                AppRoutes.stoneDetailPage,
                                arguments: {RoutesData.isPageFor: bloc.screenIdentifier, RoutesData.productId: product.productId},
                              );
                            } else if (bloc.screenIdentifier == ScreenIdentifier.diamondForDefault) {
                              context.pushNamed(
                                AppRoutes.productDetailsPage,
                                arguments: {
                                  RoutesData.isPageFor: ScreenIdentifier.productForDiamonds,
                                  RoutesData.productId: product.productId,
                                },
                              );
                              //Below code is commented as discussed with JD and changed the navigation flow of diamond info popup and diamond details page
                              // context.pushNamed(AppRoutes.diamondInfoPopupPage,
                              //     arguments: {RoutesData.isPageFor: diamondListingBloc.screenIdentifier});
                            } else {
                              context.pushNamed(
                                AppRoutes.productDetailsPage,
                                arguments: {RoutesData.isPageFor: bloc.screenIdentifier, RoutesData.productId: product.productId},
                              );
                            }
                          },
                          productDetails: ProductDetailsModel(
                            suid: product.suid,
                            productInfoClarityChat: ProductInfoClarityChat(
                              rapRate: product.rappaportPrice?.setCurrency,
                              perCts: product.price?.setCurrency,
                              discount: product.discountPercentageString,
                              amount: product.priceCts?.setCurrency,
                              origin: product.origin,
                              stock: product.location,
                              commodity: product.stoneCommodityName,
                              productId: product.productId,
                              productName: product.name,
                              shape: product.shape,
                              lotNumber: product.productSku,
                              lab: product.labs,
                              rap: product.lsp?.setCurrency,
                              fluorescence: product.fluorescence,
                              carat: product.ctsOrGms?.toString(),
                              ct: product.cut,
                              colour: product.color,
                              clarity: product.clarity,
                              certificateNumber: product.certificateNumber,
                              measurements: product.measurements,
                              cut: product.cut,
                              polish: product.polish,
                              tablePercentage: product.table,
                              depthPercentage: product.depth,
                            ),
                            productId: product.productId,
                            imageUrl: product.imageUrl,
                            isForAuction: product.isForAuction,
                          ),
                          isAutoSizeText: false,
                          isDiamond: bloc.screenIdentifier != ScreenIdentifier.productForGemstones,
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
                SizedBox(height: 17.h),
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
              BlocProvider.of<SortFilterBloc>(context).add(
                AddSortFilterDataEvent(
                  filterOptionList: bloc.filterData,
                  context: context,
                  type: bloc.isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal,
                ),
              );
              Utils.showSmartModalBottomSheet(
                context: context,
                builder:
                    (context) => FilterScreen(
                      onApply: (value) {
                        if (value != null && value is List<FilterData>) {
                          bloc.add(StoneListingFilterEvent(context: context, filterData: value));
                        }
                      },
                    ),
              );
            },
            onSortTap: () {
              Utils.showSmartModalBottomSheet(context: context, builder: (context) => SortScreen(sortData: bloc.sortOptions)).then((
                onValue,
              ) {
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
