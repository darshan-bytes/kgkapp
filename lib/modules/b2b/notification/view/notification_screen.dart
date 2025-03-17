import 'package:kgk/kgk.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).allNotificationViewStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.notification.tr,
      ),
      body: SmartSingleChildScrollView(
        onRefresh: () async {},
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 14.h),
        child: Column(
          children: [
            SmartTextField.search(
              hintText: APPStrings.searchNotification.tr,
              hintStyle: style.searchHintStyle,
              maxLines: 1,
              height: 48.w,
              contentPadding: EdgeInsetsDirectional.only(top: 4.h, start: 1.w, end: 1.w),
            ),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              height: 52.h,
              child: IntrinsicWidth(
                child: InkWell(
                  onTap: () {},
                  child: SmartText(
                    APPStrings.clearAll.tr,
                    style: style.clearAllStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1.h,
                );
              },
              itemBuilder: (context, index) {
                return _notificationItem(context, index);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _notificationItem(BuildContext context, int index) {
    final style = AppTheme.of(context).allNotificationViewStyle;
    return Padding(
      padding: EdgeInsetsDirectional.only(top: index != 0 ? 24.h : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SmartText(
                  'You added Ralph as system admin',
                  style: style.titleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                height: 8.w,
                width: 8.w,
                padding: EdgeInsetsDirectional.all(8.w),
                decoration: BoxDecoration(color: style.dotColor, shape: BoxShape.circle),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          SmartText(
            'Ralph can perform all the action associated with role “system admin”',
            style: style.descStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 12.h,
          ),
          SmartText(
            '09:30 PM',
            style: style.timeLabelStyle,
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
