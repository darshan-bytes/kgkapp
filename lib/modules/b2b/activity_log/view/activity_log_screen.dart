import 'package:kgk/kgk.dart';

class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).activityLogStyle;
    final ActivityLogBloc bloc = BlocProvider.of<ActivityLogBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.activityLog.tr),
      body: SafeArea(
        child: SmartSingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              SmartText(APPStrings.exploreChronologicalRecordYourUserActivities.tr, style: style.storeMessageStyle),
              SizedBox(height: 24.h),
              SmartTextField(
                controller: bloc.customerController,
                labelText: APPStrings.customer.tr,
                labelStyle: style.textFieldStyle,
                onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 24.h),
              SmartTextField(
                controller: bloc.moduleController,
                labelText: APPStrings.module.tr,
                labelStyle: style.textFieldStyle,
                onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 24.h),
              SmartTextField(
                controller: bloc.dateRangeController,
                labelText: APPStrings.dateRange.tr,
                labelStyle: style.textFieldStyle,
                onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 32.h),
              SmartButton(onTap: () {}, title: APPStrings.search.tr),
              SizedBox(height: 40.h),
              BlocBuilder<ActivityLogBloc, ActivityLogState>(
                buildWhen: (previous, current) => current is ActivityLogLoadedState,
                builder: (context, state) {
                  return _buildActivityList(bloc, style);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityList(ActivityLogBloc bloc, ActivityLogStyle style) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bloc.activityLogList.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 32.h);
      },
      itemBuilder: (context, index) {
        final ActivityLogModel activityLogModel = bloc.activityLogList[index];
        return _activityListItem(activityLogModel, style);
      },
    );
  }

  Widget _activityListItem(ActivityLogModel activityLog, ActivityLogStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 10.w, horizontal: 24.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.w), border: Border.all(color: style.borderColor)),
          child: SmartText(activityLog.logDate, style: style.titleStyle),
        ),
        SizedBox(height: 24.h),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.w)), color: style.listViewBackgroundColor),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Container(margin: EdgeInsetsDirectional.symmetric(vertical: 16.w), height: 1.h, color: style.dividerColor);
            },
            padding: EdgeInsetsDirectional.all(16.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activityLog.activities?.length ?? 0,
            itemBuilder: (context, index) {
              final ActivityModel? activity = activityLog.activities?[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [SmartText(activity?.time, style: style.subTitleStyle), SmartText(activity?.activity, style: style.subTextStyle)],
              );
            },
          ),
        ),
      ],
    );
  }
}
