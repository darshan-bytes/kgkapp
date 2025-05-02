import 'package:kgk/kgk.dart';

class DiyProgressWidget extends StatelessWidget {
  const DiyProgressWidget({super.key, required this.selectedStep, this.padding, this.screenIdentifier, this.diyType});

  final int selectedStep;
  final EdgeInsetsGeometry? padding;
  final ScreenIdentifier? screenIdentifier;
  final DIYType? diyType;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry resolvedPadding = padding ?? EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 12.h);

    final List<AlignmentDirectional> alignments = [
      AlignmentDirectional.centerStart,
      AlignmentDirectional.center,
      AlignmentDirectional.centerEnd,
    ];
    List<String> titleList = [];
    if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
      titleList = [(diyType == DIYType.gemstone ? APPStrings.gemstone : APPStrings.diamond).tr, APPStrings.ring.tr, APPStrings.ring.tr];
    } else if (screenIdentifier == ScreenIdentifier.jewelleryForDIY) {
      titleList = [APPStrings.ring.tr, (diyType == DIYType.gemstone ? APPStrings.gemstone : APPStrings.diamond).tr, APPStrings.ring.tr];
    } else {
      titleList = [(diyType == DIYType.gemstone ? APPStrings.gemstone : APPStrings.diamond).tr, APPStrings.ring.tr, APPStrings.ring.tr];
    }

    return Container(
      padding: resolvedPadding,
      width: context.width,
      child: Stack(
        children: List.generate(3, (index) {
          return Align(
            alignment: alignments[index],
            child: _commonChevron(
              context,
              isSelected: selectedStep == index + 1,
              title: titleList.length == index + 1 ? APPStrings.complete.tr : APPStrings.choose.tr,
              index: index + 1,
              subTitle: titleList[index],
              padding: index == 0 ? 20.w : null,
            ),
          );
        }),
      ),
    );
  }

  Widget _commonChevron(
    BuildContext context, {
    required bool isSelected,
    required String title,
    required int index,
    required String subTitle,
    double? padding,
  }) {
    final style = AppTheme.of(context).diyProgressViewStyle;

    Color backgroundColor = style.unselectedBorderColor.withValues(alpha: 0.5);
    TextStyle textStyle = style.selectedIndexStyle.copyWith(color: Colors.black);

    if (index <= selectedStep) {
      backgroundColor = style.backgroundChevronColor;
      textStyle = style.selectedIndexStyle;
    } else if (index == selectedStep + 1) {
      backgroundColor = style.backgroundChevronColor.withValues(alpha: 0.5);
      textStyle = style.selectedIndexStyle;
    }

    Clipper getClipperAtIndex(int index) {
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
        optionalPadding: EdgeInsetsDirectional.only(start: padding ?? 40.w, top: 10.h, bottom: 10.h),
      ),
    );
  }

  Widget _commonSelector(BuildContext context, bool isSelected, String title, int index, String subTitle) {
    final style = AppTheme.of(context).diyProgressViewStyle;
    return Expanded(
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? style.selectedBorderColor : style.unselectedBorderColor, width: 1),
        ),
        padding: EdgeInsetsDirectional.all(12.w),
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SmartText('$index', style: style.indexStyle),
            SizedBox(width: 8.w),
            Expanded(
              child: SmartRichText(
                spans: [
                  SmartTextSpan(text: title, style: style.titleStyle),
                  SmartTextSpan(text: '\n$subTitle', style: style.subTitleStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
