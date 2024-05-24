import 'package:kgk/kgk.dart';

class ProductSelectedSettings extends StatelessWidget {
  final VoidCallback onTap;
  final SelectedSettings selectedSettings;

  const ProductSelectedSettings({
    super.key,
    required this.onTap,
    required this.selectedSettings,
  });

  @override
  Widget build(BuildContext context) {
    final SelectedSettingsStyle style = AppTheme.of(context).selectedSettingsStyle;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartImage(
          path: selectedSettings.image ?? '',
          height: 24,
          width: 24,
          color: selectedSettings.imageColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SmartText(selectedSettings.name, style: style.titleStyle),
              const SizedBox(height: 6),
              SmartText(selectedSettings.specification, style: style.specialityStyle),
              const SizedBox(height: 4),
              SmartText(selectedSettings.price, style: style.titleStyle),
              const SizedBox(height: 12),
              SmartText(
                APPStrings.change.tr,
                style: style.changeTextStyle,
                onTap: () {
                  onTap();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
