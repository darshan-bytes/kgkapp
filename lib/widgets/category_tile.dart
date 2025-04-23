import 'package:kgk/kgk.dart';

class CategoryTile extends StatelessWidget {
  final CategoriesModel category;
  final bool isSelected;

  const CategoryTile({super.key, required this.category, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final CategoryTileStyle categoryTileStyle = AppTheme.of(context).categoryTileStyle;
    return Container(
      margin: EdgeInsetsDirectional.only(top: 6.0.h, bottom: 6.0.h, end: 6.0.w, start: 6.0.w),
      decoration: BoxDecoration(color: categoryTileStyle.whiteColor),
      child: Stack(
        children: [
          SmartImage(
            path: category.image ?? 'https://i.ibb.co/HgjT1rt/Image.png',
            height: 134.w,
            width: context.width,
            fit: BoxFit.fill,
            border: isSelected ? Border.all(color: categoryTileStyle.primaryColor, width: 2.w) : null,
          ),
          Container(
            margin: EdgeInsetsDirectional.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: SmartText(
                    Utils.getCategoryDisplayName(category.name ?? ''),
                    style: categoryTileStyle.labelStyle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 4.w),
                if (category.isExpanded) Icon(isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
