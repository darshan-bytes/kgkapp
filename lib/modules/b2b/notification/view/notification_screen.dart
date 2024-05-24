import 'package:kgk/kgk.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with TickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).notificationScreenStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.notification.tr,
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller,
            unselectedLabelColor: style.unselectedTabColor,
            labelColor: style.selectedTabColor,
            labelStyle: style.tabTitleStyle,
            indicatorWeight: 4,
            unselectedLabelStyle: style.tabTitleStyle,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: const EdgeInsets.only(left: -30, right: -30),
            tabs: [
              Tab(text: APPStrings.allNotification.tr),
              Tab(text: APPStrings.settings.tr),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [AllNotificationsView(), SettingsView()],
            ),
          )
        ],
      ),
    );
  }
}
