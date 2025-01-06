import 'package:kgk/kgk.dart';

class SmartDurationPicker extends StatelessWidget {
  final Duration? initialDuration;
  final Function(Duration) onDurationChanged;
  final double? buttonHeight;
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final String? errorText;

  SmartDurationPicker({
    super.key,
    required this.onDurationChanged,
    this.initialDuration,
    this.buttonHeight,
    this.hintText,
    this.labelText,
    this.focusNode,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.errorText,
  }) {
    duration.value = initialDuration;
  }

  final ValueNotifier<Duration?> duration = ValueNotifier<Duration?>(null);

  @override
  Widget build(BuildContext context) {
    final TextFieldStyle style = AppTheme.of(context).textFieldStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Utils.showSmartModalBottomSheet(
                context: context,
                isScrollControlled: false,
                builder: (context) {
                  return CustomDurationPicker(
                      initialDuration: duration.value ?? Duration.zero,
                      onDurationChanged: (duration) {
                        this.duration.value = duration;
                        onDurationChanged(duration);
                      });
                });
          },
          child: Container(
            height: buttonHeight ?? 48.w,
            padding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius ?? BorderRadius.circular(4.r),
              border: border ??
                  Border.all(
                    color: style.enabledTextFieldBorderColor,
                  ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: duration,
                      builder: (context, value, child) {
                        return SmartText(
                          duration.value?.formattedDurationShort ?? hintText ?? APPStrings.select.tr,
                          style: duration.value != null ? style.textStyle : style.hintStyle,
                        );
                      }),
                ),
                const SmartImage(path: AppImages.icArrowDropDown),
              ],
            ),
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
}

class CustomDurationPicker extends StatelessWidget {
  final Duration initialDuration;
  final Function(Duration) onDurationChanged;
  final ValueNotifier<int> days = ValueNotifier<int>(0);
  final ValueNotifier<int> hours = ValueNotifier<int>(0);
  final ValueNotifier<int> minutes = ValueNotifier<int>(0);

  CustomDurationPicker({
    super.key,
    required this.initialDuration,
    required this.onDurationChanged,
  }) {
    days.value = initialDuration.inDays;
    hours.value = initialDuration.inHours % 24;
    minutes.value = initialDuration.inMinutes % 60;
  }

  @override
  Widget build(BuildContext context) {
    final DurationPickerStyle style = AppTheme.of(context).durationPickerStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r)),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmartText(APPStrings.selectDuration.tr, style: style.titleStyle),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SmartText(APPStrings.days.tr, style: style.subTitleStyle),
                            SizedBox(
                              height: 250.h,
                              child: ValueListenableBuilder(
                                  valueListenable: days,
                                  builder: (context, value, child) {
                                    return CupertinoPicker(
                                      scrollController: FixedExtentScrollController(initialItem: days.value),
                                      itemExtent: 32.h,
                                      looping: true,
                                      onSelectedItemChanged: (int value) {
                                        days.value = value;
                                      },
                                      children: List<Widget>.generate(31, (int index) {
                                        return Center(child: SmartText("$index", style: TextStyle(fontSize: 20.sp)));
                                      }),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SmartText(APPStrings.hours.tr, style: style.subTitleStyle),
                            SizedBox(
                              height: 250.h,
                              child: ValueListenableBuilder(
                                  valueListenable: hours,
                                  builder: (context, value, child) {
                                    return CupertinoPicker(
                                      scrollController: FixedExtentScrollController(initialItem: hours.value),
                                      itemExtent: 32.h,
                                      looping: true,
                                      onSelectedItemChanged: (int value) {
                                        hours.value = value;
                                      },
                                      children: List<Widget>.generate(24, (int index) {
                                        return Center(child: SmartText("$index", style: TextStyle(fontSize: 20.sp)));
                                      }),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SmartText(APPStrings.minutes.tr, style: style.subTitleStyle),
                            SizedBox(
                              height: 250.h,
                              child: ValueListenableBuilder(
                                  valueListenable: minutes,
                                  builder: (context, value, child) {
                                    return CupertinoPicker(
                                      scrollController: FixedExtentScrollController(initialItem: minutes.value),
                                      itemExtent: 32.h,
                                      looping: true,
                                      useMagnifier: true,
                                      onSelectedItemChanged: (int value) {
                                        minutes.value = value;
                                      },
                                      children: List<Widget>.generate(60, (int index) {
                                        return Center(child: SmartText("$index", style: TextStyle(fontSize: 20.sp)));
                                      }),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SmartButton(
                      onTap: () {
                        onDurationChanged(Duration(days: days.value, hours: hours.value, minutes: minutes.value));
                        context.pop();
                      },
                      title: APPStrings.ok.tr),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: SmartImage(
                    path: AppImages.icCross,
                    width: 24.w,
                    height: 24.w,
                    onTap: () {
                      context.pop();
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
