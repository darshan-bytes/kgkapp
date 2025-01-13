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
    final DiamondListingStyle diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return BlocBuilder<OrionBloc, OrionState>(
      buildWhen: (previous, current) => previous != current && current is OrionLoadedState,
      builder: (context, state) {
        if (state is OrionLoadedState) {
          return SmartSingleChildScrollView(
            controller: bloc.paginationScrollController.controller,
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDiamondShapeList(bloc, style),
                _buildPriceRangeSlide(bloc, style),
                Divider(height: 80.h),
                if (bloc.chartData.isNotEmpty) ...[
                  _buildSelectDiamondChart(context, bloc, style),
                  SizedBox(height: 40.h),
                  _buildCutSelection(style, bloc),
                  _buildClaritySelection(style, bloc),
                  _buildColorSelection(style, bloc),
                ] else
                  NoDataFoundWidget(),
                BlocBuilder<OrionBloc, OrionState>(
                  builder: (context, state) {
                    if (state is OrionProductReloadState) {
                      return const SizedBox.shrink();
                    } else {
                      return _buildProductList(diamondListingStyle, bloc);
                    }
                  },
                ),
              ],
            ),
          );
        }
        return const SmartCircularProgressIndicator();
      },
    );
  }

  Widget _buildProductList(DiamondListingStyle style, OrionBloc orionBloc) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: BlocBuilder<OrionBloc, OrionState>(
        buildWhen: (previous, current) =>
            current is OrionDiamondListLoadedState ||
            current is OrionProductLoadedState ||
            current is OrionChangeListingTypeState ||
            current is OrionListLoadingMoreState ||
            current is OrionListLoadedMoreState,
        builder: (context, state) {
          if (orionBloc.productList.isEmpty &&
              (state is StoneDiamondListLoadedState || state is StoneProductLoadedState || state is StoneChangeListingTypeState)) {
            return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
          } else {
            if (orionBloc.isGrid) {
              return Column(
                children: [
                  if (orionBloc.productList.isNotEmpty) ...[
                    SizedBox(height: 24.h),
                    _buildProductFilterCount(style, orionBloc),
                    SizedBox(height: 24.h),
                  ],
                  SmartGridView(
                      items: orionBloc.productList.map((ProductDetailsModel productDetails) {
                    return ProductGridItem(
                      productDetails: productDetails,
                      isCrtAndGramVisible: false,
                      onTap: () {
                        context.pushNamed(AppRoutes.productDetailsPage, arguments: {
                          RoutesData.isPageFor: ScreenIdentifier.productForDiamonds,
                          RoutesData.productId: productDetails.productId
                        });
                      },
                      onEyeTap: () {},
                      isFavourite: productDetails.isFavourite,
                      onFavTap: () {},
                    );
                  }).toList()),
                  if (state is OrionListLoadingMoreState) const SmartCircularProgressIndicator(),
                  SizedBox(height: 17.h)
                ],
              );
            } else {
              return Column(
                children: [
                  if (orionBloc.productList.isNotEmpty) ...[
                    SizedBox(height: 24.h),
                    _buildProductFilterCount(style, orionBloc),
                    SizedBox(height: 24.h),
                  ],
                  //Merged
                  ListView.separated(
                    itemCount: orionBloc.productList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = orionBloc.productList[index];

                      /// Attributes list for stone info
                      List<String> attributes = [
                        product.color,
                        product.clarity,
                        product.cut,
                      ].where((attr) => attr != null).map((attr) => attr!).toList();

                      return ProductInfoItem(
                        isFromBag: false,
                        onTap360View: () => printWrapped("onTap360View"),
                        productFeaturesList: attributes,
                        onTapDNA: () {
                          context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                            RoutesData.cmsPageData: CmsWebViewDataModel(
                              url: product.openDnaUrl,
                              title: APPStrings.dna.tr,
                            )
                          });
                        },
                        onTapCertificate: () {
                          context.pushNamed(AppRoutes.cmsWebViewPage, arguments: {
                            RoutesData.cmsPageData: CmsWebViewDataModel(
                              url: product.certificateFile,
                              title: APPStrings.certificate.tr,
                            )
                          });
                        },
                        onTapImageViewer: () => printWrapped("onTapImageViewer"),
                        onTapUSA: () => printWrapped("onTapUSA"),
                        onTapMenuButton: () {
                          Utils.showSmartModalBottomSheet(
                            context: context,
                            builder: (context) => const ProductMenuBottomSheet(),
                          );
                        },
                        isSelectedBackground: (index % 2 != 0),
                        onTap: () {
                          context.pushNamed(AppRoutes.productDetailsPage,
                              arguments: {RoutesData.isPageFor: ScreenIdentifier.productForDiamonds});
                        },
                        productDetails: ProductDetailsModel(
                          suid: product.suid,
                          productInfoClarityChat: ProductInfoClarityChat(
                            carat: "36.09",
                            commodity: "Sapphire",
                            origin: "Sri Lanka",
                            rapRate: product.rappaportPrice?.setCurrency ?? "\$35,500.00",
                            productId: product.productId,
                            productName: product.name,
                            ct: "10.04",
                            shape: product.shape,
                            colour: "H",
                            clarity: "VVS1",
                            lotNumber: product.productSku,
                            certificateNumber: "230000066395",
                            measurements: "10.18 x 8.34 x 6.14",
                            lab: product.labs,
                            cut: "Excellent",
                            polish: "Excellent",
                            symmetry: "Excellent",
                            flourish: "O",
                            tablePercentage: "50",
                            depthPercentage: "50",
                            rap: product.lsp?.setCurrency ?? "\$24,850.00",
                            discount: product.discountPercentageString,
                            perCts: "\$24,850.00",
                            amount: product.finalPrice?.setCurrency ?? "\$1,24,995.50",
                            fluorescence: product.fluorescence ?? '0',
                          ),
                          productId: product.productId,
                          diamond: "1.5 gram",
                          gram: "1.5 gram",
                          imageUrl: product.imageUrl ?? "https://i.ibb.co/swb5gVs/Round.png",
                          isForAuction: product.isForAuction,
                        ),
                        isAutoSizeText: false,
                        isDiamond: true,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 17.h),
                  ),
                  if (state is StoneListLoadingMoreState) const SmartCircularProgressIndicator(),
                  SizedBox(height: 17.h)
                ],
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle style, OrionBloc orionBloc) {
    return BlocBuilder<OrionBloc, OrionState>(
      buildWhen: (previous, current) => current is OrionChangeListingTypeState,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmartText(
                  APPStrings.showingListLengthX.tr.interpolate([
                    orionBloc.paginationScrollController.currentPage,
                    orionBloc.totalNumberOfPages,
                    orionBloc.totalFilteredRecords,
                  ]),
                  style: style.filterProductCountTextStyle),
              Row(
                children: [
                  SelectionButton(
                    width: 48.w,
                    isSelected: orionBloc.isGrid,
                    image: AppImages.icGrid,
                    imageHeight: 24.5.w,
                    imageWidth: 24.5.w,
                    selectedButtonColor: style.gridBackgroundColor,
                    selectedButtonBorderColor: style.gridBorderColor,
                    selectedButtonIconColor: style.gridIconColor,
                    unselectedButtonIconColor: style.listIconColor,
                    unselectedButtonColor: style.listBackgroundColor,
                    unselectedButtonBorderColor: style.listBorderColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                    onTap: () {
                      orionBloc.add(const OrionChangeListingTypeEvent());
                    },
                  ),
                  SelectionButton(
                    width: 48.w,
                    isSelected: !orionBloc.isGrid,
                    image: AppImages.icList,
                    imageHeight: 18.h,
                    selectedButtonColor: style.gridBackgroundColor,
                    selectedButtonBorderColor: style.gridBorderColor,
                    selectedButtonIconColor: style.gridIconColor,
                    unselectedButtonIconColor: style.listIconColor,
                    unselectedButtonColor: style.listBackgroundColor,
                    unselectedButtonBorderColor: style.listBorderColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                    onTap: () {
                      orionBloc.add(const OrionChangeListingTypeEvent());
                    },
                  ),
                ],
              )
            ],
          ),
        );
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
                bloc.add(OrionDiamondShapeChangedEvent(context, index));
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
                    SmartImage(path: value.image ?? '', height: 48.h, width: 48.w, fit: BoxFit.contain),
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
                    onChangeEnd: (SfRangeValues values) => bloc.add(OrionPriceRangeReleaseEvent(values, context)),
                    onChanged: (SfRangeValues values) => bloc.add(OrionPriceRangeChangedEvent(values, context)),
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
                          onTapOutside: (p) => bloc.add(OrionPriceRangeEditEvent(context)),
                          onEditingComplete: () => bloc.add(OrionPriceRangeEditEvent(context)),
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
                          onTapOutside: (p) => bloc.add(OrionPriceRangeEditEvent(isMin: false, context)),
                          onEditingComplete: () => bloc.add(OrionPriceRangeEditEvent(isMin: false, context)),
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
                      maximum: bloc.maximumXAxis,
                      interval: 1,
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
                      bloc.add(OrionDiamondChartTouchInteractionDownEvent(context: context, tapArgs: tapArgs));
                    },
                    onChartTouchInteractionUp: (tapArgs) {
                      bloc.add(OrionDiamondChartTouchInteractionUpEvent(context: context, tapArgs: tapArgs));
                    },
                    series: <CartesianSeries<ChartDataModel, num>>[
                      ScatterSeries<ChartDataModel, num>(
                        markerSettings: const MarkerSettings(isVisible: true),
                        onPointTap: (value) {
                          bloc.add(OrionDiamondOnPointTapEvent(context: context, index: value.pointIndex ?? 0, pointDetails: value));
                        },
                        onPointLongPress: (pointInteractionDetails) {
                          bloc.add(OrionDiamondChangePointIndexEvent(index: pointInteractionDetails.pointIndex ?? 0));
                        },
                        dataSource: bloc.chartData,
                        onRendererCreated: (ChartSeriesController controller) {
                          bloc.chartSeriesController = controller;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Future.delayed(const Duration(milliseconds: 50), () {
                              bloc.add(OrionDiamondCalculateDotPositionsEvent(context: context));
                            });
                          });
                        },
                        xValueMapper: (ChartDataModel data, _) => data.x,
                        yValueMapper: (ChartDataModel data, _) => data.y,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: bloc.dotPositions.isNotEmpty,
                    child: Positioned(
                      left: bloc.pinPosition.dx + bloc.yAxisWidth - 10,
                      top: bloc.pinPosition.dy - 26,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onPanUpdate: (value) {
                          bloc.add(OrionDiamondUpdatePinPositionEvent(dragUpdateDetails: value));
                        },
                        onPanEnd: (details) {
                          bloc.add(OrionDiamondSnapNearestPoint(context: context));
                        },
                        child: SmartImage(
                          path: AppImages.icDiamond,
                          width: 40.w,
                          height: 40.w,
                        ),
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
