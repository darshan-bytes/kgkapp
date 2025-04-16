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
            title: APPStrings.bag.tr,
            leadingImage: "https://i.ibb.co/cyvpMrR/KGK-Group-Logo-1.png",
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
                SizedBox(height: 16.h),
                _buildSelectAllProductBox(bloc, style, context),
                SizedBox(height: 24.h),
                _buildMyBagList(bloc, style),
                if (bloc.commodity != Commodity.jewellery) ...[
                  _buildBagTotalDiamondItemsDetails(bloc, style),
                  SizedBox(height: 24.h),
                ],
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
    GlobalKey key = GlobalKey();
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
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
              SmartImage(
                key: key,
                path: AppImages.icMenu,
                onTap: () {
                  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
                  Offset offset = renderBox.localToGlobal(Offset.zero);
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      offset.dx,
                      offset.dy + 24.w,
                      MediaQuery.of(context).size.width - offset.dx - 24.w,
                      MediaQuery.of(context).size.height - offset.dy,
                    ),
                    items: [
                      PopupMenuItem(
                        value: 0,
                        onTap: () {
                          bloc.add(MyBagRemoveAllProductEvent(context: context));
                        },
                        child: SmartText(APPStrings.removeAll.tr),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// Below code is commented as of now no need to display selection of all products and checkbox.
              /*Expanded(
                child: BlocBuilder<MyBagBloc, MyBagState>(
                  buildWhen: (previous, current) =>
                      current is MyBagSelectAllProductChangedState || current is MyBagSelectProductChangedState,
                  builder: (context, state) {
                    return SmartCheckbox(
                      height: 24.w,
                      width: 24.w,
                      value: bloc.selectAllProduct,
                      onChanged: (value) {
                        bloc.add(MyBagSelectAllProductChangedEvent(selectAllProduct: !bloc.selectAllProduct));
                      },
                      label: APPStrings.selectProductItemX.tr.interpolate([bloc.selectedProductCountString]),
                      labelStyle: style.itemSelectedStyle,
                    );
                  },
                ),
              ),*/
              SizedBox(width: 20.w),
              BlocBuilder<MyBagBloc, MyBagState>(
                buildWhen: (previous, current) => current is MyBagOrderSummaryDataLoadedState,
                builder: (context, state) {
                  return SmartText(bloc.bagOrderSummaryData?.totalAmount?.setCurrency, style: style.totalAmountStyle);
                },
              ),
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
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 18.w),
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
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
          itemBuilder: (context, index) {
            ProductDetailsModel product = bloc.myBagProductList[index];
            switch (bloc.commodity) {
              case Commodity.diamond:
                return Column(
                  children: [
                    ProductInfoItem(
                      isOutOfStock: (product.stockQty ?? 0) < (product.quantity ?? 0),
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
                      onTapMenuButton: () {
                        handleDiamondMenuButtonTap(context, index, bloc, style);
                        //currently opened bottom sheet for remove lot and add to watchlist
                        // Utils.showSmartModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => const ProductMenuBottomSheet(),
                        // );
                      },
                      isSelectedBackground: false,
                      onTap: () {
                        _onProductTap(context, product, bloc);
                      },
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
                          stock: product.location,
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
                          discount: product.discountPercentageString,
                          perCts: product.yourRate?.setCurrency,
                          amount: product.totalPrice?.setCurrency,
                          your: product.yourDiscount?.toString(),
                          yourRate: product.yourRate?.setCurrency,
                          yourValue: product.yourAmount?.setCurrency,
                        ),
                        productId: product.productId,
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
                      isOutOfStock: (product.stockQty ?? 0) < (product.quantity ?? 0),
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
                      onTapMenuButton: () {
                        handleDiamondMenuButtonTap(context, index, bloc, style);
                        //currently opened bottom sheet for remove lot and add to watchlist
                        // Utils.showSmartModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => const ProductMenuBottomSheet(),
                        // );
                      },
                      isSelectedBackground: false,
                      onTap: () {
                        _onProductTap(context, product, bloc);
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
                          stock: product.location,
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
                          discount: product.discountPercentageString,
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
                  isOutOfStock: (product.stockQty ?? 0) < (product.quantity ?? 0),
                  onTap: () {
                    _onProductTap(context, product, bloc);
                  },
                  productDetails: product,
                  onChangedCheckbox: (value) {
                    bloc.add(MyBagSelectProductChangedEvent(index: index));
                  },
                  onRemoveTap: () {
                    bloc.add(MyBagRemoveProductEvent(context: context, index: index));
                  },
                  onMoveToWishListTap: () {
                    bloc.add(MyBagMoveToWishListEvent(index: index, context: context));
                  },
                  onQuantityChanged: (quantity) {
                    bloc.add(MyBagProductQuantityChangedEvent(context: context, index: index, quantity: quantity.quantity ?? 0));
                  },
                  quantityOptionsList: List.generate(
                      ((product.stockQty ?? 0) < (product.quantity ?? 0) ? product.quantity : product.stockQty) ?? 0,
                      (index) => CartProductQuantity(name: (index + 1).toString(), quantity: index + 1)),
                  selectedQuantity: product.quantity != null
                      ? CartProductQuantity(name: (product.quantity!).toString(), quantity: product.quantity)
                      : null,
                  qualityOptionsList: [],
                );
              default:
                return const SizedBox.shrink();
            }
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
          onTapCheckout: () {
            bloc.add(MyBagCheckoutEvent(context: context));
          },
          items: bagOrderSummary?.charges
                  .map((e) => OrderSummaryItem(title: e.title ?? '', value: e.displayValue?.setCurrency ?? ''))
                  .toList() ??
              [],
          totalPrice: bagOrderSummary?.totalAmount?.setCurrency ?? '',
          subTotalPrice: bagOrderSummary?.subTotal?.setCurrency ?? '',
        );
      },
    );
  }

  Widget _buildInquirySection(MyBagBloc bloc, MyBagScreenStyle style) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
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
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
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
                padding: EdgeInsetsDirectional.symmetric(vertical: 12.h),
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
          // Below Code is commented as of now because the values are not clear yet.
          /*SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.avgPricePerCarat.tr, '\$14,937.38 (S)', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.originalRatePerCarat.tr, '14,937.38 (S)', style),
            ],
          ),*/
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
                bloc.add(MyBagMoveToWishListEvent(index: index, context: mainContext));
              }
            },
            APPStrings.moveToWishlist.tr,
            AppImages.icHeart,
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
        padding: EdgeInsetsDirectional.symmetric(vertical: 16.w, horizontal: 16.w),
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

  void _onProductTap(BuildContext context, ProductDetailsModel productDetails, MyBagBloc bloc) {
    if (productDetails.commodity == null) {
      return;
    }
    context.pushNamed(AppRoutes.productDetailsPage, arguments: {
      RoutesData.productId: productDetails.suid ?? '',
      RoutesData.isPageFor: Utils.getScreenIdentifierFromCommodity(productDetails.commodity!)
    }).then(
      (value) {
        if (!bloc.isClosed) {
          bloc.add(InitialMyBagEvent(context: context));
        }
      },
    );
  }
}
