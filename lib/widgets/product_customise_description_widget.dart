import 'package:kgk/kgk.dart';

class ProductCustomiseDescriptionWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ProductCustomiseDescriptionWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: style.customiseBoxColor,
          border: Border.all(color: style.customiseBoxBorderColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SmartText(APPStrings.customiseDescription.tr, style: style.settingSelectionTitleStyle),
                  SizedBox(height: 8.h),
                  SmartText(APPStrings.craftingDescription.tr, style: style.productCodeStyle),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            IconButton(
                onPressed: () {
                  onTap();
                },
                icon: const SmartImage(
                  path: AppImages.icArrowRight,
                ))
          ],
        ),
      ),
    );
  }
}
