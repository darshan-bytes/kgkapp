
import 'package:kgk/kgk.dart';

class FilterScreen extends StatelessWidget {
  final Function onApply;

  const FilterScreen({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    final FilterStyle style = AppTheme.of(context).filterStyle;
    final SortFilterBloc filterBloc = BlocProvider.of<SortFilterBloc>(context);
    return Scaffold(
      backgroundColor: style.subFilterBackgroundColor,
      appBar: SmartAppBar(
        isBack: false,
        title: APPStrings.filters.tr,
        actions: [
          SmartText(
            APPStrings.clearAll.tr,
            onTap: () {
              filterBloc.add(const ClearAllFilterDataEvent());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        SmartTextField.search(
                          hintText: APPStrings.searchByX.tr.interpolate([filterBloc.selectedFilterData.name?.toLowerCase()]),
                          controller: filterBloc.searchController,
                        ),
                        SizedBox(height: 4.h),
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
                      onApply();
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
                  filterBloc.add(SelectFilterDataEvent(filterData: filterData));
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
      buildWhen: (previous, current) => current is SearchFilterDataState || current is FilterDataSelectedState,
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: filterBloc.secondaryFilterDataDisplay.length,
          itemBuilder: (context, index) {
            return BlocBuilder<SortFilterBloc, SortFilterState>(
              buildWhen: (previous, current) => current is SelectSecondaryFilterDataState,
              builder: (context, state) {
                final secondaryFilterData = filterBloc.secondaryFilterDataDisplay[index];
                return InkWell(
                  onTap: () {
                    filterBloc.add(SelectSecondaryFilterDataEvent(secondaryFilterData: secondaryFilterData));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: style.itemBorderColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SmartText(
                            secondaryFilterData.name,
                            style: secondaryFilterData.isSelected ? style.selectedItemTitleStyle : style.itemTitleStyle,
                          ),
                        ),
                        if (secondaryFilterData.isSelected)
                          SmartImage(
                            path: AppImages.icCheck,
                            height: 16.w,
                            width: 16.w,
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
