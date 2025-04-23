import 'package:kgk/kgk.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MessagesBloc bloc = BlocProvider.of<MessagesBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SmartAppBar(title: APPStrings.messages.tr),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 17.0.h),
            Expanded(
              child: SmartTabBar(
                length: bloc.tabs.length,
                onTabInitialized: (tabController) {
                  // Here TabController is initialized
                  bloc.tabController = tabController;
                },
                padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w),
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                labelPadding: EdgeInsetsDirectional.symmetric(horizontal: 20.5.w),
                onTapTab: (int index) {
                  bloc.add(MessagesTabChangeEvent(index: index));
                },
                tabs: bloc.tabs,
                tabBarView: bloc.buildTabBarView(bloc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
