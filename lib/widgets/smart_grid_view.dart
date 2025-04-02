import 'package:flutter/material.dart';

class SmartGridView extends StatelessWidget {
  final List<Widget> items;
  final int columns;
  final double? spacing;
  final double? runSpacing;
  final double? height;
  final bool isLoadingMore;
  final List<({int index, Widget child})>? additionalWidgets;
  final bool isLastFullWidthRequired;

  const SmartGridView({
    super.key,
    required this.items,
    this.columns = 2,
    this.spacing,
    this.runSpacing,
    this.height,
    this.isLoadingMore = false,
    this.additionalWidgets,
    this.isLastFullWidthRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    if (additionalWidgets == null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double totalWidth = constraints.maxWidth;
          double itemWidth = (totalWidth - (columns - 1) * (spacing ?? 12)) / columns;

          return Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  spacing: spacing ?? 12,
                  runSpacing: runSpacing ?? 12,
                  children: items.map((widget) {
                    int index = items.indexOf(widget);
                    return SizedBox(
                      height: height,
                      width: isLastFullWidthRequired && index == items.length - 1
                          ? totalWidth
                          : itemWidth,
                      child: widget,
                    );
                  }).toList(),
                ),
              ),
              if (isLoadingMore) const CircularProgressIndicator(),
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
              int prevIndex = index == 0 ? 0 : additionalWidgets![index - 1].index;
              int currIndex = additionalWidgets![index].index;

              if (prevIndex.isOdd) prevIndex++;
              if (currIndex.isOdd && items.length > currIndex) currIndex++;

              return Column(
                children: [
                  SmartGridView(
                    items: items.skip(prevIndex).take(currIndex - prevIndex).toList(),
                    height: height,
                    columns: columns,
                    runSpacing: runSpacing,
                    spacing: spacing,
                  ),
                  additionalWidgets![index].child,
                  if (index == additionalWidgets!.length - 1)
                    SmartGridView(
                      items: items.skip(currIndex).toList(),
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
