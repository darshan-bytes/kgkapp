import 'package:kgk/kgk.dart';

class DiamondFilterScreen extends StatelessWidget {
  final Function onApply;

  const DiamondFilterScreen({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    final FilterStyle style = AppTheme.of(context).filterStyle;
    final DiamondFilterBloc diamondFilterBloc = BlocProvider.of<DiamondFilterBloc>(context);
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(
        isBack: false,
        title: APPStrings.filters.tr,
        actions: [
          SmartText(
            APPStrings.clearAll.tr,
            onTap: () {
              diamondFilterBloc.add(const ClearAllDiamondFilterDataEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<DiamondFilterBloc, DiamondFilterState>(
        buildWhen: (previous, current) => current is DiamondFilterDataLoadedState || current is SecondaryFilterDataFetchedState,
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 134.w, child: _buildFilterList(context, diamondFilterBloc, style)),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  color: style.backgroundColor,
                  child: BlocBuilder<DiamondFilterBloc, DiamondFilterState>(
                    buildWhen: (previous, current) =>
                        current is DiamondFilterDataLoadedState ||
                        current is DiamondFilterDataSelectedState ||
                        current is SecondaryFilterDataFetchedState,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (diamondFilterBloc.isCheckbox) ...[
                            SmartTextField.search(
                              hintText:
                                  APPStrings.searchByX.tr.interpolate([diamondFilterBloc.selectedFilterData?.name?.toLowerCase() ?? '']),
                              controller: diamondFilterBloc.searchController,
                              enabledBorderRadius: 8.r,
                            ),
                            SizedBox(height: 16.h),
                          ],
                          Expanded(
                            child: _buildSubFilterList(context, diamondFilterBloc, style),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            border: Border(
              top: BorderSide(
                color: style.itemBorderColor,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: SmartButton(
                  activeBackgroundColor: style.closeButtonBackgroundColor,
                  titleStyle: style.closeButtonStyle,
                  title: APPStrings.close.tr,
                  onTap: () {
                    context.pop();
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: SmartButton(
                  title: APPStrings.apply.tr,
                  onTap: () {
                    diamondFilterBloc.add(const ApplyDiamondFilterDataEvent());
                    onApply();
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterList(BuildContext context, DiamondFilterBloc diamondFilterBloc, FilterStyle style) {
    return Container(
      color: style.subFilterBackgroundColor,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: diamondFilterBloc.filterData.length,
        itemBuilder: (context, index) {
          return BlocBuilder<DiamondFilterBloc, DiamondFilterState>(
            buildWhen: (previous, current) => current is DiamondFilterDataSelectedState,
            builder: (context, state) {
              final FilterData filterData = diamondFilterBloc.filterData[index];
              bool isSelected = diamondFilterBloc.selectedFilterData == filterData;
              bool isAdvanceFilter = filterData.isAdvanceFilter ?? false;
              return InkWell(
                onTap: isAdvanceFilter
                    ? null
                    : () {
                        diamondFilterBloc.add(SelectDiamondFilterDataEvent(context: context, filterData: filterData));
                      },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: isAdvanceFilter ? style.advancedFilterBackgroundColor : (isSelected ? style.selectedBackgroundColor : null),
                    border: Border(
                      bottom: BorderSide(
                        color: style.itemBorderColor,
                      ),
                    ),
                  ),
                  child: SmartText(
                    filterData.name,
                    style: isAdvanceFilter ? style.advancedFilterTitleStyle : (isSelected ? style.selectedTitleStyle : style.titleStyle),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSubFilterList(BuildContext context, DiamondFilterBloc diamondFilterBloc, FilterStyle style) {
    return BlocBuilder<DiamondFilterBloc, DiamondFilterState>(
      buildWhen: (previous, current) =>
          current is SearchDiamondFilterDataState ||
          current is DiamondFilterDataSelectedState ||
          current is SecondaryFilterDataFetchedState,
      builder: (context, state) {
        if (diamondFilterBloc.isLoading) {
          return const SmartCircularProgressIndicator();
        } else if (diamondFilterBloc.secondaryFilterDataDisplay.isEmpty) {
          const NoDataFoundWidget();
        }
        return diamondFilterBloc.isCheckbox ? _buildOptionList(diamondFilterBloc, style) : _buildPriceRangeSlide(diamondFilterBloc, style);
      },
    );
  }

  Widget _buildPriceRangeSlide(DiamondFilterBloc bloc, FilterStyle style) {
    return BlocBuilder<DiamondFilterBloc, DiamondFilterState>(
      buildWhen: (previous, current) => previous != current && current is FilterPriceRangeChangedState,
      builder: (context, state) {
        return SmartSfRangeSlider(
          title: APPStrings.preferredPriceRange.tr,
          titleStyle: style.selectionTitleStyle,
          values: bloc.values!,
          minMaxValues: bloc.minMaxValues,
          minPriceController: bloc.minPriceController,
          maxPriceController: bloc.maxPriceController,
          rangeSliderTrackColor: style.rangeSliderTrackColor,
          propertySelectionSubtitleStyle: style.propertySelectionSubtitleStyle,
          sliderLabelTextStyle: style.sliderLabelTextStyle,
          sliderThumbBorderColor: style.sliderThumbBorderColor,
          sliderThumbColor: style.sliderThumbColor,
          onMinControllerTapOutside: (p) => bloc.add(const FilterPriceRangeEditEvent()),
          onMinControllerEditingComplete: (p) => bloc.add(const FilterPriceRangeEditEvent()),
          onMaxControllerTapOutside: (p) => bloc.add(const FilterPriceRangeEditEvent(isMin: false)),
          onMaxControllerEditingComplete: (p) => bloc.add(const FilterPriceRangeEditEvent(isMin: false)),
          onChanged: (SfRangeValues values) => bloc.add(FilterPriceRangeChangedEvent(values)),
        );
      },
    );
  }

  Widget _buildOptionList(DiamondFilterBloc diamondFilterBloc, FilterStyle style) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: diamondFilterBloc.secondaryFilterDataDisplay.length,
      itemBuilder: (context, index) {
        return BlocBuilder<DiamondFilterBloc, DiamondFilterState>(
          buildWhen: (previous, current) => current is SelectSecondaryDiamondFilterDataState || current is SecondaryFilterDataFetchedState,
          builder: (context, state) {
            final secondaryFilterData = diamondFilterBloc.secondaryFilterDataDisplay[index];
            return InkWell(
              onTap: () {
                handleOnChange(diamondFilterBloc, secondaryFilterData);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: style.itemBorderColor),
                  ),
                ),
                child: Row(
                  children: [
                    SmartCheckbox(
                        value: secondaryFilterData.isSelected,
                        onChanged: (value) {
                          handleOnChange(diamondFilterBloc, secondaryFilterData);
                        }),
                    SizedBox(width: 8.w),
                    if (secondaryFilterData.image.isNotNullNorEmpty) ...[
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: SmartImage(
                          path: secondaryFilterData.image ?? '',
                          height: 24.w,
                          width: 24.w,
                          color: secondaryFilterData.isSelected ? style.selectedImageColor : null,
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Expanded(
                      child: SmartText(
                        secondaryFilterData.name,
                        style: secondaryFilterData.isSelected ? style.selectedItemTitleStyle : style.itemTitleStyle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// [handleOnChange] Handles the change event for a secondary filter data item.
  ///
  /// This function is called when a secondary filter data item is selected or deselected.
  /// It dispatches a `SelectSecondaryDiamondFilterDataEvent` with the selected `secondaryFilterData`.
  ///
  /// Parameters:
  /// - `diamondFilterBloc`: the bloc that manages the state of the diamond filter.
  /// - `secondaryFilterData`: the secondary filter data item that was selected or deselected.
  void handleOnChange(DiamondFilterBloc diamondFilterBloc, SecondaryFilterData secondaryFilterData) {
    diamondFilterBloc.add(SelectSecondaryDiamondFilterDataEvent(secondaryFilterData: secondaryFilterData));
  }
}
