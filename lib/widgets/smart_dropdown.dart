import 'package:kgk/kgk.dart';

class SmartDropDown<T> extends StatelessWidget {
  final Function(T?) onChanged;
  final List<SmartDropDownItem<T>> items;
  final T? selectedItem;
  final double? selectionWindowHeight;
  final double? buttonHeight;
  final String? hintText;
  final String? labelText;
  final Axis scrollDirection;
  final FocusNode? focusNode;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;

  const SmartDropDown({
    super.key,
    required this.onChanged,
    required this.items,
    this.selectedItem,
    this.selectionWindowHeight,
    this.buttonHeight,
    this.hintText,
    this.labelText,
    this.scrollDirection = Axis.vertical,
    this.focusNode,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final TextFieldStyle textFieldStyle = AppTheme.of(context).textFieldStyle;
    String? title = items.firstWhereOrNull((element) => element.value == selectedItem)?.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelText != null) ...[
          SmartText(
            labelText!,
            style: textFieldStyle.labelStyle,
          ),
          SizedBox(height: 8.h),
        ],
        InkWell(
          focusNode: focusNode,
          onTap: () {
            Utils.showSmartModalBottomSheet(
                context: context,
                isScrollControlled: scrollDirection == Axis.horizontal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.r)),
                ),
                builder: (context) {
                  return SmartDropDownView(
                    scrollDirection: scrollDirection,
                    hintText: hintText,
                    onTap: onChanged,
                    items: items,
                    selectedItem: selectedItem,
                    height: selectionWindowHeight,
                  );
                });
          },
          child: Container(
            height: buttonHeight ?? 48.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(4.r),
              border: border ??
                  Border.all(
                    color: textFieldStyle.enabledTextFieldBorderColor,
                  ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SmartText(
                    title ?? hintText ?? APPStrings.select.tr,
                    style: title.isNotNullNorEmpty ? textFieldStyle.textStyle : textFieldStyle.hintStyle,
                  ),
                ),
                const SmartImage(path: AppImages.icArrowDropDown),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SmartDropDownView<T> extends StatelessWidget {
  final Function(T?) onTap;
  final List<SmartDropDownItem<T>> items;
  final T? selectedItem;
  final double? height;
  final String? hintText;
  final Axis scrollDirection;

  SmartDropDownView({
    super.key,
    required this.onTap,
    required this.items,
    this.selectedItem,
    this.height,
    this.hintText,
    this.scrollDirection = Axis.vertical,
  });

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SmartDropDownStyle style = AppTheme.of(context).smartDropDownStyle;
    Widget child = Container(
      height: height,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.r),
          topRight: Radius.circular(6.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (hintText.isNotNullNorEmpty) ...[
              SmartText(hintText!, style: style.labelStyle),
              SizedBox(height: 16.h),
            ],
            Flexible(child: _buildItemList(items, style, context)),
          ],
        ),
      ),
    );

    return child;
  }

  Widget _buildItemList(List<SmartDropDownItem<T>> filteredList, SmartDropDownStyle style, BuildContext context) {
    Widget child = ListView.separated(
      controller: _scrollController,
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final bool isSelected = selectedItem != null && item.value == selectedItem;
        Widget child = GestureDetector(
          onTap: () {
            if (item.enabled) {
              onTap(item.value);
              Navigator.of(context).pop();
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? style.selectedBorderColor : style.backgroundColor,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: isSelected ? style.selectedBorderColor : style.unSelectedBorderColor,
              ),
            ),
            padding: EdgeInsets.all(12.w),
            child: SmartText(item.title, style: isSelected ? style.selectedTitleTextStyle : style.titleTextStyle),
          ),
        );

        if (scrollDirection == Axis.horizontal) {
          child = ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 50.w,
              maxHeight: 50.h,
            ),
            child: child,
          );
        }

        return child;
      },
      separatorBuilder: (context, index) => SizedBox(
        height: scrollDirection == Axis.vertical ? 8.h : 0,
        width: scrollDirection == Axis.horizontal ? 8.w : 0,
      ),
    );

    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      scrollbarOrientation: scrollDirection == Axis.horizontal ? ScrollbarOrientation.bottom : ScrollbarOrientation.right,
      child: scrollDirection == Axis.horizontal
          ? Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: SizedBox(
                height: 50.w,
                child: child,
              ),
            )
          : child,
    );
  }
}

class SmartDropDownItem<T> {
  final String title;
  final T? value;
  final bool enabled;

  const SmartDropDownItem({
    required this.title,
    this.value,
    this.enabled = true,
  });
}
