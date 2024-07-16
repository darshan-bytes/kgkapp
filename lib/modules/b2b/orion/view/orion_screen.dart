import 'package:kgk/kgk.dart';

class OrionScreen extends StatelessWidget {
  const OrionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrionBloc bloc = BlocProvider.of<OrionBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.orion.tr,
        onSearch: () => context.pushNamed(AppRoutes.searchPage),
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
      ),
      body: getBody(context, bloc),
    );
  }

  Widget getBody(BuildContext context, OrionBloc bloc) {
    final OrionStyle style = AppTheme.of(context).orionStyle;
    return BlocBuilder<OrionBloc, OrionState>(
      buildWhen: (previous, current) => previous != current && current is OrionLoadedState,
      builder: (context, state) {
        if (state is OrionLoadedState) {
          return SmartSingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDiamondShapeList(bloc, style),
                _buildPriceRangeSlide(bloc, style),
                Divider(height: 80.h),
                _buildSelectDiamondChart(bloc, style),
                SizedBox(height: 40.h),
                _buildDiamondPropertySelectionList(bloc, style),
              ],
            ),
          );
        }
        return const SmartCircularProgressIndicator();
      },
    );
  }

  Widget _buildDiamondShapeList(OrionBloc bloc, OrionStyle style) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 192.h),
      child: SmartHorizontalItemBuilder(
        title: APPStrings.selectDiamondShape.tr,
        titleStyle: style.selectionTitleStyle,
        spacingBetweenTitleAndItems: 16.h,
        scrollController: bloc.diamondShapeListController,
        itemBetweenSpace: 16.w,
        isScrollbarVisible: true,
        itemCount: bloc.diamondShapeList.length,
        itemBuilder: (context, index) {
          return BlocBuilder<OrionBloc, OrionState>(
            buildWhen: (previous, current) =>
                previous != current && current is OrionDiamondShapeChangedState && (current.newIndex == index || current.oldIndex == index),
            builder: (context, state) {
              ProductCustomizationOptionValues value = bloc.diamondShapeList[index];
              bool isSelected = bloc.selectedDiamondShape == value;
              return InkWell(
                borderRadius: BorderRadius.circular(8.w),
                onTap: () {
                  bloc.add(OrionDiamondShapeChangedEvent(index));
                },
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: isSelected ? style.selectedDiamondSelectionBackgroundColor : null,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SmartImage(path: value.image ?? '', height: 48.h, width: 48.w),
                      SizedBox(height: 8.h),
                      SmartText(value.value,
                          style: isSelected ? style.selectedDiamondSelectionTitleStyle : style.diamondSelectionTitleStyle,
                          textAlign: TextAlign.center),
                      SizedBox(height: 4.h),
                      SmartText(value.availableProductCount.toString(),
                          style: isSelected ? style.selectedDiamondSelectionValueStyle : style.diamondSelectionValueStyle,
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPriceRangeSlide(OrionBloc bloc, OrionStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.preferredPriceRange.tr, style: style.selectionTitleStyle),
        SizedBox(height: 16.h),
        BlocBuilder<OrionBloc, OrionState>(
          buildWhen: (previous, current) => previous != current && current is OrionPriceRangeChangedState,
          builder: (context, state) {
            return Column(
              children: [
                SfRangeSlider(
                  enableTooltip: true,
                  values: bloc.values,
                  min: bloc.minMaxValues.start,
                  max: bloc.minMaxValues.end,
                  interval: 100,
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                  stepSize: 1,
                  activeColor: style.rangeSliderTrackColor,
                  startThumbIcon: _buildSliderThumb(style),
                  endThumbIcon: _buildSliderThumb(style),
                  onChanged: (SfRangeValues values) => bloc.add(OrionPriceRangeChangedEvent(values)),
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 98.w,
                      child: SmartTextField(
                        height: 40.h,
                        textAlign: TextAlign.center,
                        controller: bloc.minPriceController,
                        keyboardType: TextInputType.number,
                        style: style.propertySelectionSubtitleStyle,
                        onTapOutside: (p) => bloc.add(const OrionPriceRangeEditEvent()),
                        onEditingComplete: () => bloc.add(const OrionPriceRangeEditEvent()),
                        textInputAction: TextInputAction.done,
                        maxLength: 5,
                      ),
                    ),
                    SizedBox(
                      width: 98.w,
                      child: SmartTextField(
                        height: 40.h,
                        textAlign: TextAlign.center,
                        controller: bloc.maxPriceController,
                        keyboardType: TextInputType.number,
                        style: style.propertySelectionSubtitleStyle,
                        onTapOutside: (p) => bloc.add(const OrionPriceRangeEditEvent(isMin: false)),
                        onEditingComplete: () => bloc.add(const OrionPriceRangeEditEvent(isMin: false)),
                        textInputAction: TextInputAction.done,
                        maxLength: 5,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildSliderThumb(OrionStyle style) {
    return Container(
      height: 24.h,
      width: 24.w,
      decoration: BoxDecoration(
        color: style.sliderThumbColor,
        border: Border.all(color: style.sliderThumbBorderColor),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSelectDiamondChart(OrionBloc bloc, OrionStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(APPStrings.selectDiamond.tr, style: style.selectDiamondTitleStyle),
        SizedBox(height: 16.h),
        SmartImage(path: "https://i.ibb.co/jRKtJT6/Chart.png", height: 430.h, width: double.infinity),
      ],
    );
  }

  Widget _buildDiamondPropertySelectionList(OrionBloc bloc, OrionStyle style) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bloc.diamondPropertiesList.length,
      itemBuilder: (context, index) {
        return _buildDiamondPropertySelection(style, bloc, index);
      },
      separatorBuilder: (context, index) => Divider(height: 48.h),
    );
  }

  Widget _buildDiamondPropertySelection(OrionStyle style, OrionBloc bloc, int index) {
    return BlocBuilder<OrionBloc, OrionState>(
      buildWhen: (previous, current) =>
          previous != current && current is OrionDiamondPropertiesChangedState && (current.diamondPropertiesIndex == index),
      builder: (context, state) {
        final OrionDiamondPropertiesDataModel diamondProperties = bloc.diamondPropertiesList[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmartText(diamondProperties.title, style: style.selectionTitleStyle),
            SizedBox(height: 8.h),
            if (diamondProperties.selectedProperties != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SmartText(diamondProperties.selectedProperties?.title, style: style.selectDiamondTitleStyle),
                  SizedBox(width: 8.w),
                  SmartText(diamondProperties.selectedProperties?.subTitle, style: style.propertySelectionSubtitleStyle),
                ],
              ),
              SizedBox(height: 8.h),
            ],
            SmartHorizontalItemBuilder(
              itemCount: diamondProperties.propertiesList!.length,
              scrollController: bloc.diamondPropertiesListController[index],
              itemBetweenSpace: 20.w,
              isScrollbarVisible: true,
              itemBuilder: (context, propertiesIndex) {
                final OrionPropertiesDetails properties = diamondProperties.propertiesList![propertiesIndex];
                final bool isSelected = diamondProperties.selectedProperties == properties;
                return GestureDetector(
                  onTap: () => bloc.add(OrionDiamondPropertiesChangedEvent(index, propertiesIndex)),
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SmartText(
                      properties.title,
                      style: isSelected ? style.selectedPropertyStyle : style.propertyStyle,
                      optionalPadding: EdgeInsets.only(bottom: 18.h),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
