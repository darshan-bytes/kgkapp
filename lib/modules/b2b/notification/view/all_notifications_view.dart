import 'package:kgk/kgk.dart';

class AllNotificationsView extends StatelessWidget {
  const AllNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).allNotificationViewStyle;
    return SmartSingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24.h, left: 17.w, right: 17.w),
            child: SmartTextField(
              hintText: APPStrings.searchNotification.tr,
              hintStyle: style.searchHintStyle,
              maxLines: 1,
              prefixIcon: Container(
                alignment: Alignment.center,
                width: 16.w,
                child: SmartImage(
                  path: AppImages.icSearch,
                  height: 16.w,
                  width: 16.w,
                ),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            separatorBuilder: (context, index) {
              return Divider(
                height: 1.h,
              );
            },
            itemBuilder: (context, index) {
              return _notificationItem(context);
            },
          )
        ],
      ),
    );
  }

  Widget _notificationItem(BuildContext context) {
    final style = AppTheme.of(context).allNotificationViewStyle;
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
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
                padding: EdgeInsets.all(8.w),
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
