
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
      padding:padding ?? const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
      child: Row(
        children: [
          _commonSelector(context, selectedStep == 1, 'Choose a Diamond', 1),
          _commonSelector(context, selectedStep == 2, 'Choose a Setting', 2),
          _commonSelector(context, selectedStep == 3, 'Complete Ring', 3),
        ],
      ),
    );
  }

  Widget _commonSelector(BuildContext context, bool isSelected, String title, int index) {
    final style = AppTheme.of(context).diyProgressViewStyle;
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? style.selectedBorderColor : style.unselectedBorderColor, width: 1),
        ),
        padding: EdgeInsets.all(12),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SmartText('$index'),
            const SizedBox(width: 8,),
            Expanded(child: SmartText(title, style: style.titleStyle,)),
          ],
        ),
      ),
    );
  }

}