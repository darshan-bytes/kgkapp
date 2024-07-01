import 'package:kgk/kgk.dart';

class CadLibraryListItem extends StatelessWidget {
  final B2BCustomListingDataModel b2bCustomListingDataModel;
  final double? boxHeight;
  final double? boxWidth;
  final double? imageHeight;
  final double? imageWidth;
  final Function()? onTap;
  final BoxFit fit;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const CadLibraryListItem({
    super.key,
    this.boxHeight,
    this.boxWidth,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    this.fit = BoxFit.cover,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    required this.b2bCustomListingDataModel,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).cadLibraryListingItemStyle;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: style.backgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cadImageSection(style),
            SizedBox(width: 16.w),
            cadDetailsSection(style, context),
          ],
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
          alignment: Alignment.center,
          color: style.cadBackgroundColor,
          child: SmartImage(
            path: b2bCustomListingDataModel.strCADLibraryImageUrl ?? '',
            height: imageHeight,
            width: imageWidth,
            fit: fit,
          ),
        ),
      ],
    );
  }

  Widget cadDetailsSection(CadLibraryListingItemStyle style, BuildContext context) {
    return Expanded(
      child: Container(
        color: style.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartText(
              b2bCustomListingDataModel.strCADLibraryNumber,
              style: style.cadNumberStyle,
            ),
            SizedBox(height: 8.h),
            SmartText(
              b2bCustomListingDataModel.strCADLibraryProductName,
              style: style.cadNameStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
