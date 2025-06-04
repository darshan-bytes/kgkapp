import 'package:kgk/kgk.dart';

class BuildCustomizationList extends StatelessWidget {
  final ProductDetailsBloc bloc;

  const BuildCustomizationList({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bloc.productCustomizations.length,
      itemBuilder: (context, index) => ProductDetailsCustomizations(index: index),
      separatorBuilder: (_, _) => Divider(height: 48.h),
    );
  }
}

class ProductDetailsCustomizations extends StatelessWidget {
  final int index;

  const ProductDetailsCustomizations({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsBloc productDetailsBloc = BlocProvider.of<ProductDetailsBloc>(context);
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    ProductCustomizeDataDatum productCustomization = productDetailsBloc.productCustomizations[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(productCustomization.name, style: style.settingSelectionTitleStyle),
        SizedBox(height: 8.h),
        SmartSingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 10.w,
            children: List.generate(productCustomization.data.length, (childIndex) {
              return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
                buildWhen:
                    (previous, current) =>
                        current is ProductCustomizationChangeState &&
                        current.index == index &&
                        (current.childIndex == childIndex || current.oldChildIndex == childIndex),
                builder: (context, state) {
                  ProductCustomizationOptions value = productCustomization.data[childIndex];
                  bool isSelected = productCustomization.selectedValue == value;
                  bool isApplicable = value.isApplicable;

                  return CustomizationItem(
                    isSelected: isSelected,
                    isApplicable: isApplicable,
                    style: style,
                    icon: value.icon,
                    name: value.name,
                    onTap: () {
                      productDetailsBloc.add(ProductCustomizationChangeEvent(index: index, childIndex: childIndex, context: context));
                    },
                  );
                },
              );
            }),
          ),
        ),
        BuildVariantsList(bloc: productDetailsBloc, index: index, style: style),
      ],
    );
  }
}

class CustomizationItem extends StatelessWidget {
  final String? icon;
  final String? name;
  final bool isSelected;
  final bool isApplicable;
  final ProductDetailsStyle style;
  final VoidCallback? onTap;

  const CustomizationItem({
    super.key,
    this.icon,
    this.name,
    required this.isSelected,
    required this.isApplicable,
    required this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap:
          isApplicable
              ? () {
                onTap?.call();
              }
              : null,
      child: Opacity(
        opacity: isApplicable ? 1 : 0.5,
        child: Container(
          clipBehavior: Clip.antiAlias,
          constraints: BoxConstraints(minWidth: icon.isNotNullNorEmpty ? 80.w : 0),
          padding: EdgeInsetsDirectional.symmetric(horizontal: 6.w, vertical: 6.w + (isSelected ? 0 : 2.w)),
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: style.selectedSettingBorderColor, width: 1.w) : null,
            borderRadius: BorderRadius.circular(5.r),
            color: style.customiseBoxColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon.isNotNullNorEmpty) _buildCustomizationType(isSelected, style),
              if (name.isNotNullNorEmpty && icon.isNotNullNorEmpty) SizedBox(height: 8.h),
              if (name.isNotNullNorEmpty)
                SmartText(
                  name,
                  style: isSelected ? style.selectedSettingStyle : style.settingSelectionValueStyle,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomizationType(bool isSelected, ProductDetailsStyle style) {
    return SmartImage(
      path: icon ?? '',
      imageBorderRadius: BorderRadius.circular(10.r),
      color: isSelected ? style.selectedSettingBorderColor : null,
      height: 42.w,
      width: 42.w,
      isMemCacheEnabled: false,
    );
  }
}

class BuildVariantsList extends StatelessWidget {
  final ProductDetailsBloc bloc;
  final int index;
  final ProductDetailsStyle style;

  const BuildVariantsList({super.key, required this.bloc, required this.index, required this.style});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      bloc: bloc,
      buildWhen: (previous, current) => current is ProductCustomizationChangeState && current.index == index && current.isVariant,
      builder: (context, state) {
        List<Variant> variants = bloc.productCustomizations[index].selectedValue?.variants ?? [];
        if (variants.isNotEmpty) {
          return ListView.separated(
            primary: false,
            padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: variants.length,
            itemBuilder: (context, variantIndex) {
              Variant variant = variants[variantIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartText(variant.name, style: style.settingSelectionTitleStyle),
                  SizedBox(height: 8.h),
                  SmartHorizontalItemBuilder(
                    itemCount: variant.data.length,
                    itemBuilder: (context, variantDataIndex) {
                      VariantDatum variantDatum = variant.data[variantDataIndex];
                      return CustomizationItem(
                        isApplicable: true,
                        isSelected: variant.selectedVariantDatum == variantDatum,
                        style: style,
                        icon: variantDatum.icon,
                        name: variantDatum.name,
                        onTap: () {
                          bloc.add(
                            ProductCustomizationChangeEvent(
                              index: index,
                              childIndex: variantIndex,
                              context: context,
                              isVariant: true,
                              selectedVariantIndex: variantDataIndex,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 24.h),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
