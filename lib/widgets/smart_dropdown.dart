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
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool isIcArrowDropDown;
  final bool isExpanded;
  final bool isChangeableValue;
  final Function(String)? onSearchEvent;
  final bool canSearch;
  final String? errorText;
  final String? emptyText;

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
    this.contentPadding,
    this.textStyle,
    this.backgroundColor,
    this.isIcArrowDropDown = true,
    this.isExpanded = true,
    this.isChangeableValue = true,
    this.onSearchEvent,
    this.canSearch = false,
    this.errorText,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    final TextFieldStyle style = AppTheme.of(context).textFieldStyle;
    String? title = items.firstWhereOrNull((element) => element.value == selectedItem)?.title;
    return Column(
      crossAxisAlignment: isExpanded ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          SmartText(
            labelText!,
            style: style.labelStyle,
          ),
          SizedBox(height: 8.h),
        ],
        InkWell(
          focusNode: focusNode,
          onTap: () {
            if (!isChangeableValue) {
              return;
            }
            SmartDropDownView view = SmartDropDownView(
              scrollDirection: scrollDirection,
              hintText: hintText,
              onTap: (value) {
                onChanged(value);
              },
              items: items,
              selectedItem: selectedItem,
              height: selectionWindowHeight,
              onSearchEvent: onSearchEvent,
              canSearch: canSearch,
              noDataFoundText: emptyText ?? APPStrings.noDataFound.tr,
            );
            Utils.showSmartModalBottomSheet(
              context: context,
              // isScrollControlled: scrollDirection == Axis.horizontal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.r)),
              ),

              builder: (context) {
                return view;
              },
            );
          },
          child: Container(
            height: !isExpanded ? null : buttonHeight ?? 48.w,
            padding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius ?? BorderRadius.circular(4.r),
              border: border ??
                  Border.all(
                    color: style.enabledTextFieldBorderColor,
                  ),
            ),
            child: _getTitleView(textFieldStyle: style, isIcArrowDropDown: isIcArrowDropDown, title: title, hintText: hintText),
          ),
        ),
        AnimatedSize(
            duration: Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: errorText.isNotNullNorEmpty
                  ? [
                      SizedBox(height: 8.h),
                      SmartText(errorText!, style: style.errorStyle),
                    ]
                  : [],
            )),
      ],
    );
  }

  Widget _getTitleView({String? title, String? hintText, required TextFieldStyle textFieldStyle, required bool isIcArrowDropDown}) {
    if (isExpanded) {
      return Row(
        children: [
          Expanded(
            child: SmartText(
              isAutoSizeText: true,
              title ?? hintText ?? APPStrings.select.tr,
              style: title.isNotNullNorEmpty ? textFieldStyle.textStyle.merge(textStyle) : textFieldStyle.hintStyle,
            ),
          ),
          if (isIcArrowDropDown) const SmartImage(path: AppImages.icArrowDropDown),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SmartText(
            title ?? hintText ?? APPStrings.select.tr,
            style: title.isNotNullNorEmpty ? textFieldStyle.textStyle.merge(textStyle) : textFieldStyle.hintStyle,
          ),
          SizedBox(width: 2.w),
          if (isIcArrowDropDown) const SmartImage(path: AppImages.icArrowDropDown),
        ],
      );
    }
  }
}

class SmartDropDownView<T> extends StatelessWidget {
  final Function(T?) onTap;
  final List<SmartDropDownItem<T>> items;
  final T? selectedItem;
  final double? height;
  final String? hintText;
  final Axis scrollDirection;
  final Function(String)? onSearchEvent;
  final bool canSearch;
  final ValueNotifier<String> searchNotifier;
  final String noDataFoundText;

  SmartDropDownView({
    super.key,
    required this.onTap,
    required this.items,
    this.selectedItem,
    this.height,
    this.hintText,
    this.scrollDirection = Axis.vertical,
    this.onSearchEvent,
    this.canSearch = false, // Default is false, meaning no search
    this.noDataFoundText = '',
  }) : searchNotifier = ValueNotifier<String>('');

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    SmartDropDownStyle style = AppTheme.of(context).smartDropDownStyle;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        constraints:
            BoxConstraints(maxHeight: context.height * 0.75, minHeight: (context.height * 0.75) - MediaQuery.viewInsetsOf(context).bottom),
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
              // Conditionally display the search field
              if (canSearch) ...[
                SmartTextField.search(
                  height: 48.h,
                  hintText: '${APPStrings.search.tr} ${hintText ?? ''}',
                  onValueChanges: (value) {
                    searchNotifier.value = value;
                    if (onSearchEvent != null) onSearchEvent!(value);
                  },
                ),
                SizedBox(height: 8.h),
              ],
              ValueListenableBuilder<String>(
                valueListenable: searchNotifier,
                builder: (context, query, child) {
                  final filteredItems = items.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
                  return filteredItems.isNotEmpty
                      ? Flexible(child: _buildItemList(filteredItems, style, context))
                      : SizedBox(
                          height: 200.h,
                          child: NoDataFoundWidget(
                            text: noDataFoundText.isNotNullNorEmpty ? noDataFoundText : APPStrings.noDataFound.tr,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemList(List<SmartDropDownItem<T>> filteredList, SmartDropDownStyle style, BuildContext context) {
    Widget child = ListView.separated(
      controller: _scrollController,
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final item = filteredList[index];
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
          : Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: child,
            ),
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
