import 'package:kgk/kgk.dart';

class ProductDetailsCustomizations extends StatelessWidget {
  final int index;

  const ProductDetailsCustomizations({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final ProductDetailsBloc productDetailsBloc = BlocProvider.of<ProductDetailsBloc>(context);
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    ProductCustomizationOptions productCustomization = productDetailsBloc.productCustomizations[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartText(productCustomization.name, style: style.settingSelectionTitleStyle),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(productCustomization.values?.length ?? 0, (childIndex) {
              return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                buildWhen: (previous, current) =>
                    current is ProductCustomizationChangeState &&
                    current.index == index &&
                    (current.childIndex == childIndex || current.oldChildIndex == childIndex),
                builder: (context, state) {
                  ProductCustomizationOptionValues value = productCustomization.values![childIndex];
                  bool isSelected = productCustomization.selectedValue == value;
                  switch (productCustomization.productCustomizationType) {
                    case ProductCustomizationType.image:
                    case ProductCustomizationType.metal:
                      return SizedBox(
                        width: 72,
                        child: InkWell(
                          onTap: () {
                            productDetailsBloc.add(ProductCustomizationChangeEvent(index: index, childIndex: childIndex));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildCustomizationType(isSelected, value, style, productCustomization.productCustomizationType),
                                if (value.value.isNotNullNorEmpty) ...[
                                  const SizedBox(height: 8),
                                  SmartText(
                                    value.value,
                                    style: isSelected ? style.selectedSettingStyle : style.settingSelectionValueStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    case ProductCustomizationType.metalKaratage:
                    case ProductCustomizationType.ringSize:
                      return Padding(
                        padding: EdgeInsets.only(right: childIndex != (productCustomization.values?.length ?? 0) - 1 ? 14 : 0),
                        child: InkWell(
                          onTap: () {
                            productDetailsBloc.add(ProductCustomizationChangeEvent(index: index, childIndex: childIndex));
                          },
                          child: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: style.settingSelectionButtonColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: isSelected ? Border.all(color: style.selectedSettingBorderColor, width: 1) : null,
                                ),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                child: SmartText(
                                  value.value,
                                  style: isSelected ? style.settingSelectionTitleStyle : style.productTypeStyle,
                                ),
                              )),
                        ),
                      );

                    case ProductCustomizationType.diamondQuality:
                      return InkWell(
                        onTap: () {
                          productDetailsBloc.add(ProductCustomizationChangeEvent(index: index, childIndex: childIndex));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildCustomizationType(isSelected, value, style, productCustomization.productCustomizationType),
                              if (value.value.isNotNullNorEmpty) ...[
                                const SizedBox(height: 8),
                                SmartText(
                                  value.value,
                                  style: isSelected ? style.selectedSettingStyle : style.settingSelectionValueStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );

                    default:
                      return const SizedBox();
                  }
                },
              );
            }),
          ),
        )
      ],
    );
  }

  Widget _buildCustomizationType(bool isSelected, ProductCustomizationOptionValues value, ProductDetailsStyle style,
      ProductCustomizationType productCustomizationType) {
    switch (productCustomizationType) {
      case ProductCustomizationType.image:
        return Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: style.selectedSettingBorderColor) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SmartImage(
            path: value.image ?? '',
            imageBorderRadius: BorderRadius.circular(10),
            color: isSelected ? style.selectedSettingBorderColor : null,
          ),
        );
      case ProductCustomizationType.metal:
        return Container(
          height: 34,
          width: 34,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected ? Border.all(color: style.selectedSettingBorderColor) : null,
          ),
          child: SmartImage(
            path: value.image ?? '',
            color: isSelected ? style.selectedSettingBorderColor : null,
          ),
        );

      case ProductCustomizationType.diamondQuality:
        return Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: style.selectedSettingBorderColor) : null,
            shape: BoxShape.circle,
          ),
          child: SmartImage(
            path: value.image ?? '',
            color: isSelected ? style.selectedSettingBorderColor : null,
          ),
        );
      case ProductCustomizationType.other:
      default:
        return const SizedBox();
    }
  }
}
