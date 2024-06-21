import 'package:kgk/kgk.dart';

class MyBagScreen extends StatelessWidget {
  const MyBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyBagBloc myBagBloc = BlocProvider.of<MyBagBloc>(context);
    final MyBagScreenStyle style = AppTheme.of(context).myBagScreenStyle;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<MyBagBloc, MyBagState>(
          builder: (context, state) {
            return SmartAppBar(
              title: APPStrings.myBag.tr,
              isBack: false,
              onFilter: () {},
              onFavorite: () {
                context.pushNamed(AppRoutes.wishListPage);
              },
            );
          },
        ),
      ),
      body: _getBody(myBagBloc, style),
      bottomNavigationBar: buildBottomNavBar(myBagBloc, style, context),
    );
  }

  Widget buildBottomNavBar(MyBagBloc myBagBloc, MyBagScreenStyle style, BuildContext context) {
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
                  child: myBagBloc.isReadMoreDetailsOpen
                      ? Column(
                          children: [
                            BlocBuilder<MyBagBloc, MyBagState>(
                              buildWhen: (_, current) => current is MyBagPaymentConditionChangedState,
                              builder: (context, state) {
                                return SmartDropDown(
                                  focusNode: myBagBloc.paymentConditionFocusNode,
                                  onChanged: (value) {
                                    if (value != null) {
                                      myBagBloc.variationFocusNode.requestFocus();
                                      myBagBloc.add(MyBagPaymentConditionChangedEvent(paymentCondition: value));
                                    }
                                  },
                                  items:
                                      myBagBloc.paymentConditionList.map((e) => SmartDropDownItem(title: e.title ?? '', value: e)).toList(),
                                  selectedItem: myBagBloc.selectedPaymentCondition,
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
                              controller: myBagBloc.variationController,
                              focusNode: myBagBloc.variationFocusNode,
                              nextFocus: myBagBloc.noteFocusNode,
                              textInputFormatter: [DoubleInputFormatter()],
                              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                            ),
                            SizedBox(height: 24.h),
                            SmartTextField(
                              labelText: APPStrings.commentQuestion.tr,
                              hintText: APPStrings.commentQuestion.tr,
                              controller: myBagBloc.noteController,
                              focusNode: myBagBloc.noteFocusNode,
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
                        myBagBloc.add(const MyBagToggleReadMoreDetailsEvent());
                      },
                      myBagBloc.isReadMoreDetailsOpen ? APPStrings.readLess.tr : APPStrings.moreDetails.tr,
                      style: style.bottomBarMoreLessTextStyle,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                buildCheckoutButton(context),
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
        buildWhen: (_, current) => current is MyBagReloadState,
        builder: (context, state) {
          if (bloc.myBagProductList.isEmpty) {
            return Center(child: SmartText(APPStrings.myBagEmpty.tr));
          }
          return SmartSingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                _buildSelectAllProductBox(bloc, style, context),
                SizedBox(height: 24.h),
                _buildMyBagList(bloc),
                _buildBagTotalDiamondItemsDetails(bloc, style),
                SizedBox(height: 24.h),
                _buildOrderSummary(bloc, style, context),
                SizedBox(height: 32.h),
                _buildInquirySection(bloc, style),
                SizedBox(height: 24.h),
                _buildSuggestedProductList(bloc, style)
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
          SizedBox(height: 16.h),
          buildCheckoutButton(context),
          SizedBox(height: 24.h),
          const Divider()
        ],
      ),
    );
  }

  Widget buildCheckoutButton(BuildContext context) {
    return SmartButton(
      onTap: () {
        context.pushNamed(AppRoutes.addressListPage);
      },
      title: APPStrings.checkout.tr,
    );
  }

  Widget _buildMyBagList(MyBagBloc bloc) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      itemBuilder: (context, index) {
        ProductDetails product = bloc.myBagProductList[index];
        if (product.isDiamondProduct) {
          return MyBagDiamondItem(
            onTap: () {},
            onTapMenuButton: () {
              handleDiamondMenuButtonTap(context, index, bloc);
            },
            productDetails: product,
            margin: EdgeInsets.only(bottom: 17.h),
          );
        } else {
          return CartProductItem(
            selectedQuality: product.productQuality,
            selectedQuantity: product.productQuantity,
            onRemoveTap: () {
              bloc.add(MyBagRemoveProductEvent(index: index));
            },
            onMoveToWishListTap: () {},
            margin: EdgeInsets.only(bottom: 24.h),
            onEyeTap: () {},
            onTap: () {
              context.pushNamed(AppRoutes.productDetailsPage,
                  arguments: {RoutesData.productId: product.productId, RoutesData.isPageFor: ScreenIdentifier.productForRing});
            },
            productDetails: product,
            qualityOptionsList: product.cartProductQuality ?? [],
            quantityOptionsList: product.cartProductQuantity ?? [],
            onQualityChanged: (CartProductQuality value) {
              bloc.add(MyBagChangeProductQuality(index: index, productQuality: value));
            },
            onQuantityChanged: (CartProductQuantity value) {
              bloc.add(MyBagChangeProductQuantity(index: index, productQuantity: value));
            },
            isSelectedProduct: product.isSelectedProduct,
            onChangedCheckbox: (value) {
              bloc.add(MyBagSelectProductChangedEvent(index: index));
            },
          );
        }
      },
      itemCount: bloc.myBagProductList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildOrderSummary(MyBagBloc bloc, MyBagScreenStyle style, BuildContext context) {
    return OrderSummary(
      onTapCheckout: () {
        context.pushNamed(AppRoutes.addressListPage);
      },
      items: const [
        // Here String come from API
        OrderSummaryItem(title: "Subtotal", value: "\$11,900.00"),
        OrderSummaryItem(title: "Shipping", value: "\$0.00"),
        OrderSummaryItem(title: "Sales tax", value: "\$0.00"),
      ],
      totalPrice: "\$35,700.00",
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

  Widget _buildSuggestedProductList(MyBagBloc bloc, MyBagScreenStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(
          APPStrings.youMayAlsoLike.tr,
          style: style.productsTitleStyle,
          optionalPadding: EdgeInsets.only(left: 17.w),
        ),
        SizedBox(height: 16.h),
        Scrollbar(
          controller: bloc.scrollController,
          thumbVisibility: true,
          child: SmartSingleChildScrollView(
            controller: bloc.scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 12.w,
                runSpacing: 12.2,
                children: bloc.suggestedProductList.map((product) {
                  return ProductGridItem(
                    margin: EdgeInsets.only(bottom: 17.h),
                    onEyeTap: () {},
                    onFavTap: () {},
                    productDetails: product,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
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
              _buildTextInfoColumn(APPStrings.totalStones.tr, '15', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.origTotalDiscount.tr, '-0.45%', style)
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.contactEmail.tr, 'jasons@example.com', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.contactPhone.tr, '66362389', style),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.totalPriceAfterDiscount.tr, '\$3,00,540.00', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.totalWeight.tr, '20.120', style),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.avgPricePerCarat.tr, '\$14,937.38', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.originalRatePerCarat.tr, '14,937.38', style),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInfoColumn(APPStrings.totalRequestedDiscount.tr, '-0.45', style),
              SizedBox(width: 12.w),
              _buildTextInfoColumn(APPStrings.totalValueAfterDiscount.tr, '\$3,00,540.00', style),
            ],
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

  void handleDiamondMenuButtonTap(BuildContext context, int index, MyBagBloc bloc) {
    Utils.showSmartModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (BuildContext context) {
          return buildDiamondMenuPopUp(context, index, bloc);
        });
  }

  Widget buildDiamondMenuPopUp(BuildContext context, int index, MyBagBloc bloc) {
    final MyBagDiamondItemStyle style = AppTheme.of(context).myBagDiamondItemStyle;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildRowButton(style, () {
            //TODO: Add to wishlist functionality
            context.pop();
          }, APPStrings.moveToWishlist.tr, AppImages.icHeart),
          Divider(indent: 16.w, endIndent: 16.w),
          buildRowButton(style, () {
            bloc.add(MyBagRemoveProductEvent(index: index));
            context.pop();
          }, APPStrings.removeLot.tr, AppImages.icRemove),
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
