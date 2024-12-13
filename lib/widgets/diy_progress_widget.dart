import 'package:kgk/kgk.dart';

class DiyProgressWidget extends StatelessWidget {
  const DiyProgressWidget({
    super.key,
    required this.selectedStep,
    this.padding,
  });

  final int selectedStep;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
        width: context.width,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: _commonChevron(context,
                    isSelected: selectedStep == 1, title: 'Choose a', index: 1, subTitle: 'Diamond', padding: 20.w)),
            Align(
                alignment: Alignment.center,
                child: _commonChevron(context, isSelected: selectedStep == 2, title: 'Choose a', index: 2, subTitle: 'Setting')),
            Align(
                alignment: Alignment.centerRight,
                child: _commonChevron(context, isSelected: selectedStep == 3, title: 'Choose a', index: 3, subTitle: 'Ring')),
          ],
        ));
  }

  Widget _commonChevron(BuildContext context,
      {required bool isSelected, required String title, required int index, required String subTitle, double? padding}) {
    final style = AppTheme.of(context).diyProgressViewStyle;

    Color backgroundColor = style.unselectedBorderColor.withValues(alpha:0.5);
    TextStyle textStyle = style.selectedIndexStyle.copyWith(color: Colors.black);

    /// Set Style and Color According to Indexes
    if (index <= selectedStep) {
      backgroundColor = style.backgroundChevronColor;
      textStyle = style.selectedIndexStyle;
    } else if (index == selectedStep + 1) {
      backgroundColor = style.backgroundChevronColor.withValues(alpha:0.5);
      textStyle = style.selectedIndexStyle;
    }

    /// Get Clipper According to Index of List
    Clipper getClipperAtIndex(index) {
      switch (index) {
        case 1:
          return Clipper.start;
        case 2:
          return Clipper.center;
        case 3:
          return Clipper.end;
        default:
          return Clipper.center;
      }
    }

    return ChevronProgress(
        clipper: getClipperAtIndex(index),
        color: backgroundColor,
        child: SmartText(
          '$title \n$subTitle',
          maxLines: 2,
          style: textStyle,
          optionalPadding: EdgeInsets.only(left: padding ?? 40.w, top: 10.h, bottom: 10.h),
        ));
  }

  /// This Widget is not used Currently but we can use this in Future
  Widget _commonSelector(BuildContext context, bool isSelected, String title, int index, String subTitle) {
    final style = AppTheme.of(context).diyProgressViewStyle;
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? style.selectedBorderColor : style.unselectedBorderColor, width: 1),
        ),
        padding: EdgeInsets.all(12.w),
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SmartText('$index', style: style.indexStyle),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
                child: SmartRichText(
              spans: [
                SmartTextSpan(text: title, style: style.titleStyle),
                SmartTextSpan(text: '\n$subTitle', style: style.subTitleStyle),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
