import 'package:kgk/kgk.dart';

class WishlistFilterScreen extends StatelessWidget {
  final Function onApply;

  const WishlistFilterScreen({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    final FilterStyle style = AppTheme.of(context).filterStyle;
    final WishlistSortFilterBloc filterBloc = BlocProvider.of<WishlistSortFilterBloc>(context);
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: SmartAppBar(
        isBack: false,
        title: APPStrings.filters.tr,
        actions: [
          SmartText(
            APPStrings.clearAll.tr,
            onTap: () {
              filterBloc.add(ClearAllWishlistFilterDataEvent(
                context: context,
                onApply: (List<FilterData> data) {
                  onApply(data);
                },
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
                child: BlocBuilder<WishlistSortFilterBloc, WishlistSortFilterState>(
                  buildWhen: (previous, current) => current is WishlistFilterDataSelectedState,
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
                      filterBloc.add(ApplyWishlistFilterDataEvent());
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

  Widget _buildFilterList(BuildContext context, WishlistSortFilterBloc filterBloc, FilterStyle style) {
    return Container(
      color: style.subFilterBackgroundColor,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filterBloc.filterData.length,
        itemBuilder: (context, index) {
          return BlocBuilder<WishlistSortFilterBloc, WishlistSortFilterState>(
            buildWhen: (previous, current) => current is WishlistFilterDataSelectedState,
            builder: (context, state) {
              final filterData = filterBloc.filterData[index];
              bool isSelected = filterBloc.selectedFilterData == filterData;
              return InkWell(
                onTap: () {
                  filterBloc.add(SelectWishlistFilterDataEvent(filterData: filterData, context: context));
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

  Widget _buildSubFilterList(BuildContext context, WishlistSortFilterBloc filterBloc, FilterStyle style) {
    return BlocBuilder<WishlistSortFilterBloc, WishlistSortFilterState>(
      buildWhen: (previous, current) =>
          current is WishlistFilterDataSelectedState ||
          current is WishlistSelectSecondaryFilterDataState ||
          current is WishlistSortAndFilterPriceRangeChangedState,
      builder: (context, state) {
        if (filterBloc.selectedFilterData?.filterType != FilterType.range && filterBloc.secondaryFilterDataDisplay.isEmpty) {
          return const NoDataFoundWidget();
        }
        switch (filterBloc.selectedFilterData?.filterType) {
          case FilterType.range:
            return SizedBox();
          case FilterType.checkbox:
            return _buildOptionList(filterBloc, style);
          case FilterType.undefined:
          default:
            return const NoDataFoundWidget(text: "This type is not yet added");
        }
      },
    );
  }

  Widget _buildOptionList(WishlistSortFilterBloc filterBloc, FilterStyle style) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filterBloc.secondaryFilterDataDisplay.length,
      itemBuilder: (context, index) {
        return BlocBuilder<WishlistSortFilterBloc, WishlistSortFilterState>(
          buildWhen: (previous, current) => current is WishlistSelectSecondaryFilterDataState,
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
                child: SmartCheckbox(
                    value: secondaryFilterData.isSelected,
                    label: secondaryFilterData.name,
                    labelStyle: secondaryFilterData.isSelected ? style.selectedItemTitleStyle : style.itemTitleStyle,
                    spaceBetweenLabelAndCheckbox: 8.w,
                    onChanged: (value) {
                      handleOnChange(filterBloc, secondaryFilterData);
                    }),
              ),
            );
          },
        );
      },
    );
  }

  void handleOnChange(WishlistSortFilterBloc filterBloc, SecondaryFilterData secondaryFilterData) {
    filterBloc.add(SelectWishlistSecondaryFilterDataEvent(secondaryFilterData: secondaryFilterData));
  }
}
