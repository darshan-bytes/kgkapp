import 'package:kgk/kgk.dart';

class ProductDetailsComponentsView extends StatelessWidget {
  final Commodity commodity;
  final List<Component>? components;
  final List<StoneElement>? stoneElements;

  const ProductDetailsComponentsView({super.key, required this.commodity, this.components, this.stoneElements});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).productDetailsStyle;

    if (_isGemstoneOrDiamond()) {
      return _buildGemstoneOrDiamondView(context, style);
    } else {
      return _buildJewelryComponentsView(context, style);
    }
  }

  bool _isGemstoneOrDiamond() {
    return commodity == Commodity.diamond || commodity == Commodity.gemstone;
  }

  Widget _buildGemstoneOrDiamondView(BuildContext context, ProductDetailsStyle style) {
    if (stoneElements.isNullOrEmpty) {
      return const SizedBox();
    }
    return SmartExpansionTile(
      onExpansionChanged: (value) {},
      title: SmartText(commodity == Commodity.diamond ? APPStrings.diamondDetails : APPStrings.gemstoneDetails,
          style: style.settingSelectionTitleStyle),
      children: _buildStoneElementWidgets(stoneElements ?? [], context),
    );
  }

  Widget _buildJewelryComponentsView(BuildContext context, ProductDetailsStyle style) {
    if (components.isNullOrEmpty) {
      return const SizedBox();
    }

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: components!.length,
      itemBuilder: (context, index) {
        final component = components![index];
        return SmartExpansionTile(
          onExpansionChanged: (value) {},
          title: SmartText(component.title, style: style.settingSelectionTitleStyle),
          children: _buildSubComponentWidgets(component.values, context),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  List<Widget> _buildSubComponentWidgets(List<List<ValueElement>> subComponents, BuildContext context) {
    final widgets = <Widget>[];
    for (final subComponentList in subComponents) {
      for (final valueElement in subComponentList) {
        bool isUrl = valueElement.value?.isURL ?? false;
        widgets.add(_settingWidget(valueElement.title ?? '', isUrl ? APPStrings.clickHeretoView : valueElement.value ?? '', context,
            url: isUrl ? valueElement.value : null));
      }
      if (subComponents.last != subComponentList) {
        widgets.add(Divider(height: 32.h));
      }
    }
    return widgets;
  }

  List<Widget> _buildStoneElementWidgets(List<StoneElement> stoneElements, BuildContext context) {
    return stoneElements.map((element) {
      bool isUrl = element.value?.isURL ?? false;
      return _settingWidget(element.title ?? '', isUrl ? APPStrings.clickHeretoView : element.value ?? '', context,
          url: isUrl ? element.value : null);
    }).toList();
  }

  Widget _settingWidget(String type, String value, BuildContext context, {String? url}) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(type, style: style.settingTypeStyle),
          SmartText(
            value.isNotNullNorEmpty ? value : APPStrings.dash.tr,
            style: url.isNotNullNorEmpty
                ? style.settingValueStyle.copyWith(color: AppTheme.of(context).colors.primary, decoration: TextDecoration.underline)
                : style.settingValueStyle,
            onTap: url.isNotNullNorEmpty
                ? () {
                    Utils.launchUrlFromString(url!);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
