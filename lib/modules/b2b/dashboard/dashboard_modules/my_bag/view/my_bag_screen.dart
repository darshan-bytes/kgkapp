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
              onFavorite: () {},
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
                  const SizedBox(height: 24),
                  _buildSelectAllProductBox(bloc, style),
                  const SizedBox(height: 24),
                  _buildMyBagList(bloc),
                  _buildOrderSummary(bloc, style),
                  const SizedBox(height: 32),
                  _buildInquirySection(bloc, style),
                  const SizedBox(height: 24),
                  _buildSuggestedProductList(bloc, style)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectAllProductBox(MyBagBloc bloc, MyBagScreenStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SmartText(
            APPStrings.productX.tr.interpolate([bloc.myBagProductList.length.toString()]),
            style: style.productsTitleStyle,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SmartCheckbox(
                  height: 24,
                  width: 24,
                  value: bloc.selectAllProduct,
                  onChanged: (value) {
                    bloc.add(MyBagSelectAllProductChangedEvent(selectAllProduct: !bloc.selectAllProduct));
                  },
                  label: APPStrings.selectProductItemX.tr.interpolate([bloc.selectedProductCountString]),
                  labelStyle: style.itemSelectedStyle,
                ),
              ),
              const SizedBox(width: 20),
              SmartText("\$${bloc.totalPrice}", style: style.totalAmountStyle),
            ],
          ),
          const SizedBox(height: 16),
          SmartButton(onTap: () {}, title: APPStrings.checkout.tr),
          const SizedBox(height: 24),
          const Divider()
        ],
      ),
    );
  }

  Widget _buildMyBagList(MyBagBloc bloc) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      itemBuilder: (context, index) {
        ProductDetails product = bloc.myBagProductList[index];
        return CartProductItem(
          selectedQuality: product.productQuality,
          selectedQuantity: product.productQuantity,
          onRemoveTap: () {
            bloc.add(MyBagRemoveProduct(index: index, productDetails: product));
          },
          onMoveToWishListTap: () {},
          margin: const EdgeInsets.only(bottom: 24),
          onEyeTap: () {},
          onTap: () {
            context.pushNamed(AppRoutes.productDetailsPage, arguments: {RoutesData.productId: product.productId});
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
            bloc.add(MyBagSelectProductChangedEvent(index: index, isSelectedProduct: !product.isSelectedProduct));
          },
        );
      },
      itemCount: bloc.myBagProductList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildOrderSummary(MyBagBloc bloc, MyBagScreenStyle style) {
    return OrderSummary(
      onTapCheckout: () {},
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
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        children: [
          InquiryWidget(
            phone: bloc.inquiryPhone,
            email: bloc.inquiryEmail,
            isRightArrow: false,
            title: APPStrings.unhappyWithPricing.tr,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SmartImage(
                path: AppImages.icDiamond,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 16),
              SmartText(
                APPStrings.diamondPurityYouCanTrust.tr,
                style: style.diamondPurityStyle,
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SmartImage(path: AppImages.icTruck),
              const SizedBox(width: 16),
              SmartText(
                APPStrings.shippingAcrossAllCountries.tr,
                style: style.diamondPurityStyle,
              )
            ],
          ),
          const SizedBox(height: 32),
          const Divider(height: 1),
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
          optionalPadding: const EdgeInsets.only(left: 17),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 12.0,
              runSpacing: 12,
              children: bloc.suggestedProductList.map((product) {
                return ProductGridItem(
                  margin: const EdgeInsets.only(bottom: 17),
                  onEyeTap: () {},
                  onFavTap: () {},
                  onAddToBagTap: () {},
                  productDetails: product,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
