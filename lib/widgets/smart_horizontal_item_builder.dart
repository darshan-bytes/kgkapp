import 'package:kgk/kgk.dart';

class SmartHorizontalItemBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry listPadding;
  final EdgeInsetsGeometry padding;
  final double? itemBetweenSpace;
  final CrossAxisAlignment crossAxisAlignment;
  final CrossAxisAlignment mainAxisAlignment;
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry titleOptionalPadding;
  final double spacingBetweenTitleAndItems;
  final Color? backgroundColor;
  final ScrollController? scrollController;
  final Widget? widgetBetweenTitleAndItems;
  final bool isScrollbarVisible;

  const SmartHorizontalItemBuilder(
      {super.key,
      this.listPadding = EdgeInsetsDirectional.zero,
      this.itemBetweenSpace,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = CrossAxisAlignment.start,
      required this.itemCount,
      required this.itemBuilder,
      this.title,
      this.titleStyle,
      this.spacingBetweenTitleAndItems = 0,
      this.padding = EdgeInsetsDirectional.zero,
      this.backgroundColor,
      this.titleOptionalPadding = EdgeInsetsDirectional.zero,
      this.scrollController,
      this.widgetBetweenTitleAndItems,
      this.isScrollbarVisible = false});

  @override
  Widget build(BuildContext context) {
    Widget child = SingleChildScrollView(
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
                padding: EdgeInsetsDirectional.only(end: index == itemCount - 1 ? 0 : (itemBetweenSpace ?? 16.w)),
                child: itemBuilder(context, index),
              );
            },
          ),
        ),
      ),
    );
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
            // Commented out the Scrollbar widget because JD asked to remove it.
            /*isScrollbarVisible
                ? Scrollbar(
                    controller: scrollController,
                    trackVisibility: false,
                    thumbVisibility: isScrollbarVisible,
                    child: child,
                  )
                : */
            child
          ],
        ),
      ),
    );
  }
}
