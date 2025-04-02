import 'package:kgk/kgk.dart';

class ProductInfoItem extends StatelessWidget {
  final ProductDetailsModel productDetails;
  final bool isSelectedBackground;
  final Color? selectedBackgroundColor;
  final Function()? onTap;
  final Function()? onTapMenuButton;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final void Function()? onTap360View;
  final void Function()? onTapCertificate;
  final void Function()? onTapUSA;
  final void Function()? onTapImageViewer;
  final void Function()? onTapDNA;
  final bool? isShowMore;
  final List<String>? productFeaturesList;
  final bool isAutoSizeText;
  final bool isDiamond;
  final void Function(String?)? onYourDiscountChange;
  final bool isFromBag;
  final TextEditingController yourDiscountController = TextEditingController();

  ProductInfoItem({
    super.key,
    required this.productDetails,
    this.onTap,
    this.onTapMenuButton,
    this.padding,
    this.margin = EdgeInsetsDirectional.zero,
    this.onTap360View,
    this.onTapCertificate,
    this.onTapUSA,
    this.onTapImageViewer,
    this.onTapDNA,
    this.isSelectedBackground = false,
    this.selectedBackgroundColor,
    this.isShowMore,
    this.productFeaturesList,
    this.isAutoSizeText = true,
    this.isDiamond = false,
    this.onYourDiscountChange,
    this.isFromBag = true,
  }) {
    if (productDetails.productInfoClarityChat?.your?.isNotNullNorEmpty == true) {
      yourDiscountController.text = productDetails.productInfoClarityChat?.your ?? '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> showMoreDetails = ValueNotifier<bool>(false);
    final style = AppTheme.of(context).myBagDiamondItemStyle;
    final productInfoItemStyle = AppTheme.of(context).productInfoItemStyle;
    ProductInfoClarityChat chart = productDetails.productInfoClarityChat ?? ProductInfoClarityChat();
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: padding ?? EdgeInsetsDirectional.all(16.0.w),
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: isSelectedBackground ? (selectedBackgroundColor ?? style.selectedBackgroundColor) : style.backgroundColor,
              border: Border.all(color: style.borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (productDetails.isForAuction) SizedBox(height: 30.h),
                _buildProductNameView(chart, style),
                _buildSlotFirstWidget(chart, style, productInfoItemStyle),
                _buildSlotSecondWidget(chart, style, productInfoItemStyle),
                _buildSlotThirdWidget(chart, style, productInfoItemStyle, showMoreDetails),
                _buildSlotFourthWidget(chart, style, productInfoItemStyle),
                if (isFromBag && StorageManager().getUserData()?.userTypeEnum == UserType.b2bUser) ...[
                  Divider(height: 32.h),
                  _buildSlotFiveWidget(chart, style, productInfoItemStyle),
                ],
              ],
            ),
          ),
          if (productDetails.isForAuction)
            PositionedDirectional(
              start: -3.w,
              child: SmartImage(
                path: AppImages.icAuctionLabel(AppLocalizations.of(context)?.locale?.languageCode ?? 'en'),
                fit: BoxFit.fill,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductNameView(ProductInfoClarityChat chart, MyBagDiamondItemStyle style) {
    return Row(
      children: [
        SmartImage(path: productDetails.imageUrl ?? '', height: 32.w, width: 32.w),
        SizedBox(width: 8.w),
        Expanded(
          child: SmartText(
            chart.productName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.headingStyle,
            isAutoSizeText: isAutoSizeText,
          ),
        ),
        SizedBox(width: 8.w),
        if (onTapMenuButton != null)
          SmartImage(
            path: AppImages.icMoreHorizontal,
            onTap: () {
              if (onTapMenuButton != null) {
                onTapMenuButton!();
              }
            },
            height: 24.w,
            width: 24.w,
          )
      ],
    );
  }

  Widget _buildSlotFirstWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle) {
    TextStyle shapeTextStyle = productInfoItemStyle.stoneShapeTextStyle;
    //  Widget myRow = buildHorizontalListview(
    //       productFeaturesList ?? [],
    //       shapeTextStyle,
    //       _buildDivider(style),
    //     );
    //     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //       SizedBox(height: 16.h),
    //       SizedBox(height: 32.h, child: myRow),
    //       const Divider(),
    //       SizedBox(height: 16.h),
    //     ]);
    return Column(
      children: [
        SizedBox(height: 16.h),
        if (isDiamond) ...[
          Wrap(
            children: [
              SmartText(chart.colour.isNotNullNorEmpty ? (chart.colour!.length > 2 ? chart.colour!.substring(0, 2) : chart.colour) : '-',
                  isAutoSizeText: true, style: shapeTextStyle),
              _buildDivider(style),
              SmartText(
                chart.isDisplayClarityAndCut ? chart.displayClarityAndCut : '-',
                isAutoSizeText: true,
                style: shapeTextStyle,
              ),
              _buildDivider(style),
              SmartText(chart.polish?.getFirstTwoOrNull ?? '-', isAutoSizeText: true, style: shapeTextStyle),
              _buildDivider(style),
              SmartText(chart.symmetry?.getFirstTwoOrNull ?? '-', isAutoSizeText: true, style: shapeTextStyle),
              _buildDivider(style),
              SmartText(chart.lab?.getFirstTwoOrNull ?? '-', isAutoSizeText: true, style: shapeTextStyle),
            ],
          ),
          SizedBox(height: 16.h),
        ],
        const Divider(),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildSlotSecondWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle) {
    return SmartGridView(runSpacing: 8.h, items: [
      if (!isDiamond) ...[
        _buildRowDetailItem(APPStrings.commodity.tr, chart.commodity, style, productInfoItemStyle),
        _buildRowDetailItem(APPStrings.shape.tr, chart.shape, style, productInfoItemStyle),
        _buildRowDetailItem(APPStrings.lab.tr, chart.lab, style, productInfoItemStyle),
        _buildRowDetailItem(APPStrings.color.tr, chart.colour, style, productInfoItemStyle),
        _buildRowDetailItem(APPStrings.origin.tr, chart.origin, style, productInfoItemStyle),
      ],
      if (isDiamond) ...[
        _buildRowDetailItem(APPStrings.rapRate.tr, chart.rapRate, style, productInfoItemStyle),
        _buildRowDetailItem(APPStrings.rate.tr, chart.perCts, style, productInfoItemStyle),
        _buildRowDetailItem(APPStrings.amt.tr, chart.amount, style, productInfoItemStyle),
        _buildRowDetailItem(APPStrings.discountPercentage.tr, chart.discount, style, productInfoItemStyle, isDiscount: true),
      ],
      if (!isDiamond) ...[
        _buildRowDetailItem(APPStrings.carat.tr, chart.carat, style, productInfoItemStyle),
      ]
    ]);
  }

  Widget _buildSlotThirdWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle,
      ValueNotifier<bool> showMoreDetails) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: ValueListenableBuilder<bool>(
        valueListenable: showMoreDetails,
        builder: (context, value, child) {
          return Column(
            children: [
              if (showMoreDetails.value) ...[
                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),
                if (isDiamond)
                  SmartGridView(columns: 3, runSpacing: 8.h, items: [
                    _buildDetailColumn(APPStrings.lotNo.tr, chart.lotNumber, style, productInfoItemStyle),
                    _buildDetailColumn(APPStrings.shape.tr, chart.shape, style, productInfoItemStyle),
                    if (isDiamond) ...[
                      _buildDetailColumn(APPStrings.fluorescence.tr, chart.fluorescence, style, productInfoItemStyle),
                      _buildDetailColumn(APPStrings.lab.tr, chart.lab, style, productInfoItemStyle),
                    ],
                    _buildDetailColumn(APPStrings.stock.tr, chart.stock, style, productInfoItemStyle),
                    // _buildDetailColumn(APPStrings.commodity.tr, chart.commodity, style, productInfoItemStyle),
                    // _buildDetailColumn(APPStrings.carat.tr, chart.carat, style, productInfoItemStyle),
                    // _buildDetailColumn(APPStrings.color.tr, chart.colour, style, productInfoItemStyle),
                    // _buildDetailColumn(APPStrings.origin.tr, chart.origin, style, productInfoItemStyle),
                  ]),
              ],
              if (isDiamond)
                InkWell(
                  onTap: () {
                    showMoreDetails.value = !showMoreDetails.value;
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
                    alignment: AlignmentDirectional.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmartText(
                          showMoreDetails.value ? APPStrings.lessDetails.tr : APPStrings.moreDetails.tr,
                          isAutoSizeText: true,
                          style: productInfoItemStyle.moreDetailsTextStyle,
                        ),
                        SizedBox(width: 4.w),
                        SmartImage(
                          path: showMoreDetails.value ? AppImages.icArrowUp : AppImages.icArrowDown,
                          height: 16.h,
                          width: 16.w,
                        ),
                      ],
                    ),
                  ),
                ),
              // if (isDiamond) SizedBox(height: 16.h),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSlotFourthWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle) {
    return Column(
      children: [
        if (!isDiamond) ...[
          const Divider(),
          SizedBox(height: 16.h),
          SmartGridView(runSpacing: 8.h, items: [
            _buildRowDetailItem(APPStrings.rate.tr, chart.perCts, style, productInfoItemStyle),
            _buildRowDetailItem(APPStrings.amt.tr, chart.amount, style, productInfoItemStyle),
            _buildRowDetailItem(APPStrings.discountPercentage.tr, chart.discount, style, productInfoItemStyle, isDiscount: true),
          ]),
          SizedBox(height: 16.h),
        ],
        const Divider(),
        SizedBox(height: 16.h),
        _buildActionGrid(style, chart),
      ],
    );
  }

  Widget _buildSlotFiveWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildDetailColumn(APPStrings.yourPercentage.tr, chart.your, style, productInfoItemStyle, isTextFormField: true)),
        Expanded(child: _buildDetailColumn(APPStrings.yourRate.tr, chart.yourRate, style, productInfoItemStyle)),
        Expanded(child: _buildDetailColumn(APPStrings.yourValue.tr, chart.yourValue, style, productInfoItemStyle)),
      ],
    );
  }

  Widget _buildDivider(MyBagDiamondItemStyle style) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 18.12.w),
      child: Container(
        height: 20.h,
        width: 1,
        color: style.borderColor,
      ),
    );
  }

  Widget _buildDetailColumn(String title, String? value, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle,
      {bool isTextFormField = false, bool isDiscount = false}) {
    return Container(
      padding: EdgeInsetsDirectional.only(end: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: productInfoItemStyle.labelTextStyle,
            isAutoSizeText: true,
          ),
          SizedBox(height: 4.h),
          isTextFormField
              ? SizedBox(
                  width: 56.w,
                  child: SmartTextField(
                    height: 32.h,
                    contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                    controller: yourDiscountController,
                    disabledBorderColor: style.borderColor,
                    style: style.subTitleStyle,
                    cursorHeight: 20.h,
                    textInputFormatter: [DoubleInputFormatter()],
                    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                    textInputAction: TextInputAction.done,
                    onTapOutside: (p0) {
                      onYourDiscountChange?.call(yourDiscountController.text);
                    },
                    onEditingComplete: () {
                      onYourDiscountChange?.call(yourDiscountController.text);
                    },
                  ),
                )
              : SmartText(
                  value.isNullOrEmpty ? APPStrings.dash.tr : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isDiscount ? style.richTextStyle : productInfoItemStyle.valueTextStyle,
                  isAutoSizeText: true,
                ),
        ],
      ),
    );
  }

  Widget _buildRowDetailItem(String title, String? value, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle,
      {bool isDiscount = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SmartText(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: productInfoItemStyle.labelTextStyle,
          isAutoSizeText: true,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: SmartText(
            value.isNullOrEmpty ? APPStrings.dash.tr : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: isDiscount ? style.richTextStyle : productInfoItemStyle.valueTextStyle,
            isAutoSizeText: true,
          ),
        ),
      ],
    );
  }

  Widget _buildActionGrid(MyBagDiamondItemStyle style, ProductInfoClarityChat chart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionItem(imagePath: AppImages.icRotate3D, onTap: onTap360View, style: style),
        _buildActionItem(imagePath: AppImages.icProductCertificate, onTap: onTapCertificate, style: style),
        if (chart.stock.isNotNullNorEmpty)
          _buildActionItem(
              imagePath: '', onTap: onTapUSA, style: style, isFlag: chart.stock.isNotNullNorEmpty, countryCode: chart.stock ?? ''),
        _buildActionItem(imagePath: AppImages.icImageThin, onTap: onTapImageViewer, style: style),
        _buildActionItem(imagePath: AppImages.icDNA, onTap: onTapDNA, style: style),
      ],
    );
  }

  Widget _buildActionItem(
      {required String imagePath,
      VoidCallback? onTap,
      required MyBagDiamondItemStyle style,
      bool isFlag = false,
      String countryCode = ''}) {
    return Flexible(
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          height: 48.w,
          width: 48.w,
          padding: EdgeInsetsDirectional.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: style.borderColor,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
          alignment: AlignmentDirectional.center,
          child: isFlag
              ? SmartText(
                  Utils.countryCodeToEmoji(countryCode),
                  style: TextStyle(fontSize: 24.sp),
                )
              : SmartImage(
                  path: imagePath,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }

  Widget buildHorizontalListview(List<String> texts, TextStyle style, Widget divider) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: texts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmartText(texts[index], isAutoSizeText: true, style: style),
            divider,
          ],
        );
      },
    );
  }

  Widget buildRow(List<String> texts, TextStyle style, Widget divider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: texts.expand((text) {
        return [
          SmartText(text, isAutoSizeText: true, style: style),
          divider,
        ];
      }).toList()
        ..removeLast(), // Remove the last divider
    );
  }
}
