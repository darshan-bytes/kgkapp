import 'package:kgk/kgk.dart';

class MyBagScreen extends StatelessWidget {
  const MyBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyBagBloc bloc = BlocProvider.of<MyBagBloc>(context);
    final MyBagScreenStyle style = AppTheme.of(context).myBagScreenStyle;

    return BlocBuilder<MyBagBloc, MyBagState>(
      buildWhen: (previous, current) => current is MyBagLoadedState,
      builder: (context, state) {
        return Scaffold(
          appBar: SmartAppBar(
            appBarHeight: AppConst.appBarHeight.height,
            title: APPStrings.myBag.tr,
            isBack: false,
            onSearch: () {
              context.pushNamed(AppRoutes.searchPage);
            },
            onFavorite: () {
              context.pushNamed(AppRoutes.wishListPage);
            },
          ),
          body: _getBody(bloc, style),
          bottomNavigationBar: bloc.myBagProductList.isEmpty ? null : buildCheckoutButton(context, style, bloc),
        );
      },
    );
  }

  Widget? buildBottomNavBar(MyBagBloc bloc, MyBagScreenStyle style, BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: style.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: style.bottomNavBarShadowColor,
              offset: const Offset(0, -8),
              blurRadius: 24.r,
            ),
          ],
        ),
        child: BlocBuilder<MyBagBloc, MyBagState>(
          buildWhen: (_, current) => current is MyBagToggleReadMoreDetailsState,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: bloc.isReadMoreDetailsOpen
                      ? Column(
                          children: [
                            BlocBuilder<MyBagBloc, MyBagState>(
                              buildWhen: (_, current) => current is MyBagPaymentConditionChangedState,
                              builder: (context, state) {
                                return SmartDropDown(
                                  focusNode: bloc.paymentConditionFocusNode,
                                  onChanged: (value) {
                                    if (value != null) {
                                      bloc.variationFocusNode.requestFocus();
                                      bloc.add(MyBagPaymentConditionChangedEvent(paymentCondition: value));
                                    }
                                  },
                                  items: bloc.paymentConditionList.map((e) => SmartDropDownItem(title: e.name ?? '', value: e)).toList(),
                                  selectedItem: bloc.selectedPaymentCondition,
                                  hintText: APPStrings.paymentCondition.tr,
                                  labelText: APPStrings.paymentCondition.tr,
                                );
                              },
                            ),
                            SizedBox(height: 24.h),
                            SmartTextField(
                              suffixText: APPStrings.percentage,
                              labelText: APPStrings.plusMinus,
                              hintText: APPStrings.plusMinus,
                              controller: bloc.variationController,
                              focusNode: bloc.variationFocusNode,
                              nextFocus: bloc.noteFocusNode,
                              textInputFormatter: [DoubleInputFormatter()],
                              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                            ),
                            SizedBox(height: 24.h),
                            SmartTextField(
                              labelText: APPStrings.commentQuestion.tr,
                              hintText: APPStrings.commentQuestion.tr,
                              controller: bloc.noteController,
                              focusNode: bloc.noteFocusNode,
                              maxLines: 3,
                              textInputAction: TextInputAction.newline,
                            ),
                            SizedBox(height: 24.h),
                            const Divider(),
                            SizedBox(height: 24.h),
                          ],
                        )
                      : const SizedBox(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: APPStrings.total.tr,
                          style: style.bottomBarTotalTextStyle,
                          children: [
                            WidgetSpan(child: SizedBox(width: 8.w)),
                            TextSpan(
                              text: '\$35,700.00',
                              style: style.bottomBarTotalAmountTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SmartText(
                      onTap: () {
                        bloc.add(const MyBagToggleReadMoreDetailsEvent());
                      },
                      bloc.isReadMoreDetailsOpen ? APPStrings.readLess.tr : APPStrings.moreDetails.tr,
                      style: style.bottomBarMoreLessTextStyle,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                buildCheckoutButton(context, style, bloc),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getBody(MyBagBloc bloc, MyBagScreenStyle style) {
    return SafeArea(
      child: BlocBuilder<MyBagBloc, MyBagState>(
        buildWhen: (_, current) => current is MyBagLoadedState,
        builder: (context, state) {
          if (bloc.myBagProductList.isEmpty) {
            return Center(child: SmartText(APPStrings.myBagEmpty.tr));
          }
          return SmartSingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24.h),
                _buildSelectAllProductBox(bloc, style, context),
                SizedBox(height: 24.h),
                _buildMyBagList(bloc, style),
                _buildBagTotalDiamondItemsDetails(bloc, style),
                SizedBox(height: 24.h),
                _buildOrderSummary(bloc, style, context),
                SizedBox(height: 32.h),
                _buildInquirySection(bloc, style),
                if (bloc.suggestedProductList.isNotEmpty) ...[
                  SizedBox(height: 24.h),
                  _buildSuggestedProductList(bloc, style, context),
                ],
                if (bloc.mostPurchaseProductList.isNotEmpty) ...[
                  SizedBox(height: 24.h),
                  _buildMostPurchaseProductList(bloc, style, context),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectAllProductBox(MyBagBloc bloc, MyBagScreenStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: SmartText(
                  APPStrings.productX.tr.interpolate([bloc.myBagProductList.length.toString()]),
                  style: style.productsTitleStyle,
                ),
              ),
              SelectionButton(
                width: 48.w,
                imageHeight: 24.5.w,
                imageWidth: 24.5.w,
                isSelected: true,
                selectedButtonColor: style.backgroundColor,
                selectedButtonBorderColor: style.menuBorderColor,
                selectedButtonIconColor: style.menuIconColor,
                image: AppImages.icMenu,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: SmartCheckbox(
                  height: 24.w,
                  width: 24.w,
                  value: bloc.selectAllProduct,
                  onChanged: (value) {
                    bloc.add(MyBagSelectAllProductChangedEvent(selectAllProduct: !bloc.selectAllProduct));
                  },
                  label: APPStrings.selectProductItemX.tr.interpolate([bloc.selectedProductCountString]),
                  labelStyle: style.itemSelectedStyle,
                ),
              ),
              SizedBox(width: 20.w),
              SmartText("\$35,700.00", style: style.totalAmountStyle),
            ],
          ),
          // Commented below code for: Feedback - 30=> Bottom checkout is not needed as we have fixed checkout button is available.
          // We discussed yesterday regarding that also remove it from the top too.
          // SizedBox(height: 16.h),
          // buildCheckoutButton(context),
          SizedBox(height: 24.h),
          const Divider()
        ],
      ),
    );
  }

  Widget buildCheckoutButton(BuildContext context, MyBagScreenStyle style, MyBagBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.w),
      color: style.backgroundColor,
      child: SmartButton(
        onTap: () {
          bloc.add(MyBagCheckoutEvent(context: context));
        },
        title: APPStrings.checkout.tr,
      ),
    );
  }

  Widget _buildMyBagList(MyBagBloc bloc, MyBagScreenStyle style) {
    return BlocBuilder<MyBagBloc, MyBagState>(
      buildWhen: (_, current) => current is MyBagToggleViewModeState,
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          itemBuilder: (context, index) {
            ProductDetailsModel product = bloc.myBagProductList[index];
            switch (bloc.commodity) {
              case Commodity.diamond:
                return Column(
                  children: [
                    ProductInfoItem(
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
                        handleDiamondMenuButtonTap(context, index, bloc, style);
                        //currently opened bottom sheet for remove lot and add to watchlist
                        // Utils.showSmartModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => const ProductMenuBottomSheet(),
                        // );
                      },
                      isSelectedBackground: false,
                      onTap: () {},
                      onYourDiscountChange: (value) {
                        FocusScope.of(context).unfocus();
                        if (value != null) {
                          bloc.add(MyBagYourDiscountChangedEvent(context: context, index: index, yourDiscount: value));
                        }
                      },
                      productDetails: ProductDetailsModel(
                        productInfoClarityChat: ProductInfoClarityChat(
                          carat: product.ctsOrGms?.toString(),
                          commodity: product.commodity?.value,
                          rapRate: product.rappaportPrice?.setCurrency,
                          productId: product.productId,
                          productName: product.name,
                          ct: product.cut,
                          shape: product.shape,
                          colour: product.color,
                          clarity: product.clarity,
                          lotNumber: product.lotCode,
                          certificateNumber: product.certificateNumber,
                          measurements: product.measurements,
                          lab: product.labs,
                          cut: product.cut,
                          polish: product.polish,
                          fluorescence: product.fluorescence,
                          tablePercentage: product.table,
                          depthPercentage: product.depth,
                          rap: product.rappaportPrice,
                          discount: product.discountPercentage,
                          perCts: product.perCaratPrice?.setCurrency,
                          amount: product.totalPrice?.setCurrency,
                          your: product.yourDiscount?.toString(),
                          yourRate: product.yourRate?.setCurrency,
                          yourValue: product.yourAmount?.setCurrency,
                        ),
                        productId: product.productId,
                        // diamond: "1.5 gram",
                        // gram: "1.5 gram",
                        imageUrl: product.imageUrl,
                        isForAuction: false,
                      ),
                      isAutoSizeText: false,
                      isDiamond: true,
                    ),
                    SizedBox(height: 16.h),
                  ],
                );
              case Commodity.gemstone:
                return Column(
                  children: [
                    ProductInfoItem(
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
                        handleDiamondMenuButtonTap(context, index, bloc, style);
                        //currently opened bottom sheet for remove lot and add to watchlist
                        // Utils.showSmartModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => const ProductMenuBottomSheet(),
                        // );
                      },
                      isSelectedBackground: false,
                      onTap: () {},
                      productDetails: ProductDetailsModel(
                        productInfoClarityChat: ProductInfoClarityChat(
                          carat: product.ctsOrGms?.toString(),
                          commodity: product.commodity?.value,
                          rapRate: product.rappaportPrice?.setCurrency,
                          productId: product.productId,
                          productName: product.name,
                          ct: product.cut,
                          shape: product.shape,
                          colour: product.color,
                          clarity: product.clarity,
                          lotNumber: product.lotCode,
                          certificateNumber: product.certificateNumber,
                          measurements: product.measurements,
                          lab: product.labs,
                          cut: product.cut,
                          polish: product.polish,
                          fluorescence: product.fluorescence,
                          tablePercentage: product.table,
                          depthPercentage: product.depth,
                          rap: product.rappaportPrice,
                          discount: product.discountPercentage,
                          perCts: product.perCaratPrice?.setCurrency,
                          amount: product.totalPrice?.setCurrency,
                          origin: product.location,
                          your: product.yourDiscount?.toString(),
                          yourRate: product.yourRate?.setCurrency,
                          yourValue: product.yourAmount?.setCurrency,
                        ),
                        productId: product.productId,
                        imageUrl: product.imageUrl,
                        isForAuction: false,
                      ),
                      isAutoSizeText: false,
                      isDiamond: false,
                    ),
                    SizedBox(height: 16.h),
                  ],
                );
              case Commodity.jewellery:
                return CartProductItem(
                  productDetails: product,
                  onRemoveTap: () {
                    bloc.add(MyBagRemoveProductEvent(context: context, index: index));
                  },
                  onMoveToWishListTap: () {
                    bloc.add(MyBagAddToWatchlistEvent(index: index, context: context));
                  },
                  onQuantityChanged: (quantity) {
                    bloc.add(MyBagProductQuantityChangedEvent(context: context, index: index, quantity: quantity.quantity ?? 0));
                  },
                  quantityOptionsList: List.generate(
                      product.stockQty ?? 0, (index) => CartProductQuantity(name: (index + 1).toString(), quantity: index + 1)),
                  selectedQuantity: product.quantity != null
                      ? CartProductQuantity(name: (product.quantity!).toString(), quantity: product.quantity)
                      : null,
                  qualityOptionsList: [],
                );
              default:
                return const SizedBox.shrink();
            }
            /*if (product.isDiamondProduct) {
              return Column(
                children: [
                  ProductInfoItem(
                    onTap360View: () => printWrapped("onTap360View"),
                    onTapDNA: () {
                      context.pushNamed(AppRoutes.diamondInfoPopupPage,
                          arguments: {RoutesData.isPageFor: ScreenIdentifier.productForGemstones});
                    },
                    onTapCertificate: () => printWrapped("onTapCertificate"),
                    onTapImageViewer: () => printWrapped("onTapImageViewer"),
                    onTapUSA: () => printWrapped("onTapUSA"),
                    onTapMenuButton: () {
                      //currently opened bottom sheet for remove lot and add to watchlist
                      handleDiamondMenuButtonTap(context, index, bloc, style);
                      // Utils.showSmartModalBottomSheet(
                      //   context: context,
                      //   builder: (context) => const ProductMenuBottomSheet(),
                      // );
                    },
                    isSelectedBackground: false,
                    onTap: () {},
                    productDetails: ProductDetailsModel(
                      productInfoClarityChat: ProductInfoClarityChat(
                          carat: "36.09",
                          commodity: "Sapphire",
                          origin: "Sri Lanka",
                          rapRate: "\$35,500.00",
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
                          rap: "\$24,850.00",
                          discount: "-30.00",
                          perCts: "\$24,850.00",
                          amount: "\$1,24,995.50",
                          fluorescence: '0'),
                      productId: "1",
                      diamond: "1.5 gram",
                      gram: "1.5 gram",
                      imageUrl: "https://i.ibb.co/swb5gVs/Round.png",
                      isForAuction: false,
                    ),
                    isAutoSizeText: false,
                    isDiamond: true,
                  ),
                  SizedBox(height: 16.h),
                ],
              );
            } else {
              return Column(
                children: [
                  ProductInfoItem(
                    onTap360View: () => printWrapped("onTap360View"),
                    onTapDNA: () {},
                    onTapCertificate: () => printWrapped("onTapCertificate"),
                    onTapImageViewer: () => printWrapped("onTapImageViewer"),
                    onTapUSA: () => printWrapped("onTapUSA"),
                    onTapMenuButton: () {
                      Utils.showSmartModalBottomSheet(
                        context: context,
                        builder: (context) => const ProductMenuBottomSheet(),
                      );
                    },
                    isSelectedBackground: false,
                    onTap: () {},
                    productDetails: ProductDetailsModel(
                      productInfoClarityChat: ProductInfoClarityChat(
                          carat: "36.09",
                          commodity: "Sapphire",
                          origin: "Sri Lanka",
                          rapRate: "\$35,500.00",
                          productId: "1",
                          productName: "AAAA",
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
                          rap: "\$24,850.00",
                          discount: "-30.00",
                          perCts: "\$24,850.00",
                          amount: "\$1,24,995.50",
                          fluorescence: '0'),
                      productId: "1",
                      diamond: "1.5 gram",
                      gram: "1.5 gram",
                      imageUrl: index % 2 == 0
                          ? "https://i.ibb.co/477f41r/Group-1410089379.png"
                          : "https://i.ibb.co/sggT4PJ/Group-1410089378.png",
                      isForAuction: false,
                    ),
                    isAutoSizeText: false,
                    isDiamond: false,
                  ),
                  SizedBox(height: 16.h),
                ],
              );
            }*/
          },
          itemCount: bloc.myBagProductList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        );
      },
    );
  }

  Widget _buildOrderSummary(MyBagBloc bloc, MyBagScreenStyle style, BuildContext context) {
    return BlocBuilder<MyBagBloc, MyBagState>(
      buildWhen: (previous, current) => current is MyBagOrderSummaryDataLoadedState,
      builder: (context, state) {
        if (state is! MyBagOrderSummaryDataLoadedState) {
          return const SizedBox.shrink();
        }
        BagOrderSummaryDataModel? bagOrderSummary = bloc.bagOrderSummaryData;
        return OrderSummary(
          promoCode: bagOrderSummary?.promoCode,
          onApplyPromoCode: (promoCode) {
            bloc.add(MyBagApplyPromoCodeEvent(context: context, promoCode: promoCode));
          },
          onTapRemovePromoCode: () {
            bloc.add(MyBagRemovePromoCodeEvent(context));
          },
          onTapCheckout: () {
            bloc.add(MyBagCheckoutEvent(context: context));
          },
          items: bagOrderSummary?.charges
                  .map(
                    (e) => OrderSummaryItem(
                      title: e.title ?? '',
                      value: e.displayValue?.setCurrency ?? '',
                    ),
                  )
                  .toList() ??
              [],
          totalPrice: bagOrderSummary?.totalAmount?.setCurrency ?? '',
        );
      },
    );
  }

  Widget _buildInquirySection(MyBagBloc bloc, MyBagScreenStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: Column(
        children: [
          InquiryWidget(
            phone: bloc.inquiryPhone,
            email: bloc.inquiryEmail,
            isRightArrow: false,
            title: APPStrings.unhappyWithPricing.tr,
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              SmartImage(
                path: AppImages.icDiamond,
                height: 24.w,
                width: 24.w,
              ),
              SizedBox(width: 16.w),
              SmartText(
                APPStrings.diamondPurityYouCanTrust.tr,
                style: style.diamondPurityStyle,
              )
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const SmartImage(path: AppImages.icTruck),
              SizedBox(width: 16.w),
              SmartText(
                APPStrings.shippingAcrossAllCountries.tr,
                style: style.diamondPurityStyle,
              )
            ],
          ),
          SizedBox(height: 32.h),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildSuggestedProductList(MyBagBloc bloc, MyBagScreenStyle style, BuildContext context) {
    return SmartSuggestionProductList(
        title: APPStrings.youMayAlsoLike.tr,
        onViewAllTap: () {
          context.pushNamed(AppRoutes.productListGridPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForRing});
        },
        suggestedProductList: bloc.suggestedProductList,
        onEyeTap: () {},
        onFavTap: () {},
        scrollController: bloc.scrollController);
  }

  Widget _buildMostPurchaseProductList(MyBagBloc bloc, MyBagScreenStyle style, BuildContext context) {
    return SmartSuggestionProductList(
        title: APPStrings.mostPurchasedDiamonds.tr,
        onViewAllTap: () {
          context.pushNamed(AppRoutes.stoneListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.diamondForDefault});
        },
        suggestedProductList: bloc.mostPurchaseProductList,
        onEyeTap: () {},
        onFavTap: () {},
        scrollController: bloc.mostPurchaseScrollController);
  }

  Widget _buildBagTotalDiamondItemsDetails(MyBagBloc bloc, MyBagScreenStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(bloc.commodity == Commodity.jewellery ? APPStrings.totalItems.tr : APPStrings.totalStones.tr,
                  bloc.bagListDataModel?.summary?.totalItems?.toString() ?? '-', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(
                  APPStrings.origTotalDiscount.tr, '${bloc.bagListDataModel?.summary?.discountPercentage?.toString() ?? '0.0'}%', style)
            ],
          ),
          BlocBuilder<MyBagBloc, MyBagState>(
            buildWhen: (previous, current) => current is MyBagSalesmanListLoadedState,
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                itemCount: bloc.salesmanList.length,
                itemBuilder: (context, index) {
                  AssignClient? salesman = bloc.salesmanList[index].assignClient;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextInfoColumn(APPStrings.contactEmail.tr, salesman?.email ?? '-', style),
                      SizedBox(width: 12.w),
                      _buildTextInfoColumn(APPStrings.contactPhone.tr, salesman?.internalUser?.phoneNumber ?? '-', style),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(
                  APPStrings.totalPriceAfterDiscount.tr, bloc.bagListDataModel?.summary?.discountAmount?.setCurrency ?? '-', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.totalWeight.tr, bloc.bagListDataModel?.summary?.totalCarats?.toString() ?? '-', style),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.avgPricePerCarat.tr, '\$14,937.38 (S)', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.originalRatePerCarat.tr, '14,937.38 (S)', style),
            ],
          ),
          if (bloc.userType == UserType.b2bUser) ...[
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextInfoColumn(
                    APPStrings.totalRequestedDiscount.tr, "${bloc.bagListDataModel?.summary?.yourDiscount?.toString() ?? '0'}%", style),
                SizedBox(width: 12.w),
                _buildTextInfoColumn(
                    APPStrings.totalValueAfterDiscount.tr, bloc.bagListDataModel?.summary?.yourAmount?.setCurrency ?? '', style),
              ],
            ),
            SizedBox(height: 24.h),
          ],
          if (bloc.userType == UserType.b2bUser)
            BlocBuilder<MyBagBloc, MyBagState>(
              buildWhen: (previous, current) => current is MyBagPaymentConditionsLoadedState,
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<MyBagBloc, MyBagState>(
                      buildWhen: (_, current) => current is MyBagPaymentConditionChangedState,
                      builder: (context, state) {
                        return SmartDropDown(
                          focusNode: bloc.paymentConditionFocusNode,
                          onChanged: (value) {
                            if (value != null) {
                              bloc.variationFocusNode.requestFocus();
                              bloc.add(MyBagPaymentConditionChangedEvent(paymentCondition: value));
                            }
                          },
                          items: bloc.paymentConditionList.map((e) => SmartDropDownItem(title: e.name ?? '', value: e)).toList(),
                          selectedItem: bloc.selectedPaymentCondition,
                          hintText: APPStrings.paymentCondition.tr,
                          labelText: APPStrings.paymentCondition.tr,
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    SmartTextField(
                      suffixText: APPStrings.percentage,
                      labelText: APPStrings.plusMinus,
                      hintText: APPStrings.plusMinus,
                      controller: bloc.variationController,
                      focusNode: bloc.variationFocusNode,
                      nextFocus: bloc.noteFocusNode,
                      textInputFormatter: [DoubleInputFormatter()],
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    ),
                    SizedBox(height: 24.h),
                    SmartTextField(
                      labelText: APPStrings.commentQuestion.tr,
                      hintText: APPStrings.commentQuestion.tr,
                      controller: bloc.noteController,
                      focusNode: bloc.noteFocusNode,
                      maxLines: 3,
                      textInputAction: TextInputAction.newline,
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTextInfoColumn(String title, String value, MyBagScreenStyle style) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            title,
            style: style.bottomBarTotalTextStyle,
          ),
          SizedBox(height: 8.h),
          SmartText(
            value,
            style: style.textInfoValueStyle,
          ),
        ],
      ),
    );
  }

  void handleDiamondMenuButtonTap(BuildContext mainContext, int index, MyBagBloc bloc, MyBagScreenStyle style) {
    Utils.showSmartModalBottomSheet(
        context: mainContext,
        backgroundColor: style.backgroundColor,
        builder: (BuildContext context) {
          return buildDiamondMenuPopUp(context, index, bloc, mainContext);
        });
  }

  Widget buildDiamondMenuPopUp(BuildContext context, int index, MyBagBloc bloc, BuildContext mainContext) {
    final MyBagDiamondItemStyle style = AppTheme.of(context).myBagDiamondItemStyle;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildRowButton(
            style,
            () {
              // implemented add to watchlist instead of add to wishlist
              context.pop();
              if (bloc.myBagProductList[index].productId != null) {
                bloc.add(MyBagAddToWatchlistEvent(index: index, context: mainContext));
              }
            },
            APPStrings.addToWatchList.tr,
            AppImages.icWatchlist,
          ),
          Divider(indent: 16.w, endIndent: 16.w),
          buildRowButton(
            style,
            () {
              context.pop();
              bloc.add(MyBagRemoveProductEvent(index: index, context: mainContext));
            },
            APPStrings.removeLot.tr,
            AppImages.icRemove,
          ),
        ],
      ),
    );
  }

  Widget buildRowButton(MyBagDiamondItemStyle style, GestureTapCallback? onTap, String title, String iconPath) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        child: Row(
          children: [
            SmartImage(path: iconPath, height: 24.w, width: 24.w),
            SizedBox(width: 8.w),
            SmartText(title, style: style.subTitleStyle),
          ],
        ),
      ),
    );
  }
}
