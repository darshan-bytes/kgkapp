import 'package:kgk/kgk.dart';

class SmartMonthYearPicker extends StatelessWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateChanged;
  final double? buttonHeight;
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final int minYear;
  final int maxYear;

  SmartMonthYearPicker({
    super.key,
    required this.onDateChanged,
    this.initialDate,
    this.buttonHeight,
    this.hintText,
    this.labelText,
    this.focusNode,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.minYear = 1900,
    this.maxYear = 2100,
  }) {
    selectedDate.value = initialDate;
  }

  final ValueNotifier<DateTime?> selectedDate = ValueNotifier<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    final TextFieldStyle textFieldStyle = AppTheme.of(context).textFieldStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelText != null) ...[SmartText(labelText!, style: textFieldStyle.labelStyle), SizedBox(height: 8.h)],
        InkWell(
          focusNode: focusNode,
          onTap: () {
            Utils.showSmartModalBottomSheet(
              context: context,
              isScrollControlled: false,
              builder: (context) {
                return CustomMonthYearPicker(
                  initialDate: selectedDate.value ?? DateTime.now(),
                  onDateChanged: (date) {
                    selectedDate.value = date;
                    onDateChanged(date);
                  },
                  maxYear: maxYear,
                  minYear: minYear,
                );
              },
            );
          },
          child: Container(
            height: buttonHeight ?? 48.w,
            padding: contentPadding ?? EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius ?? BorderRadius.circular(4.r),
              border: border ?? Border.all(color: textFieldStyle.enabledTextFieldBorderColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: selectedDate,
                    builder: (context, value, child) {
                      return SmartText(
                        selectedDate.value != null
                            ? "${selectedDate.value!.month}/${selectedDate.value!.year}"
                            : hintText ?? APPStrings.select.tr,
                        style: selectedDate.value != null ? textFieldStyle.textStyle : textFieldStyle.hintStyle,
                      );
                    },
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

class CustomMonthYearPicker extends StatelessWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;
  final int minYear;
  final int maxYear;
  final ValueNotifier<int> selectedMonth = ValueNotifier<int>(0);
  final ValueNotifier<int> selectedYear = ValueNotifier<int>(0);

  CustomMonthYearPicker({super.key, required this.initialDate, required this.onDateChanged, this.minYear = 1900, this.maxYear = 2100}) {
    selectedMonth.value = initialDate.month;
    selectedYear.value = initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    final DurationPickerStyle style = AppTheme.of(context).durationPickerStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 20.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(6.r), topEnd: Radius.circular(6.r)),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmartText(APPStrings.month.tr, style: style.titleStyle),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SmartText(APPStrings.month.tr, style: style.subTitleStyle),
                            SizedBox(
                              height: 250.h,
                              child: ValueListenableBuilder(
                                valueListenable: selectedMonth,
                                builder: (context, value, child) {
                                  return CupertinoPicker(
                                    scrollController: FixedExtentScrollController(initialItem: selectedMonth.value - 1),
                                    itemExtent: 32.h,
                                    looping: true,
                                    onSelectedItemChanged: (int value) {
                                      selectedMonth.value = value + 1;
                                    },
                                    children: List<Widget>.generate(12, (int index) {
                                      return Center(
                                        child: SmartText(
                                          DateTime(selectedYear.value, index + 1, 1).monthNameFull,
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SmartText(APPStrings.year.tr, style: style.subTitleStyle),
                            SizedBox(
                              height: 250.h,
                              child: ValueListenableBuilder(
                                valueListenable: selectedYear,
                                builder: (context, value, child) {
                                  return CupertinoPicker(
                                    scrollController: FixedExtentScrollController(initialItem: selectedYear.value - minYear),
                                    itemExtent: 32.h,
                                    looping: false,
                                    onSelectedItemChanged: (int value) {
                                      selectedYear.value = minYear + value;
                                    },
                                    children: List<Widget>.generate(maxYear - minYear, (int index) {
                                      return Center(child: SmartText("${minYear + index}", style: TextStyle(fontSize: 20.sp)));
                                    }),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SmartButton(
                    onTap: () {
                      onDateChanged(DateTime(selectedYear.value, selectedMonth.value, 1));
                      context.pop();
                    },
                    title: APPStrings.ok.tr,
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: SmartImage(
                  path: AppImages.icCross,
                  width: 24.w,
                  height: 24.w,
                  onTap: () {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
