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
        SizedBox(height: 8.h),
        SmartSingleChildScrollView(
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
                    case ProductCustomizationType.head:
                      return SizedBox(
                        width: productCustomization.productCustomizationType == ProductCustomizationType.head ? 87.w : 72.w,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          onTap: () {
                            productDetailsBloc.add(ProductCustomizationChangeEvent(index: index, childIndex: childIndex));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildCustomizationType(isSelected, value, style, productCustomization.productCustomizationType),
                                if (value.value.isNotNullNorEmpty) ...[
                                  SizedBox(height: 8.h),
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
                        padding: EdgeInsets.only(right: childIndex != (productCustomization.values?.length ?? 0) - 1 ? 14.w : 0),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          onTap: () {
                            productDetailsBloc.add(ProductCustomizationChangeEvent(index: index, childIndex: childIndex));
                          },
                          child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: 40.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: style.settingSelectionButtonColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: isSelected ? Border.all(color: style.selectedSettingBorderColor, width: 1.w) : null,
                                ),
                                padding: EdgeInsets.all(8.w),
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
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        onTap: () {
                          productDetailsBloc.add(ProductCustomizationChangeEvent(index: index, childIndex: childIndex));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildCustomizationType(isSelected, value, style, productCustomization.productCustomizationType),
                              if (value.value.isNotNullNorEmpty) ...[
                                SizedBox(height: 8.h),
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
                      return const SizedBox.shrink();
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
      case ProductCustomizationType.head:
        return Container(
          height: 42.w,
          width: 42.w,
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: style.selectedSettingBorderColor) : null,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SmartImage(
            path: value.image ?? '',
            imageBorderRadius: BorderRadius.circular(10.r),
            color: isSelected ? style.selectedSettingBorderColor : null,
          ),
        );
      case ProductCustomizationType.metal:
        return Container(
          height: 34.w,
          width: 34.w,
          padding: EdgeInsets.all(4.w),
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
          height: 50.w,
          width: 50.w,
          padding: EdgeInsets.all(8.w),
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
        return const SizedBox.shrink();
    }
  }
}
