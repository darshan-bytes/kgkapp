import 'package:kgk/kgk.dart';

class SmartGridView extends StatelessWidget {
  final List<Widget> items;
  final int columns;
  final double? spacing;
  final double? runSpacing;
  final double? height;
  final bool isLoadingMore;
  final List<({int index, Widget child})>? additionalWidgets;

  const SmartGridView({
    super.key,
    required this.items,
    this.columns = 2,
    this.spacing,
    this.runSpacing,
    this.height,
    this.isLoadingMore = false,
    this.additionalWidgets,
  });

  @override
  Widget build(BuildContext context) {
    if (additionalWidgets == null) {
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
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: additionalWidgets?.length ?? 0,
            itemBuilder: (context, index) {
              int previousAdditionalIndex = index == 0 ? 0 : additionalWidgets?[index - 1].index ?? 0;
              int additionalIndex = additionalWidgets?[index].index ?? 0;
              if (previousAdditionalIndex.isOdd) {
                previousAdditionalIndex += 1;
              }
              bool isLast = index == additionalWidgets!.length - 1;
              if (additionalIndex.isOdd && items.length > (additionalIndex)) {
                additionalIndex += 1;
              }
              List<Widget> subItems = items.sublist(previousAdditionalIndex, additionalIndex);
              return Column(
                children: [
                  SmartGridView(
                    items: subItems,
                    height: height,
                    columns: columns,
                    runSpacing: runSpacing,
                    spacing: spacing,
                  ),
                  additionalWidgets![index].child,
                  if (isLast)
                    SmartGridView(
                      items: items.sublist(additionalIndex, items.length),
                      isLoadingMore: isLoadingMore,
                      height: height,
                      columns: columns,
                      runSpacing: runSpacing,
                      spacing: spacing,
                    ),
                ],
              );
            },
          ),
        ],
      );
    }
  }
}
