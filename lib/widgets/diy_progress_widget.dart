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
        width: double.infinity,
        child: Stack(
          children: [
            _commonChevron(context, selectedStep == 1, 'Choose a', 1, 'Diamond'),
            Positioned(left: 105.w, child: _commonChevron(context, selectedStep == 2, 'Choose a', 2, 'Setting')),
            Positioned(left: 112.w * 2, child: _commonChevron(context, selectedStep == 3, 'Choose a', 3, 'Ring')),
          ],
        )

        // Row(
        //   children: [
        //     _commonChevron(context, selectedStep == 1, 'Choose a', 1, 'Diamond'),
        //     _commonChevron(context, selectedStep == 2, 'Choose a', 2, 'Setting'),
        //     _commonChevron(context, selectedStep == 3, 'Complete', 3, 'Ring'),
        //   ],
        // ),
        );
  }

  Widget _commonChevron(BuildContext context, bool isSelected, String title, int index, String subTitle) {
    final style = AppTheme.of(context).diyProgressViewStyle;

    return index == 1
        ? Chevron(
            color: isSelected
                ? style.backgroundChevronColor
                : selectedStep + 1 == index
                    ? style.backgroundChevronColor.withOpacity(0.5)
                    : style.unselectedBorderColor.withOpacity(0.3),
            child: SmartText(
              '$title \n$subTitle',
              maxLines: 2,
              style: isSelected
                  ? style.selectedIndexStyle
                  : selectedStep + 1 == index
                      ? style.selectedIndexStyle
                      : style.selectedIndexStyle.copyWith(color: Colors.black),
              optionalPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
          )
        : ChevronProgress(
            isLabel: !(selectedStep + 1 == index),
            color: isSelected
                ? style.backgroundChevronColor
                : selectedStep + 1 == index
                    ? style.backgroundChevronColor.withOpacity(0.5)
                    : style.unselectedBorderColor.withOpacity(0.3),
            child: Center(
              child: SmartText(
                '$title \n$subTitle',
                maxLines: 2,
                style: isSelected
                    ? style.selectedIndexStyle
                    : selectedStep + 1 == index
                        ? style.selectedIndexStyle
                        : style.selectedIndexStyle.copyWith(color: Colors.black),
                optionalPadding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
              ),
            ));
  }

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
