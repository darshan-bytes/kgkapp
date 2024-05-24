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
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
      child: Row(
        children: [
          _commonSelector(context, selectedStep == 1, 'Choose a', 1, 'Diamond'),
          _commonSelector(context, selectedStep == 2, 'Choose a', 2, 'Setting'),
          _commonSelector(context, selectedStep == 3, 'Complete', 3, 'Ring'),
        ],
      ),
    );
  }

  Widget _commonSelector(BuildContext context, bool isSelected, String title, int index, String subTitle) {
    final style = AppTheme.of(context).diyProgressViewStyle;
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? style.selectedBorderColor : style.unselectedBorderColor, width: 1),
        ),
        padding: const EdgeInsets.all(12),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SmartText('$index', style: style.indexStyle),
            const SizedBox(
              width: 8,
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
