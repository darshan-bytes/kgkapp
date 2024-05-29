import 'package:kgk/kgk.dart';

class ProductCustomiseDescriptionWidget extends StatelessWidget {
  const ProductCustomiseDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: style.customiseBoxColor,
        border: Border.all(color: style.customiseBoxBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SmartText(APPStrings.customiseDescription.tr, style: style.settingSelectionTitleStyle),
                const SizedBox(height: 8),
                SmartText(APPStrings.craftingDescription.tr, style: style.productCodeStyle),
              ],
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
              onPressed: () {},
              icon: const SmartImage(
                path: AppImages.icArrowRight,
              ))
        ],
      ),
    );
  }
}
