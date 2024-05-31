import 'package:kgk/kgk.dart';

class SmartDropDown<T> extends StatelessWidget {
  final Function(T?) onChanged;
  final List<SmartDropDownItem<T>> items;
  final T? selectedItem;
  final double? selectionWindowHeight;
  final double? buttonHeight;
  final String? hintText;
  final String? labelText;

  const SmartDropDown({
    super.key,
    required this.onChanged,
    required this.items,
    this.selectedItem,
    this.selectionWindowHeight,
    this.buttonHeight,
    this.hintText,
    this.labelText,
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
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SmartDropDownView(
                    hintText: hintText,
                    onTap: onChanged,
                    items: items,
                    selectedItem: selectedItem,
                    height: selectionWindowHeight,
                  );
                });
          },
          child: Container(
            height: buttonHeight ?? 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
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

  const SmartDropDownView({
    super.key,
    required this.onTap,
    required this.items,
    this.selectedItem,
    this.height,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    SmartDropDownStyle style = AppTheme.of(context).smartDropDownStyle;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hintText.isNotNullNorEmpty) ...[
            SmartText(
              hintText!,
              style: style.labelStyle,
            ),
            SizedBox(height: 16.h),
          ],
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: _buildItemList(items, style, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList(List<SmartDropDownItem<T>> filteredList, SmartDropDownStyle style, BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final bool isSelected = selectedItem != null && item.value == selectedItem;
        return GestureDetector(
          onTap: () {
            if (item.enabled) {
              onTap(item.value);
              Navigator.of(context).pop();
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: style.backgroundColor,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: isSelected ? style.selectedBorderColor : style.unSelectedBorderColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SmartText(item.title, style: style.titleTextStyle),
                  ),
                  isSelected
                      ? const SmartImage(
                          path: AppImages.icCheck,
                          fit: BoxFit.contain,
                        )
                      : SizedBox(height: 24.h)
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
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
