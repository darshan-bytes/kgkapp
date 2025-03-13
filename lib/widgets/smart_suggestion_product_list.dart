import 'package:kgk/kgk.dart';

class SmartSuggestionProductList extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllTap;
  final List<ProductDetailsModel> suggestedProductList;
  final VoidCallback onEyeTap;
  final VoidCallback onFavTap;
  final bool isPaddingNeeded;
  final ScrollController scrollController;
  final Function(ProductDetailsModel)? onProductTap;
  final Function()? onAddToBagTap;
  final bool isCrtAndGramVisible;
  final bool isHomeView;
  final EdgeInsetsGeometry? margin;

  const SmartSuggestionProductList({
    super.key,
    required this.title,
    required this.onViewAllTap,
    required this.suggestedProductList,
    required this.onEyeTap,
    required this.onFavTap,
    this.isPaddingNeeded = true,
    required this.scrollController,
    this.onProductTap,
    this.isCrtAndGramVisible = false,
    this.isHomeView = false,
    this.onAddToBagTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    SmartSuggestionProductListStyle style = AppTheme.of(context).smartSuggestionProductListStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SmartText(
                title,
                style: style.titleStyle,
                optionalPadding: isPaddingNeeded ? EdgeInsetsDirectional.only(start: 17.w) : EdgeInsetsDirectional.zero,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 15.w),
            if (onViewAllTap != null)
              SmartText(
                APPStrings.viewAll.tr,
                optionalPadding: isPaddingNeeded ? EdgeInsetsDirectional.only(end: 17.w) : EdgeInsetsDirectional.zero,
                style: style.viewAllStyle,
                onTap: onViewAllTap,
              ),
          ],
        ),
        SizedBox(height: 16.h),
        SmartSingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: isPaddingNeeded ? EdgeInsetsDirectional.only(start: 17.w, end: 17.w) : EdgeInsetsDirectional.zero,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 12.w,
              runSpacing: 12.2,
              children: suggestedProductList.map((product) {
                return ProductGridItem(
                  onTap: onProductTap != null
                      ? () {
                          onProductTap?.call(product);
                        }
                      : null,
                  margin: margin ?? EdgeInsetsDirectional.only(bottom: 17.h),
                  onEyeTap: onEyeTap,
                  onFavTap: onFavTap,
                  productDetails: product,
                  isFavourite: product.isFavourite,
                  isCrtAndGramVisible: isCrtAndGramVisible,
                  onAddToBagTap: onAddToBagTap,
                  isHomeView: isHomeView,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
