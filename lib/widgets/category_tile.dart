import 'package:kgk/kgk.dart';

class CategoryTile extends StatelessWidget {
  final CategoriesModel category;
  final bool isSelected;

  const CategoryTile({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final CategoryTileStyle categoryTileStyle = AppTheme.of(context).categoryTileStyle;
    return Container(
      margin: EdgeInsets.only(top: 6.0.h, bottom: 6.0.h, right: 6.0.w, left: 6.0.w),
      color: Colors.white,
      child: Stack(
        children: [
          SmartImage(
            path: category.image ?? 'https://i.ibb.co/HgjT1rt/Image.png',
            height: 134.w,
            width: context.width,
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(
                  category.name ?? '',
                  style: categoryTileStyle.labelStyle,
                ),
                SizedBox(
                  width: 4.w,
                ),
                if (category.isExpanded)
                  Icon(
                    isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 16.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
