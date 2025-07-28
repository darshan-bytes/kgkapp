import 'package:kgk/kgk.dart';

enum _ListViewType { designListItem, cadListLibrary }

class CadLibraryListItem extends StatelessWidget {
  final B2BCustomListingDataModel designModel;
  final double? boxHeight;
  final double? boxWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final BoxFit fit;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final _ListViewType _viewType;
  final Function()? onAddToBagTap;

  const CadLibraryListItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    this.fit = BoxFit.cover,
    this.padding = EdgeInsetsDirectional.zero,
    this.margin = EdgeInsetsDirectional.zero,
    required this.designModel,
    this.onAddToBagTap,
  }) : _viewType = _ListViewType.cadListLibrary;

  const CadLibraryListItem.designListItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    this.fit = BoxFit.cover,
    this.padding = EdgeInsetsDirectional.zero,
    this.margin = EdgeInsetsDirectional.zero,
    required this.designModel,
    this.onAddToBagTap,
  }) : _viewType = _ListViewType.designListItem;

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).cadLibraryListingItemStyle;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0.8,
        color: style.backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: style.borderColor, strokeAlign: 0.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        shadowColor: style.primaryColor,
        child: Container(
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(color: style.backgroundColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [cadImageSection(style), SizedBox(width: 16.w), cadDetailsSection(style, context)],
          ),
        ),
      ),
    );
  }

  Widget cadImageSection(CadLibraryListingItemStyle style) {
    return Stack(
      children: [
        Container(
          height: boxHeight ?? 144.w,
          width: boxWidth ?? 144.w,
          alignment: AlignmentDirectional.center,
          color: style.cadBackgroundColor,
          child: SmartImage(
            path:
                _viewType == _ListViewType.cadListLibrary
                    ? designModel.strCADLibraryImageUrl ?? ''
                    : designModel.strDesignListingImageUrl ?? '',
            height: imageHeight,
            width: imageWidth,
            fit: fit,
          ),
        ),
      ],
    );
  }

  Widget cadDetailsSection(CadLibraryListingItemStyle style, BuildContext context) {
    final ProductItemStyle productStyle = AppTheme.of(context).productItemStyle;
    ProjectStatus? status = ProjectStatus.values.firstWhereOrNull((element) => element == designModel.designApprovalStatus);
    return Expanded(
      child: Container(
        color: style.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            SmartText(
              _viewType == _ListViewType.designListItem ? designModel.strDesignNumber : designModel.strCADLibraryNumber,
              style: style.cadNumberStyle,
            ),
            SizedBox(height: 10.h),
            SmartText(
              _viewType == _ListViewType.designListItem ? designModel.strDbfNumber : designModel.strCADLibraryProductName,
              style: style.cadNameStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (_viewType == _ListViewType.designListItem && designModel.strSalesman.isNotNullNorEmpty) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  if (designModel.strSalesmanImageUrl.isNotNullNorEmpty) ...[
                    SmartImage(
                      path: designModel.strSalesmanImageUrl ?? '',
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.contain,
                      imageBorderRadius: BorderRadius.circular((24.w / 2).r),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Flexible(
                    child: SmartText(
                      designModel.strSalesman,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: style.cadNameStyle,
                      isAutoSizeText: true,
                    ),
                  ),
                ],
              ),
              if (status != null) ...[
                SizedBox(height: 10.h),
                SmartStatusBadge(
                  borderRadius: 4.0.r,
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
                  currentStatus: status,
                ),
              ],
            ],
            diamondAndGramSection(productStyle),
            if (onAddToBagTap != null)
              SmartButton(
                height: 32.w,
                margin: EdgeInsetsDirectional.only(top: 8.h, end: 8.w),
                padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                onTap: () {
                  if (designModel.isAddedToCart) {
                    BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context));
                    context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
                  } else {
                    BlocProvider.of<AppBloc>(context).add(
                      ProductAddToBagEvent(
                        ProductDetailsModel(commodity: designModel.commodity, suid: designModel.id),
                        context,
                        onProductAdded: () {
                          designModel.isAddedToCart = true;
                        },
                      ),
                    );
                  }
                },
                title: designModel.isAddedToCart ? APPStrings.goToBag.tr : APPStrings.addToBag.tr,
                prefixImage: AppImages.icShoppingBag,
                imageSize: 16.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget diamondAndGramSection(ProductItemStyle style) {
    if (designModel.strCarats.isNullOrEmpty && designModel.strGrams.isNullOrEmpty) {
      return SizedBox(height: 24.h);
    }
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (designModel.strCarats.isNotNullNorEmpty) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartImage(path: AppImages.icBlankDiamond, height: 16.w, width: 16.w),
                SizedBox(width: 4.w),
                SmartText(designModel.strCarats, style: style.diamondTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
            SizedBox(width: 8.w),
          ],
          if (designModel.strGrams.isNotNullNorEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartImage(path: AppImages.icGram, height: 16.w, width: 16.w),
                SizedBox(width: 4.w),
                SmartText(designModel.strGrams, style: style.diamondTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
        ],
      ),
    );
  }
}
