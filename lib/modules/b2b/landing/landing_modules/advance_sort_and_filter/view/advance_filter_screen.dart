import 'package:kgk/kgk.dart';

class AdvanceFilterScreen extends StatelessWidget {
  final Function onApply;

  const AdvanceFilterScreen({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    final FilterStyle style = AppTheme.of(context).filterStyle;
    final AdvanceSortFilterBloc filterBloc = BlocProvider.of<AdvanceSortFilterBloc>(context);
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(
        isBack: false,
        title: APPStrings.filters.tr,
        actions: [
          SmartText(
            APPStrings.clearAll.tr,
            onTap: () {
              filterBloc.add(
                ClearAllAdvanceFilterDataEvent(
                  context: context,
                  onApply: (List<FilterData> data) {
                    onApply(data);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 1, child: _buildFilterList(context, filterBloc, style)),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsetsDirectional.all(16.w),
                color: style.backgroundColor,
                child: BlocBuilder<AdvanceSortFilterBloc, AdvanceSortFilterState>(
                  buildWhen: (previous, current) => current is AdvanceFilterDataSelectedState,
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
                        Expanded(child: _buildSubFilterList(context, filterBloc, style)),
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
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(color: style.backgroundColor, border: BorderDirectional(top: BorderSide(color: style.itemBorderColor))),
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
                      filterBloc.add(ApplyAdvanceFilterDataEvent());
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

  Widget _buildFilterList(BuildContext context, AdvanceSortFilterBloc filterBloc, FilterStyle style) {
    return Container(
      color: style.subFilterBackgroundColor,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filterBloc.filterData.length,
        itemBuilder: (context, index) {
          return BlocBuilder<AdvanceSortFilterBloc, AdvanceSortFilterState>(
            buildWhen: (previous, current) => current is AdvanceFilterDataSelectedState,
            builder: (context, state) {
              final filterData = filterBloc.filterData[index];
              bool isSelected = filterBloc.selectedFilterData == filterData;
              return InkWell(
                onTap: () {
                  filterBloc.add(SelectAdvanceFilterDataEvent(filterData: filterData, context: context));
                },
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: isSelected ? style.selectedBackgroundColor : null,
                    border: BorderDirectional(bottom: BorderSide(color: style.itemBorderColor)),
                  ),
                  child: SmartText(filterData.name, style: isSelected ? style.selectedTitleStyle : style.titleStyle),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSubFilterList(BuildContext context, AdvanceSortFilterBloc filterBloc, FilterStyle style) {
    return BlocBuilder<AdvanceSortFilterBloc, AdvanceSortFilterState>(
      buildWhen:
          (previous, current) =>
              current is AdvanceFilterDataSelectedState ||
              current is AdvanceSelectSecondaryFilterDataState ||
              current is AdvanceSortAndFilterPriceRangeChangedState ||
              current is SearchAdvanceFilterDataState,
      builder: (context, state) {
        switch (filterBloc.selectedFilterData?.filterType) {
          case FilterType.range:
            return SizedBox();
          case FilterType.checkbox:
            if (filterBloc.secondaryFilterDataDisplay.isNotNullNorEmpty) {
              return _buildOptionList(filterBloc, style);
            } else {
              return NoDataFoundWidget();
            }
          case FilterType.dateRange:
            return _buildDateRangeSlide(filterBloc, style, context);
          case FilterType.date:
            return _buildDatePicker(filterBloc, style, context);

          case FilterType.undefined:
          default:
            return NoDataFoundWidget(text: APPStrings.thisTypeIsNotYetAdded.tr);
        }
      },
    );
  }

  Widget _buildOptionList(AdvanceSortFilterBloc filterBloc, FilterStyle style) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filterBloc.secondaryFilterDataDisplay.length,
      itemBuilder: (context, index) {
        return BlocBuilder<AdvanceSortFilterBloc, AdvanceSortFilterState>(
          buildWhen: (previous, current) => current is AdvanceSelectSecondaryFilterDataState,
          builder: (context, state) {
            final secondaryFilterData = filterBloc.secondaryFilterDataDisplay[index];
            return InkWell(
              onTap: () {
                handleOnChange(filterBloc, secondaryFilterData);
              },
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(vertical: 12.w, horizontal: 16.h),
                decoration: BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: style.itemBorderColor))),
                child: SmartCheckbox(
                  value: secondaryFilterData.isSelected,
                  label: secondaryFilterData.name,
                  labelStyle: secondaryFilterData.isSelected ? style.selectedItemTitleStyle : style.itemTitleStyle,
                  spaceBetweenLabelAndCheckbox: 8.w,
                  onChanged: (value) {
                    handleOnChange(filterBloc, secondaryFilterData);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void handleOnChange(AdvanceSortFilterBloc filterBloc, SecondaryFilterData secondaryFilterData) {
    filterBloc.add(SelectAdvanceSecondaryFilterDataEvent(secondaryFilterData: secondaryFilterData));
  }

  Widget _buildDateRangeSlide(AdvanceSortFilterBloc filterBloc, FilterStyle style, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await showDateRangePicker(
              context: context,
              initialDateRange: filterBloc.selectedFilterData?.dateRange,
              firstDate: DateTime(1900),
              lastDate: DateTime(2200),
            ).then((value) {
              if (value != null) {
                filterBloc.add(ChangeAdvanceDateRangeEvent(dateRange: value));
              }
            });
          },
          child: SmartTextField(
            suffixIcon: Icon(Icons.calendar_month),
            isEnabled: false,
            contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
            hintText: filterBloc.selectedFilterData?.name,
            disabledBorderColor: style.itemBorderColor,
            controller: TextEditingController(text: filterBloc.selectedFilterData?.dateRange?.formatDateRange()),
            onTap: () async {},
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(AdvanceSortFilterBloc filterBloc, FilterStyle style, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await showDatePicker(
              context: context,
              initialDate: filterBloc.selectedFilterData?.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2200),
            ).then((value) {
              if (value != null) {
                filterBloc.add(ChangeAdvanceDateEvent(date: value));
              }
            });
          },
          child: SmartTextField(
            suffixIcon: Icon(Icons.calendar_month),
            isEnabled: false,
            contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
            hintText: filterBloc.selectedFilterData?.name,
            disabledBorderColor: style.itemBorderColor,
            controller: TextEditingController(
              text: filterBloc.selectedFilterData?.date?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
