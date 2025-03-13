import 'package:kgk/kgk.dart';

class SortScreen extends StatelessWidget {
  final List<SortOptions> sortData;

  const SortScreen({super.key, required this.sortData});

  @override
  Widget build(BuildContext context) {
    SortFilterBloc sortFilterBloc = BlocProvider.of<SortFilterBloc>(context);
    final SortStyle style = AppTheme.of(context).sortStyle;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(16.r),
          topEnd: Radius.circular(16.r),
        ),
      ),
      child: SmartSingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmartAppBar(
              isBack: false,
              title: APPStrings.sortBy.tr,
              titleStyle: style.titleStyle,
              appBarHeight: AppConst.defaultAppBarHeight,
              actions: [
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: const SmartImage(path: AppImages.icCross),
                ),
              ],
            ),
            ListView.builder(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
              shrinkWrap: true,
              itemCount: sortData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    sortFilterBloc.add(SelectSortDataEvent(sortData: sortData[index]));
                    context.pop(arguments: {RoutesData.sortData: sortData[index]});
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 12.h, horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: SmartText(
                            sortData[index].name?.tr,
                            style: style.itemTitleStyle,
                          ),
                        ),
                        if (sortData[index].name == sortFilterBloc.selectedSortData.name) const SmartImage(path: AppImages.icCheck),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
