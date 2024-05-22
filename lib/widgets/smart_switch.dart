
import 'package:kgk/kgk.dart';

class SmartSwitch extends StatelessWidget {
  const SmartSwitch({
    super.key,
    this.width,
    this.height,
    required this.onSwitchChange,
    required this.value,
    this.thumbColor,
  });

  final double? height;
  final double? width;
  final Color? thumbColor;
  final Function(bool) onSwitchChange;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          onChanged: onSwitchChange,
          value: value,
          thumbColor: WidgetStateProperty.all(thumbColor),
        ),
      ),
    );
  }

}