import 'package:kgk/kgk.dart';

class MyBagScreen extends StatelessWidget {
  const MyBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyBagBloc bloc = BlocProvider.of<MyBagBloc>(context);
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
      body: SafeArea(
        child: BlocBuilder<MyBagBloc, MyBagState>(
          buildWhen: (_, current) => current is MyBagReloadState,
          builder: (context, state) {
            if (bloc.myBagProductList.isEmpty) {
              return Center(child: SmartText(APPStrings.myBagEmpty.tr));
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  _buildSelectAllProductBox(bloc, style, context),
                  SizedBox(height: 24.h),
                  _buildMyBagList(bloc),
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
          SmartText(
            APPStrings.productX.tr.interpolate([bloc.myBagProductList.length.toString()]),
            style: style.productsTitleStyle,
          ),
          SizedBox(height: 8.h),
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
          SmartButton(
            onTap: () {
              context.pushNamed(AppRoutes.addressListPage);
            },
            title: APPStrings.checkout.tr,
          ),
          SizedBox(height: 24.h),
          const Divider()
        ],
      ),
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

  _buildSuggestedProductList(MyBagBloc bloc, MyBagScreenStyle style) {
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
          child: SingleChildScrollView(
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
}
