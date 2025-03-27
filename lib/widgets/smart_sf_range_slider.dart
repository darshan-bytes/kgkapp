import '../kgk.dart';

class SmartSfRangeSlider extends StatelessWidget {
  final TextStyle? style;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final void Function(RangeValues)? onChanged;
  final void Function(PointerDownEvent)? onMinControllerTapOutside;
  final void Function()? onMinControllerEditingComplete;
  final void Function(PointerDownEvent)? onMaxControllerTapOutside;
  final void Function()? onMaxControllerEditingComplete;
  final RangeValues values;
  final RangeValues? minMaxValues;
  final Color? rangeSliderTrackColor;
  final Color? sliderThumbColor;
  final Color? sliderThumbBorderColor;
  final TextStyle? sliderLabelTextStyle;
  final TextStyle? propertySelectionSubtitleStyle;
  final String? currencySymbol;
  final String? title;
  final TextStyle? titleStyle;
  final double? stepSize;
  final double? interval;
  final bool? showDividers;

  const SmartSfRangeSlider({
    super.key,
    this.style,
    required this.minPriceController,
    required this.maxPriceController,
    this.onChanged,
    this.onMinControllerTapOutside,
    this.onMinControllerEditingComplete,
    this.onMaxControllerTapOutside,
    this.onMaxControllerEditingComplete,
    required this.values,
    this.minMaxValues,
    this.rangeSliderTrackColor,
    this.sliderThumbColor,
    this.sliderThumbBorderColor,
    this.sliderLabelTextStyle,
    this.propertySelectionSubtitleStyle,
    this.currencySymbol,
    this.title,
    this.titleStyle,
    this.stepSize,
    this.interval,
    this.showDividers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotNullNorEmpty)
          SmartText(
            title,
            style: titleStyle,
            optionalPadding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          ),
        SizedBox(height: 16.h),
        SliderTheme(
            data: SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
              trackShape: RoundedRectSliderTrackShape(),
            ),
            child: RangeSlider(
              values: values,
              min: minMaxValues?.start ?? 0.0,
              max: minMaxValues?.end ?? 100.0,
              divisions: showDividers == true
                  ? ((minMaxValues?.end ?? 100.0).toInt() > 1
                      ? ((minMaxValues?.end ?? 100.0).toInt() - 1)
                      : ((minMaxValues?.end ?? 100.0).toInt()))
                  : null,
              labels: RangeLabels(values.start.toStringAsFixed(2), values.end.toStringAsFixed(2)),
              activeColor: rangeSliderTrackColor,
              onChanged: onChanged,
              onChangeEnd: (value) => onMaxControllerEditingComplete?.call(),
            )),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmartTextField(
                        padding: EdgeInsetsDirectional.symmetric(vertical: 4.h),
                        height: 40.h,
                        contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                        textAlign: TextAlign.center,
                        controller: minPriceController,
                        keyboardType: TextInputType.number,
                        style: propertySelectionSubtitleStyle,
                        onTapOutside: (p) => onMinControllerTapOutside?.call(p),
                        onEditingComplete: () => onMinControllerEditingComplete?.call(),
                        textInputAction: TextInputAction.done,
                      ),
                      SmartText(
                        APPStrings.min.tr,
                        style: sliderLabelTextStyle,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmartTextField(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 4.h),
                      height: 40.h,
                      contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                      textAlign: TextAlign.center,
                      controller: maxPriceController,
                      keyboardType: TextInputType.number,
                      style: propertySelectionSubtitleStyle,
                      onTapOutside: (p) => onMaxControllerTapOutside?.call(p),
                      onEditingComplete: () => onMaxControllerEditingComplete?.call(),
                      textInputAction: TextInputAction.done,
                    ),
                    SmartText(
                      APPStrings.max.tr,
                      style: sliderLabelTextStyle,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliderThumb() {
    return Container(
      height: 24.h,
      width: 24.w,
      decoration: BoxDecoration(
        color: sliderThumbColor,
        border: sliderThumbBorderColor != null ? Border.all(color: sliderThumbBorderColor!) : null,
        shape: BoxShape.circle,
      ),
    );
  }
}
