import 'package:kgk/kgk.dart';

class ProductMenuBottomSheet extends StatelessWidget {
  final ProductDetailsModel productDetails;
  final VoidCallback? onAddToBag;
  final VoidCallback? onBuyNow;
  final String? buttonText;
  final BuildContext mainContext;

  ProductMenuBottomSheet({
    super.key,
    required this.productDetails,
    this.onAddToBag,
    this.onBuyNow,
    this.buttonText,
    required this.mainContext,
  });

  final ValueNotifier<bool> showMoreDetails = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final ProductMenuBottomSheetStyle style = AppTheme.of(context).productMenuBottomSheetStyle;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(6.r), topEnd: Radius.circular(6.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          _buildAppBar(context, style),
          Flexible(
            child: SmartSingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                child: ValueListenableBuilder(
                  valueListenable: showMoreDetails,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        // Below code is commented because it is not used in the app for now. It will be used in future for B2B implementation.
                        // if (showMoreDetails.value) ...[
                        //   ..._buildInfoRows(style),
                        //   SizedBox(height: 16.h),
                        //   const Divider(),
                        //   SizedBox(height: 16.h),
                        // ],
                        _buildProductDetailsView(style),
                        SizedBox(height: 16.h),
                        _buildButtons(context),
                        SizedBox(height: 16.h),

                        /// Below code is commented because it is not used in the app for now. It will be used in future for B2B implementation.
                        // if (!StorageManager.instance.getIsSkipLogin() &&
                        //     BlocProvider.of<AppBloc>(context).userType == UserType.b2bUser) ...[
                        //   _buildActionGrid(style, context),
                        //   SizedBox(height: 16.h),
                        // ],
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ProductMenuBottomSheetStyle style) {
    return SmartAppBar(
      isBack: false,
      appBarHeight: AppConst.defaultAppBarHeight,
      isBorder: false,
      backgroundColor: style.backgroundColor,
      actions: [
        InkWell(
          onTap: () {
            context.pop();
          },
          child: SmartImage(path: AppImages.icCross, color: style.primaryColor),
        ),
      ],
    );
  }

  List<Widget> _buildInfoRows(style) {
    return [
      _buildProductDetailsItem(APPStrings.totalDiamonds.tr, '9', '', style),
      SizedBox(height: 12.h),
      _buildProductDetailsItem(APPStrings.totalCarats.tr, '9.00', '', style),
      SizedBox(height: 12.h),
      _buildProductDetailsItem(APPStrings.averageDiscount.tr, '15%', '', style),
      SizedBox(height: 12.h),
      _buildProductDetailsItem(APPStrings.round.tr, '3 ct', '\$30,000.00', style),
      SizedBox(height: 12.h),
      _buildProductDetailsItem(APPStrings.oval.tr, '3 ct', '\$30,000.00', style),
      SizedBox(height: 12.h),
      _buildProductDetailsItem(APPStrings.marquise.tr, '3 ct', '\$30,000.00', style),
    ];
  }

  Widget _buildProductDetailsItem(String title, String quantity, String amount, ProductMenuBottomSheetStyle style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: SmartText(title, style: style.diamondTitleStyle)),
        SizedBox(width: 17.w),
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: SmartText(quantity, style: style.diamondValueStyle, textAlign: TextAlign.end)),
              SizedBox(width: 17.w),
              Expanded(child: SmartText(amount, style: style.diamondValueStyle, textAlign: TextAlign.end)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetailsView(ProductMenuBottomSheetStyle style) {
    return BlocBuilder<MyBagBloc, MyBagState>(
      buildWhen: (previous, current) => current is ShowFullProductDetailsState,
      builder: (context, state) {
        return Row(
          children: [
            SmartText(APPStrings.subTotal.tr, style: style.subTotalStyle),
            SizedBox(width: 8.w),
            Expanded(
              child: SmartText(
                productDetails.finalPrice?.setCurrency,
                style: style.totalAmountStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                isAutoSizeText: true,
              ),
            ),
            // Below code is commented because it is not used in the app for now. It will be used in future for B2B implementation.
            // InkWell(
            //   onTap: () {
            //     showMoreDetails.value = !showMoreDetails.value;
            //   },
            //   child: SmartText(
            //     showMoreDetails.value ? APPStrings.lessDetails.tr : APPStrings.moreDetails.tr,
            //     style: style.moreDetailsStyle,
            //   ),
            // ),
          ],
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        SmartButton(
          onTap: () {
            if (buttonText.isNullOrEmpty) {
              if (productDetails.isAddedToCart) {
                context.pop(arguments: {RoutesData.isGoToBag: true});
              } else {
                BlocProvider.of<AppBloc>(context).add(ProductAddToBagEvent(productDetails, context));
              }
            } else {
              onAddToBag?.call();
            }
            context.pop();
          },
          title:
              buttonText ?? ((productDetails.isAddedToCart ? APPStrings.goToBag.tr : APPStrings.addToBag.tr)).toLowerCase().capitalizeFirst,
          prefixImage: AppImages.icShoppingBag,
        ),
        SizedBox(height: 8.h),

        /// For now Buy Now is removed from the app. It will be used in future for B2B implementation.
        // SmartButton(
        //     onTap: () {
        //       onBuyNow?.call();
        //       context.pop();
        //     },
        //     title: APPStrings.buyNow.tr.toLowerCase().capitalizeFirst),
      ],
    );
  }

  Widget _buildActionGrid(ProductMenuBottomSheetStyle style, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionItem(AppImages.icComment, APPStrings.discuss.tr, () {}, style),
        _buildActionItem(AppImages.icMeeting, APPStrings.meeting.tr, () {}, style),
        _buildActionItem(AppImages.icFile, APPStrings.quotation.tr, () {
          context.pop();
          Utils.showSmartModalBottomSheet(
            context: context,
            builder:
                (context) => QuotationRequestConfirmation(
                  onContinueShopping: () {
                    context.pop();
                  },
                ),
          );
        }, style),
        _buildActionItem(AppImages.icExport, APPStrings.export.tr, () {}, style),
        _buildActionItem(AppImages.icMoreHorizontal, APPStrings.more.tr, () {}, style),
      ],
    );
  }

  Widget _buildActionItem(String imagePath, String text, VoidCallback onTap, ProductMenuBottomSheetStyle style) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 32.w, width: 32.w, child: Center(child: SmartImage(path: imagePath))),
            SmartText(text, style: style.imageLableStyle, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
