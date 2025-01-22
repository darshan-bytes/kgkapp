import 'package:kgk/kgk.dart';

class FilterScreen extends StatelessWidget {
  final Function onApply;

  const FilterScreen({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    final FilterStyle style = AppTheme.of(context).filterStyle;
    final SortFilterBloc filterBloc = BlocProvider.of<SortFilterBloc>(context);
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(
        isBack: false,
        title: APPStrings.filters.tr,
        actions: [
          SmartText(
            APPStrings.clearAll.tr,
            onTap: () {
              filterBloc.add(ClearAllFilterDataEvent(
                context: context,
                onApply: onApply,
              ));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: _buildFilterList(context, filterBloc, style),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16.w),
                color: style.backgroundColor,
                child: BlocBuilder<SortFilterBloc, SortFilterState>(
                  buildWhen: (previous, current) => current is FilterDataSelectedState,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if ((filterBloc.selectedFilterData?.filterType == FilterType.checkbox)) ...[
                          SmartTextField.search(
                            hintText: APPStrings.searchByX.tr.interpolate([filterBloc.selectedFilterData?.name?.toLowerCase() ?? '']),
                            controller: filterBloc.searchController,
                            textInputAction: TextInputAction.search,
                            onTapOutside: (event) {},
                          ),
                          SizedBox(height: 4.h),
                        ],
                        Expanded(
                          child: _buildSubFilterList(context, filterBloc, style),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            border: Border(
              top: BorderSide(color: style.itemBorderColor),
            ),
          ),
          child: SafeArea(
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
                      filterBloc.add(const ApplyFilterDataEvent());
                      onApply(filterBloc.filterData);
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterList(BuildContext context, SortFilterBloc filterBloc, FilterStyle style) {
    return Container(
      color: style.subFilterBackgroundColor,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filterBloc.filterData.length,
        itemBuilder: (context, index) {
          return BlocBuilder<SortFilterBloc, SortFilterState>(
            buildWhen: (previous, current) => current is FilterDataSelectedState,
            builder: (context, state) {
              final filterData = filterBloc.filterData[index];
              bool isSelected = filterBloc.selectedFilterData == filterData;
              return InkWell(
                onTap: () {
                  filterBloc.add(SelectFilterDataEvent(filterData: filterData, context: context));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: isSelected ? style.selectedBackgroundColor : null,
                    border: Border(
                      bottom: BorderSide(
                        color: style.itemBorderColor,
                      ),
                    ),
                  ),
                  child: SmartText(
                    filterData.name,
                    style: isSelected ? style.selectedTitleStyle : style.titleStyle,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSubFilterList(BuildContext context, SortFilterBloc filterBloc, FilterStyle style) {
    return BlocBuilder<SortFilterBloc, SortFilterState>(
      buildWhen: (previous, current) =>
          current is SearchFilterDataState ||
          current is FilterDataSelectedState ||
          current is SelectSecondaryDiamondSortFilterDataState ||
          current is SelectSecondaryFilterDataState ||
          current is SortAndFilterPriceRangeChangedState,
      builder: (context, state) {
        if (filterBloc.isLoading) {
          return SmartCircularProgressIndicator();
        } else if (filterBloc.selectedFilterData?.filterType != FilterType.range && filterBloc.secondaryFilterDataDisplay.isEmpty) {
          return const NoDataFoundWidget();
        }
        switch (filterBloc.selectedFilterData?.filterType) {
          case FilterType.range:
            return _buildPriceRangeSlide(filterBloc, style);
          case FilterType.checkbox:
            return _buildOptionList(filterBloc, style);
          case FilterType.undefined:
          default:
            return NoDataFoundWidget(text: APPStrings.thisTypeIsNotYetAdded.tr);
        }
      },
    );
  }

  Widget _buildPriceRangeSlide(SortFilterBloc bloc, FilterStyle style) {
    if (bloc.selectedFilterData?.minMaxValues == null) {
      return NoDataFoundWidget(text: APPStrings.thisTypeIsNotYetAdded.tr);
    }
    return BlocBuilder<SortFilterBloc, SortFilterState>(
      buildWhen: (previous, current) => previous != current && current is SortAndFilterPriceRangeChangedState,
      builder: (context, state) {
        return SmartSfRangeSlider(
          title: APPStrings.preferredPriceRange.tr,
          titleStyle: style.selectionTitleStyle,
          values: bloc.selectedFilterData?.rangeValues ?? bloc.selectedFilterData?.minMaxValues ?? SfRangeValues(0, 100),
          minMaxValues: bloc.selectedFilterData?.minMaxValues ?? SfRangeValues(0, 100),
          minPriceController: bloc.minPriceController,
          maxPriceController: bloc.maxPriceController,
          rangeSliderTrackColor: style.rangeSliderTrackColor,
          propertySelectionSubtitleStyle: style.propertySelectionSubtitleStyle,
          sliderLabelTextStyle: style.sliderLabelTextStyle,
          sliderThumbBorderColor: style.sliderThumbBorderColor,
          sliderThumbColor: style.sliderThumbColor,
          onMinControllerTapOutside: (p) => bloc.add(const SortAndFilterPriceRangeEditEvent()),
          onMinControllerEditingComplete: (p) => bloc.add(const SortAndFilterPriceRangeEditEvent()),
          onMaxControllerTapOutside: (p) => bloc.add(const SortAndFilterPriceRangeEditEvent(isMin: false)),
          onMaxControllerEditingComplete: (p) => bloc.add(const SortAndFilterPriceRangeEditEvent(isMin: false)),
          onChanged: (SfRangeValues values) => bloc.add(SortAndFilterPriceRangeChangedEvent(values)),
        );
      },
    );
  }

  Widget _buildOptionList(SortFilterBloc filterBloc, FilterStyle style) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filterBloc.secondaryFilterDataDisplay.length,
      itemBuilder: (context, index) {
        return BlocBuilder<SortFilterBloc, SortFilterState>(
          /// buildWhen Change after data comes
          buildWhen: (previous, current) => current is SelectSecondaryFilterDataState,
          builder: (context, state) {
            final secondaryFilterData = filterBloc.secondaryFilterDataDisplay[index];
            return InkWell(
              onTap: () {
                handleOnChange(filterBloc, secondaryFilterData);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: style.itemBorderColor),
                  ),
                ),

                /// Need to check this widget
                child: Row(
                  children: [
                    SmartCheckbox(
                      value: secondaryFilterData.isSelected,
                      onChanged: (value) {
                        handleOnChange(filterBloc, secondaryFilterData);
                      },
                    ),
                    SizedBox(width: 8.w),
                    if (secondaryFilterData.image.isNotNullNorEmpty) ...[
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: SmartImage(
                          path: secondaryFilterData.image ?? '',
                          height: 24.w,
                          width: 24.w,
                          fit: BoxFit.contain,
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

  ///[handleOnChange] Handles the change event for a secondary filter data item.
  ///
  /// This function is called when a secondary filter data item is selected or deselected.
  /// It dispatches a `SelectSecondaryFilterDataEvent` with the selected `secondaryFilterData`.
  /// Parameters:
  /// - `filterBloc`: the bloc that manages the state of the filter.
  /// - `secondaryFilterData`: the secondary filter data item that was selected or deselected.
  void handleOnChange(SortFilterBloc filterBloc, SecondaryFilterData secondaryFilterData) {
    filterBloc.add(SelectSecondaryFilterDataEvent(secondaryFilterData: secondaryFilterData));
  }
}
