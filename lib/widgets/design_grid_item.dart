import 'package:kgk/kgk.dart';

enum _GridViewType { designGridItem, cadLibrary }

class DesignListingGridItem extends StatelessWidget {
  final B2BCustomListingDataModel designModel;
  final double? boxHeight;
  final double? boxWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final BoxFit fit;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final _GridViewType _viewType;

  const DesignListingGridItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    required this.designModel,
    this.fit = BoxFit.cover,
    this.padding = EdgeInsetsDirectional.zero,
    this.margin = EdgeInsetsDirectional.zero,
  }) : _viewType = _GridViewType.designGridItem;

  const DesignListingGridItem.designGridItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    required this.designModel,
    this.fit = BoxFit.cover,
    this.padding = EdgeInsetsDirectional.zero,
    this.margin = EdgeInsetsDirectional.zero,
  }) : _viewType = _GridViewType.designGridItem;

  const DesignListingGridItem.cadLibrary({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    required this.designModel,
    this.fit = BoxFit.cover,
    this.padding = EdgeInsetsDirectional.zero,
    this.margin = EdgeInsetsDirectional.zero,
  }) : _viewType = _GridViewType.cadLibrary;

  @override
  Widget build(BuildContext context) {
    final ProductItemStyle style = AppTheme.of(context).productItemStyle;
    final DesignListingGridItemStyle designListingGridItemStyle = AppTheme.of(context).designListingGridItemStyle;
    final double productItemWidth = (context.width - 46.w) / 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        width: productItemWidth,
        decoration: BoxDecoration(color: style.backgroundColor, border: Border.all(color: style.borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            productImageSection(productItemWidth, style),
            productDetailsSection(productItemWidth, style, designListingGridItemStyle),
          ],
        ),
      ),
    );
  }

  String _getImageUrl() {
    switch (_viewType) {
      case _GridViewType.designGridItem:
        return designModel.strDesignListingImageUrl ?? '';
      case _GridViewType.cadLibrary:
        return designModel.strCADLibraryImageUrl ?? '';
    }
  }

  Widget productImageSection(double width, ProductItemStyle style) {
    ProjectStatus? status = ProjectStatus.values.firstWhereOrNull((element) => element == designModel.designApprovalStatus);
    return Stack(
      children: [
        Container(
          height: boxHeight ?? 172.h,
          width: width,
          alignment: AlignmentDirectional.center,
          color: style.productBackgroundColor,
          child: SmartImage(path: _getImageUrl(), height: imageHeight, width: imageWidth, fit: fit),
        ),
        if (designModel.tagImagePath.isNotNullNorEmpty)
          PositionedDirectional(start: -4.w, child: SmartImage(path: designModel.tagImagePath ?? '', fit: BoxFit.fill)),
        if (_viewType == _GridViewType.designGridItem && status != null)
          PositionedDirectional(
            bottom: 8.w,
            end: 14.w,
            child: SmartStatusBadge(
              borderRadius: 4.0.r,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
              currentStatus: status,
            ),
          ),
      ],
    );
  }

  Widget productDetailsSection(double width, ProductItemStyle style, DesignListingGridItemStyle designListingGridItemStyle) {
    return Flexible(
      child: Container(
        width: width,
        color: style.backgroundColor,
        padding: EdgeInsetsDirectional.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildDetails(style, designListingGridItemStyle),
        ),
      ),
    );
  }

  List<Widget> _buildDetails(ProductItemStyle style, DesignListingGridItemStyle designListingGridItemStyle) {
    switch (_viewType) {
      case _GridViewType.designGridItem:
        return _buildDesignGridItemDetails(style, designListingGridItemStyle);
      case _GridViewType.cadLibrary:
        return _buildCADLibraryDetails(designListingGridItemStyle, style);
    }
  }

  List<Widget> _buildDesignGridItemDetails(ProductItemStyle style, DesignListingGridItemStyle designListingGridItemStyle) {
    return [
      if (designModel.strDesignNumber.isNotNullNorEmpty) ...[
        SmartText(designModel.strDesignNumber, style: style.productNameStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
        SizedBox(height: 8.h),
      ],
      if (designModel.strDbfNumber.isNotNullNorEmpty) ...[
        SmartText(
          designModel.strDbfNumber,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: designListingGridItemStyle.dbfNumberTextStyle,
          isAutoSizeText: true,
        ),
        SizedBox(height: 8.h),
      ],
      if (designModel.strSalesman.isNotNullNorEmpty)
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
                style: designListingGridItemStyle.salesManTextStyle,
                isAutoSizeText: true,
              ),
            ),
          ],
        ),

      diamondAndGramSection(style),
    ];
  }

  List<Widget> _buildCADLibraryDetails(DesignListingGridItemStyle style, ProductItemStyle productStyle) {
    return [
      if (designModel.strCADLibraryNumber.isNotNullNorEmpty) ...[
        SmartText(designModel.strCADLibraryNumber, style: style.dbfNumberTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
        SizedBox(height: 8.h),
      ],
      if (designModel.strCADLibraryProductName.isNotNullNorEmpty)
        SmartText(designModel.strCADLibraryProductName, maxLines: 2, overflow: TextOverflow.ellipsis, style: style.salesManTextStyle),
      diamondAndGramSection(productStyle),
    ];
  }

  Widget diamondAndGramSection(ProductItemStyle style) {
    if (designModel.strCarats.isNullOrEmpty && designModel.strGrams.isNullOrEmpty) {
      return SizedBox(height: 24.h);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
        if (designModel.strCarats.isNotNullNorEmpty) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SmartImage(path: AppImages.icBlankDiamond, height: 16.w, width: 16.w),
              SizedBox(width: 4.w),
              SmartText(designModel.strCarats, style: style.diamondTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
          SizedBox(height: 8.h),
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
    );
  }
}
