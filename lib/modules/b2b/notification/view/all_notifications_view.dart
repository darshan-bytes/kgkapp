import 'package:kgk/kgk.dart';

class AllNotificationsView extends StatelessWidget {
  const AllNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).allNotificationViewStyle;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 17, right: 17),
            child: SmartTextField(
              hintText: APPStrings.searchNotification.tr,
              hintStyle: style.searchHintStyle,
              maxLines: 1,
              prefixIcon: Container(
                alignment: Alignment.center,
                width: 16,
                child: SvgPicture.asset(AppImages.icSearch, height: 16, width: 16, fit: BoxFit.fitWidth,),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            padding: const EdgeInsets.symmetric(horizontal: 17),
            separatorBuilder: (context, index) {
              return const Divider(height: 1,);
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
      padding: const EdgeInsets.only(top: 24),
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
                height: 8, width: 8,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: style.dotColor,
                  shape: BoxShape.circle
                ),
              ),
            ],
          ),
          const SizedBox(height: 4,),
          SmartText(
            'Ralph can perform all the action associated with role “system admin”',
            style: style.descStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12,),
          SmartText(
            '09:30 PM',
            style: style.timeLabelStyle,
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}