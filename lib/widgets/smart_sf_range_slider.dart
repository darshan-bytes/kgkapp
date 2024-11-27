import '../kgk.dart';

class SmartSfRangeSlider extends StatelessWidget {
  final TextStyle? style;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final void Function(SfRangeValues)? onChanged;
  final void Function(PointerDownEvent)? onMinControllerTapOutside;
  final void Function(PointerDownEvent)? onMinControllerEditingComplete;
  final void Function(PointerDownEvent)? onMaxControllerTapOutside;
  final void Function(PointerDownEvent)? onMaxControllerEditingComplete;
  final SfRangeValues values;
  final SfRangeValues? minMaxValues;
  final Color? rangeSliderTrackColor;
  final Color? sliderThumbColor;
  final Color? sliderThumbBorderColor;
  final TextStyle? sliderLabelTextStyle;
  final TextStyle? propertySelectionSubtitleStyle;
  final Widget? startThumbIcon;
  final Widget? endThumbIcon;
  final String? currencySymbol;
  final String? title;
  final TextStyle? titleStyle;
  final bool? enableToolTip;
  final bool? shouldAlwaysShowTooltip;
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
    this.startThumbIcon,
    this.endThumbIcon,
    this.currencySymbol,
    this.title,
    this.titleStyle,
    this.enableToolTip,
    this.shouldAlwaysShowTooltip,
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
            optionalPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        SizedBox(height: 16.h),
        SfRangeSlider(
          enableTooltip: enableToolTip ?? true,
          values: values,
          min: minMaxValues?.start,
          max: minMaxValues?.end,
          interval: interval ?? 100,
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          stepSize: stepSize ?? 1,
          activeColor: rangeSliderTrackColor,
          startThumbIcon: startThumbIcon ?? _buildSliderThumb(),
          endThumbIcon: endThumbIcon ?? _buildSliderThumb(),
          onChanged: (SfRangeValues values) => onChanged!(values),
          shouldAlwaysShowTooltip: shouldAlwaysShowTooltip ?? false,
          showDividers: showDividers ?? false,
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmartTextField(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        prefixText: currencySymbol ?? "".setCurrency,
                        height: 40.h,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                        textAlign: TextAlign.center,
                        controller: minPriceController,
                        keyboardType: TextInputType.number,
                        style: propertySelectionSubtitleStyle,
                        onTapOutside: (p) => onMinControllerTapOutside!(p), // bloc.add(const FilterPriceRangeEditEvent()),
                        onEditingComplete: () => onMinControllerEditingComplete, // bloc.add(const FilterPriceRangeEditEvent()),
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
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      prefixText: currencySymbol ?? "".setCurrency,
                      height: 40.h,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                      textAlign: TextAlign.center,
                      controller: maxPriceController,
                      keyboardType: TextInputType.number,
                      style: propertySelectionSubtitleStyle,
                      onTapOutside: (p) => onMaxControllerTapOutside!(p),
                      onEditingComplete: () => onMaxControllerEditingComplete,
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
