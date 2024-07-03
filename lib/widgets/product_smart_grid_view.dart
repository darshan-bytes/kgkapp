import 'package:kgk/kgk.dart';

class ProductSmartGridView extends StatelessWidget {
  final List<Widget> items;
  final int itemsCount;

  final int columns;
  final double? spacing;
  final double? runSpacing;
  final double? height;

  const ProductSmartGridView({
    super.key,
    required this.items,
    required this.itemsCount,
    this.columns = 2,
    this.spacing,
    this.runSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double itemWidth = (totalWidth - (columns - 1) * (spacing ?? 12.w)) / columns;
        return Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            spacing: (spacing ?? 12.w),
            runSpacing: (runSpacing ?? 12.h),
            children: items.map((item) {
              return SizedBox(
                height: height,
                width: itemWidth,
                child: item,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
