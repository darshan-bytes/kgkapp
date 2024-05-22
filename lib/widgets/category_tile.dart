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
      margin: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 6.0, left: 6.0),
      color: Colors.white,
      child: Stack(
        children: [
          SmartImage(
            path: category.image ?? 'https://i.ibb.co/HgjT1rt/Image.png',
            height: Responsive.isTablet(context) ? 200 : 134,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(
                  category.name ?? '',
                  style: categoryTileStyle.labelStyle,
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
