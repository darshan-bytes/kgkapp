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
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDiamondShapeList(bloc, style),
                _buildPriceRangeSlide(bloc, style),
                Divider(height: 80.h),
                _buildSelectDiamondChart(context, bloc, style),
                SizedBox(height: 40.h),
                _buildCutSelection(style, bloc),
                _buildClaritySelection(style, bloc),
                _buildColorSelection(style, bloc),
              ],
            ),
          );
        }
        return const SmartCircularProgressIndicator();
      },
    );
  }

  Widget _buildDiamondShapeList(OrionBloc bloc, OrionStyle style) {
    return SmartHorizontalItemBuilder(
      title: APPStrings.selectDiamondShape.tr,
      titleStyle: style.selectionTitleStyle,
      spacingBetweenTitleAndItems: 16.h,
      scrollController: bloc.diamondShapeListController,
      itemBetweenSpace: 16.w,
      listPadding: EdgeInsets.only(bottom: 12.h),
      isScrollbarVisible: true,
      itemCount: bloc.diamondShapeList.length,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
    );
  }

  Widget _buildPriceRangeSlide(OrionBloc bloc, OrionStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
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
                    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 2),
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
                      IntrinsicWidth(
                        child: SmartTextField(
                          height: 40.h,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
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
                      IntrinsicWidth(
                        child: SmartTextField(
                          height: 40.h,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                          textAlign: TextAlign.center,
                          controller: bloc.maxPriceController,
                          keyboardType: TextInputType.number,
                          style: style.propertySelectionSubtitleStyle,
                          onTapOutside: (p) => bloc.add(const OrionPriceRangeEditEvent(isMin: false)),
                          onEditingComplete: () => bloc.add(const OrionPriceRangeEditEvent(isMin: false)),
                          textInputAction: TextInputAction.done,
                          maxLength: 5,
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
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

  Widget _buildSelectDiamondChart(BuildContext context, OrionBloc bloc, OrionStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SmartText(APPStrings.selectDiamond.tr, style: style.selectDiamondTitleStyle),
        ),
        SizedBox(height: 16.h),
        BlocBuilder<OrionBloc, OrionState>(
          buildWhen: (previous, current) => current is OrionDiamondMovedState,
          builder: (context, state) {
            return SizedBox(
              height: 430.w,
              width: context.width,
              child: Stack(
                children: [
                  SfCartesianChart(
                    key: bloc.chartKey,
                    primaryXAxis: NumericAxis(
                      minimum: 0,
                      maximum: 40,
                      interval: 5,
                      axisLabelFormatter: (AxisLabelRenderDetails details) {
                        return ChartAxisLabel(
                          '${details.value.toInt()} ct',
                          const TextStyle(color: Colors.black),
                        );
                      },
                      axisLine: const AxisLine(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      axisLabelFormatter: (AxisLabelRenderDetails details) {
                        // Format the label to display as price
                        return ChartAxisLabel('\$${details.value.toStringAsFixed(2).padRight(0)}', const TextStyle(color: Colors.black));
                      },
                      onRendererCreated: (NumericAxisController controller) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Future.delayed(const Duration(milliseconds: 50), () {
                            bloc.yAxisWidth = controller.axis.paintBounds.width;
                          });
                        });
                      }, // Hide the labels
                      axisLine: const AxisLine(width: 0), // Hide the y-axis line
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    onChartTouchInteractionMove: (tapArgs) {
                      bloc.add(OrionDiamondChartTouchInteractionMoveEvent(tapArgs: tapArgs));
                    },
                    onChartTouchInteractionDown: (tapArgs) {
                      bloc.add(OrionDiamondChartTouchInteractionDownEvent(tapArgs: tapArgs));
                    },
                    onChartTouchInteractionUp: (tapArgs) {
                      bloc.add(OrionDiamondChartTouchInteractionUpEvent(tapArgs: tapArgs));
                    },
                    series: <CartesianSeries<ChartDataModel, num>>[
                      ScatterSeries<ChartDataModel, num>(
                        markerSettings: const MarkerSettings(isVisible: true),
                        onPointTap: (value) {
                          bloc.pinPosition = bloc.chartSeriesController!.pointToPixel(CartesianChartPoint<num>(
                              x: value.dataPoints?[(value.viewportPointIndex ?? 0).toInt()].x,
                              y: value.dataPoints?[(value.viewportPointIndex ?? 0).toInt()].y ?? 0));

                          bloc.snapPinToNearestPoint();
                        },
                        onPointLongPress: (pointInteractionDetails) {
                          bloc.add(OrionDiamondChangePointIndexEvent(index: pointInteractionDetails.pointIndex ?? 0));
                        },
                        dataSource: bloc.chartData,
                        onRendererCreated: (ChartSeriesController controller) {
                          bloc.chartSeriesController = controller;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Future.delayed(const Duration(milliseconds: 50), () {
                              bloc.add(const OrionDiamondCalculateDotPositionsEvent());
                            });
                          });
                        },
                        xValueMapper: (ChartDataModel data, _) => data.x,
                        yValueMapper: (ChartDataModel data, _) => data.y,
                      ),
                    ],
                  ),
                  Positioned(
                    left: bloc.pinPosition.dx + bloc.yAxisWidth - 10,
                    top: bloc.pinPosition.dy - 26,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanUpdate: (value) {
                        bloc.add(OrionDiamondUpdatePinPositionEvent(dragUpdateDetails: value));
                      },
                      onPanEnd: (details) {
                        bloc.add(const OrionDiamondSnapNearestPoint());
                      },
                      child: SmartImage(
                        path: AppImages.icDiamond,
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        BlocBuilder<OrionBloc, OrionState>(
          buildWhen: (previous, current) => current is OrionDiamondMovedState,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmartText(
                    "Price: \$${bloc.currentPrice.toStringAsFixed(2)}",
                    style: style.selectionTitleStyle,
                  ),
                  SmartText(
                    "Carat: ${bloc.currentCarat.toStringAsFixed(2)} ct",
                    style: style.selectionTitleStyle,
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildCutSelection(OrionStyle style, OrionBloc bloc) {
    return BlocBuilder<OrionBloc, OrionState>(
      buildWhen: (previous, current) => current is OrionDiamondMovedState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SmartText(APPStrings.cut.tr, style: style.selectionTitleStyle),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SmartText(bloc.selectedCutModel.name, style: style.selectDiamondTitleStyle),
                  SizedBox(width: 8.w),
                  SmartText(bloc.selectedCutModel.description, style: style.propertySelectionSubtitleStyle),
                ],
              ),
              SizedBox(height: 8.h),
              SmartHorizontalItemBuilder(
                itemCount: bloc.cutModelList.length,
                itemBetweenSpace: 20.w,
                itemBuilder: (context, propertiesIndex) {
                  final CutModel properties = bloc.cutModelList[propertiesIndex];
                  final bool isSelected = bloc.selectedCutModel == properties;
                  return Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SmartText(
                      properties.name,
                      style: isSelected ? style.selectedPropertyStyle : style.propertyStyle,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildClaritySelection(OrionStyle style, OrionBloc bloc) {
    return BlocBuilder<OrionBloc, OrionState>(
      buildWhen: (previous, current) => current is OrionDiamondMovedState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SmartText(APPStrings.clarity.tr, style: style.selectionTitleStyle),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SmartText(bloc.selectedClarityModel.name, style: style.selectDiamondTitleStyle),
                  SizedBox(width: 8.w),
                  SmartText(bloc.selectedClarityModel.description, style: style.propertySelectionSubtitleStyle),
                ],
              ),
              SizedBox(height: 8.h),
              SmartHorizontalItemBuilder(
                itemCount: bloc.clarityModelList.length,
                itemBetweenSpace: 20.w,
                itemBuilder: (context, propertiesIndex) {
                  final ClarityModel properties = bloc.clarityModelList[propertiesIndex];
                  final bool isSelected = bloc.selectedClarityModel == properties;
                  return Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SmartText(
                      properties.name,
                      style: isSelected ? style.selectedPropertyStyle : style.propertyStyle,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColorSelection(OrionStyle style, OrionBloc bloc) {
    return BlocBuilder<OrionBloc, OrionState>(
      buildWhen: (previous, current) => current is OrionDiamondMovedState,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SmartText(APPStrings.color.tr, style: style.selectionTitleStyle),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SmartText(bloc.selectedColorModel.name, style: style.selectDiamondTitleStyle),
                  SizedBox(width: 8.w),
                  SmartText(bloc.selectedColorModel.description, style: style.propertySelectionSubtitleStyle),
                ],
              ),
              SizedBox(height: 8.h),
              SmartHorizontalItemBuilder(
                itemCount: bloc.colorModelList.length,
                itemBetweenSpace: 20.w,
                itemBuilder: (context, propertiesIndex) {
                  final ColorModel properties = bloc.colorModelList[propertiesIndex];
                  final bool isSelected = bloc.selectedColorModel == properties;
                  return Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SmartText(
                      properties.name,
                      style: isSelected ? style.selectedPropertyStyle : style.propertyStyle,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
