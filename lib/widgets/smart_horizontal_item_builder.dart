import 'package:kgk/kgk.dart';

class SmartHorizontalItemBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets listPadding;
  final EdgeInsets padding;
  final double? itemBetweenSpace;
  final CrossAxisAlignment crossAxisAlignment;
  final CrossAxisAlignment mainAxisAlignment;
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsets titleOptionalPadding;
  final double spacingBetweenTitleAndItems;
  final Color? backgroundColor;
  final ScrollController? scrollController;
  final Widget? widgetBetweenTitleAndItems;

  const SmartHorizontalItemBuilder(
      {super.key,
      this.listPadding = EdgeInsets.zero,
      this.itemBetweenSpace,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = CrossAxisAlignment.start,
      required this.itemCount,
      required this.itemBuilder,
      this.title,
      this.titleStyle,
      this.spacingBetweenTitleAndItems = 0,
      this.padding = EdgeInsets.zero,
      this.backgroundColor,
      this.titleOptionalPadding = EdgeInsets.zero,
      this.scrollController,
      this.widgetBetweenTitleAndItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (title.isNotNullNorEmpty) ...[
              SmartText(title, style: titleStyle, optionalPadding: titleOptionalPadding),
              SizedBox(height: spacingBetweenTitleAndItems),
            ],
            widgetBetweenTitleAndItems ?? const SizedBox.shrink(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              child: Padding(
                padding: listPadding,
                child: Row(
                  crossAxisAlignment: mainAxisAlignment,
                  children: List.generate(
                    itemCount,
                    (index) {
                      return Padding(
                        padding: EdgeInsets.only(right: index == itemCount - 1 ? 0 : (itemBetweenSpace ?? 16.w)),
                        child: itemBuilder(context, index),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
