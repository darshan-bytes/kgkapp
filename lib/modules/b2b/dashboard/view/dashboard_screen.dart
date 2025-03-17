import 'package:kgk/kgk.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardBloc dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    final DashboardStyle style = AppTheme.of(context).dashboardStyle;
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.dashboard.tr),
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: (previous, current) => current is DashboardLoadedState,
          builder: (context, state) {
            return SmartSingleChildScrollView(
              onRefresh: () async {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.all(16.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildDateRangeDropDown(context, dashboardBloc),
                        SizedBox(height: 16.h),
                        SmartText(
                          APPStrings.comparedToX.tr.interpolate(['Jan 1 - Dec 31, 2022']),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  _buildStatisticsList(dashboardBloc, style),
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDateRangeDropDown(BuildContext context, DashboardBloc dashboardBloc) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => current is DashboardDateRangeChangeState,
      builder: (context, state) {
        return SmartDropDown<DashboardDateRangeDataModel>(
          items: dashboardBloc.dateRangeList
              .map((e) => SmartDropDownItem<DashboardDateRangeDataModel>(value: e, title: e.title ?? ''))
              .toList(),
          selectedItem: dashboardBloc.selectedDateRange,
          onChanged: (value) {
            if (value == null) return;
            dashboardBloc.add(DashboardDateRangeChangeEvent(value));
          },
        );
      },
    );
  }

  Widget _buildStatisticsList(DashboardBloc dashboardBloc, DashboardStyle style) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dashboardBloc.statisticsList.length,
      itemBuilder: (context, index) {
        final DashboardStatisticsDataModel item = dashboardBloc.statisticsList[index];
        return Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SmartText(
                    item.title,
                    style: style.titleStyle,
                  ),
                  const Spacer(),
                  SmartText(
                    item.value,
                    style: item.isNegative ? style.negativeAmountStyle : style.positiveAmountStyle,
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  SmartText(
                    item.subTitle,
                    style: style.subTitleStyle,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SmartImage(path: item.isNegative ? AppImages.icDown : AppImages.icUp, width: 16.w, height: 16.h),
                      SizedBox(width: 4.w),
                      SmartText(item.variation, style: style.subTitleStyle),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
