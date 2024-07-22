import 'package:kgk/kgk.dart';

class SmartSuggestionProductList extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllTap;
  final List<ProductDetails> suggestedProductList;
  final VoidCallback onEyeTap;
  final VoidCallback onFavTap;
  final bool isPaddingNeeded;
  final ScrollController scrollController;

  const SmartSuggestionProductList({
    super.key,
    required this.title,
    required this.onViewAllTap,
    required this.suggestedProductList,
    required this.onEyeTap,
    required this.onFavTap,
    this.isPaddingNeeded = true,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    SmartSuggestionProductListStyle style = AppTheme.of(context).smartSuggestionProductListStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SmartText(
              title,
              style: style.titleStyle,
              optionalPadding: isPaddingNeeded ? EdgeInsets.only(left: 17.w) : EdgeInsets.zero,
            ),
            const Spacer(),
            if (onViewAllTap != null)
              SmartText(
                APPStrings.viewAll.tr,
                optionalPadding: isPaddingNeeded ? EdgeInsets.only(right: 17.w) : EdgeInsets.zero,
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
            padding: isPaddingNeeded ? EdgeInsets.only(left: 17.w, right: 17.w) : EdgeInsets.zero,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 12.w,
              runSpacing: 12.2,
              children: suggestedProductList.map((product) {
                return ProductGridItem(
                  margin: EdgeInsets.only(bottom: 17.h),
                  onEyeTap: onEyeTap,
                  onFavTap: onFavTap,
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
