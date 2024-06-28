import 'package:kgk/kgk.dart';

class SmartGridView extends StatelessWidget {
  final List<Widget> items;
  final int columns;
  final double spacing;
  final double runSpacing;
  final double? height;
  final bool isLoadingMore;

  const SmartGridView({
    super.key,
    required this.items,
    this.columns = 2,
    this.spacing = 12.0,
    this.runSpacing = 12.0,
    this.height,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double itemWidth = (totalWidth - (columns - 1) * spacing) / columns;
        return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                spacing: spacing,
                runSpacing: runSpacing,
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
