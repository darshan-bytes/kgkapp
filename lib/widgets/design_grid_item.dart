import 'package:kgk/kgk.dart';

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

  const DesignListingGridItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    required this.designModel,
    this.fit = BoxFit.cover,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final ProductItemStyle style = AppTheme.of(context).productItemStyle;
    final double productItemWidth = (context.width - 46.w) / 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        width: productItemWidth,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          border: Border.all(color: style.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            productImageSection(productItemWidth, style),
            productDetailsSection(productItemWidth, style),
          ],
        ),
      ),
    );
  }

  Widget productImageSection(double width, ProductItemStyle style) {
    return Container(
      height: boxHeight ?? 172.h,
      width: width,
      alignment: Alignment.center,
      color: style.productBackgroundColor,
      child: SmartImage(
        path: designModel.strDesignListingImageUrl ?? '',
        height: imageHeight,
        width: imageWidth,
        fit: fit,
      ),
    );
  }

  Widget productDetailsSection(double width, ProductItemStyle style) {
    return Flexible(
      child: Container(
        width: width,
        color: style.backgroundColor,
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (designModel.strDesignNumber.isNotNullNorEmpty) ...[
              SmartText(
                designModel.strDesignNumber,
                style: style.productNameStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
            ],
            if (designModel.strDbfNumber.isNotNullNorEmpty) ...[
              SmartText(
                designModel.strDbfNumber,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.discountTextStyle,
              ),
              SizedBox(height: 8.h),
            ],
            if (designModel.strSalesman.isNotNullNorEmpty)
              SmartText(
                designModel.strSalesman,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.productNameStyle,
              ),
          ],
        ),
      ),
    );
  }
}
