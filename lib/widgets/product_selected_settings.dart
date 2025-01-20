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
          height: 24.w,
          width: 24.w,
          color: selectedSettings.imageColor,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SmartText(selectedSettings.name, style: style.titleStyle),
              SizedBox(height: 6.h),
              if (selectedSettings.specification.isNotNullNorEmpty) ...[
                SmartText(selectedSettings.specification, style: style.specialityStyle),
                SizedBox(height: 4.h),
              ],
              SmartText(selectedSettings.price, style: style.titleStyle),
              SizedBox(height: 12.h),
              SmartButton(
                title: APPStrings.change.tr,
                width: 100.w,
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
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
