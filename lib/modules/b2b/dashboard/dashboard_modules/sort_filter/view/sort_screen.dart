import 'package:kgk/kgk.dart';

class SortScreen extends StatelessWidget {
  const SortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SortFilterBloc sortFilterBloc = BlocProvider.of<SortFilterBloc>(context);
    final SortStyle style = AppTheme.of(context).sortStyle;
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAppBar(
              isBack: false,
              title: APPStrings.sortBy.tr,
              titleStyle: style.titleStyle,
              appBarHeight: kToolbarHeight,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const SmartImage(path: AppImages.icCross),
                ),
              ],
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shrinkWrap: true,
              itemCount: sortFilterBloc.sortData.length,
              itemBuilder: (context, index) {
                final sortData = sortFilterBloc.sortData[index];
                return InkWell(
                  onTap: () {
                    sortFilterBloc.add(SelectSortDataEvent(sortData: sortData));
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: SmartText(
                            sortData.name,
                            style: style.itemTitleStyle,
                          ),
                        ),
                        if (sortFilterBloc.selectedSortData.code == sortData.code) const SmartImage(path: AppImages.icCheck),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
