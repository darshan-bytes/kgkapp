import 'package:kgk/kgk.dart';

class SmartGridView extends StatelessWidget {
  final List<Widget> items;
  final int columns;
  final double? spacing;
  final double? runSpacing;
  final double? height;
  final bool isLoadingMore;

  const SmartGridView({
    super.key,
    required this.items,
    this.columns = 2,
    this.spacing,
    this.runSpacing,
    this.height,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double itemWidth = (totalWidth - (columns - 1) * (spacing ?? 12.w)) / columns;
        return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                spacing: spacing ?? 12.w,
                runSpacing: runSpacing ?? 12.h,
                children: items.map((item) {
                  return SizedBox(
                    height: height,
                    width: itemWidth,
                    child: item,
                  );
                }).toList(),
              ),
            ),
            if (isLoadingMore) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
