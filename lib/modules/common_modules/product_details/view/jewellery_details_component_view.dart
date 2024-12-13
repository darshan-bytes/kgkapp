import 'package:kgk/kgk.dart';

class JewelleryDetailsComponentsView extends StatelessWidget {
  final List<Component> components;

  const JewelleryDetailsComponentsView({super.key, required this.components});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).productDetailsStyle;
    final bloc = BlocProvider.of<ProductDetailsBloc>(context);

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: components.length,
      itemBuilder: (context, index) {
        Component component = components[index];
        return SmartExpansionTile(
          title: SmartText(component.title, style: style.settingSelectionTitleStyle),
          children: _buildSubComponentWidgets(component.values, context),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  List<Widget> _buildSubComponentWidgets(List<List<ValueElement>> subComponents, BuildContext context) {
    final List<Widget> widgets = [];
    for (List<ValueElement> subComponentList in subComponents) {
      for (ValueElement valueElement in subComponentList) {
        widgets.add(_settingWidget(valueElement.title ?? '', valueElement.value ?? '', context));
      }
      if (subComponents.last != subComponentList) {
        widgets.add(Divider(
          height: 32.h,
        ));
      }
    }
    return widgets;
  }

  Widget _settingWidget(String type, String value, BuildContext context) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(type, style: style.settingTypeStyle),
          SmartText(value.isNotNullNorEmpty ? value : APPStrings.dash.tr, style: style.settingValueStyle),
        ],
      ),
    );
  }
}
