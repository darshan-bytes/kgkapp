import 'package:kgk/kgk.dart';

class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotificationSettingsBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.notificationSettings.tr,
      ),
      body: SmartSingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 14.h),
        child: BlocBuilder<NotificationSettingsBloc, NotificationSettingsState>(
          buildWhen: (previous, current) =>
              current is NotificationAnnouncementToggledState ||
              current is NotificationFileShareToggledState ||
              current is NotificationOrderStatusToggledState,
          builder: (context, state) {
            return Column(
              children: [
                _commonItemWidget(context, title: APPStrings.announcements.tr, desc: APPStrings.notifyMeForEveryAnnouncement.tr,
                    onSwitchChange: (val) {
                  bloc.add(NotificationAnnouncementToggledEvent(val));
                }, isEnable: bloc.isAnnouncementsEnable),
                _commonItemWidget(context, title: APPStrings.fileSharedBySalesman.tr, desc: APPStrings.shareBySalesmanDesc.tr,
                    onSwitchChange: (val) {
                  bloc.add(NotificationFileShareToggledEvent(val));
                }, isEnable: bloc.isFileShareEnable),
                _commonItemWidget(context, title: APPStrings.orderStatusUpdate.tr, desc: APPStrings.changeInOrderStatus.tr,
                    onSwitchChange: (val) {
                  bloc.add(NotificationOrderStatusToggledEvent(val));
                }, isEnable: bloc.isOrderStatusUpdateEnable),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _commonItemWidget(BuildContext context,
      {required String title, required String desc, required Function(bool) onSwitchChange, bool isEnable = true}) {
    final style = AppTheme.of(context).settingViewStyle;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartText(
                    title,
                    style: style.titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SmartText(
                    desc,
                    style: style.descStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
            SmartSwitch(
              value: isEnable,
              onSwitchChange: onSwitchChange,
              thumbColor: style.thumbColor,
              width: 40.w,
            ),
          ],
        ),
        Divider(
          height: 1.h,
          color: style.dividerColor,
        ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
