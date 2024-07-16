import 'package:kgk/kgk.dart';

/// `SmartBottomNavigationBar` is a stateless widget that builds a custom bottom navigation bar.
/// It takes a boolean `isShowSplashEffect` as a parameter to control the splash effect.
class SmartBottomNavigationBar extends StatelessWidget {
  final bool isShowSplashEffect;

  const SmartBottomNavigationBar({super.key, this.isShowSplashEffect = false});

  @override
  Widget build(BuildContext context) {
    final LandingBloc landingBloc = BlocProvider.of<LandingBloc>(context);
    final TabBarStyle style = AppTheme.of(context).tabBarStyle;
    Widget child = Container(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: Border(top: BorderSide(color: style.borderColor, width: 1.w)),
        boxShadow: [
          BoxShadow(
            color: style.boxShadowColor,
            blurRadius: 16.r,
            spreadRadius: 0.r,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BlocBuilder<LandingBloc, LandingState>(
        bloc: landingBloc,
        buildWhen: (previous, current) => current is LandingChangeTabState || current is LandingLoadedState,
        builder: (context, state) {
          return BottomNavigationBar(
            elevation: 0,
            backgroundColor: style.backgroundColor,
            currentIndex: landingBloc.currentIndex,
            onTap: (int index) {
              landingBloc.add(LandingChangeTabEvent(index, context: context));
            },
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: style.labelStyle,
            unselectedLabelStyle: style.unselectedLabelStyle,
            selectedItemColor: style.labelStyle.color,
            items: landingBloc.bottomNavigationBarDataModel.map((BottomNavigationBarDataModel model) {
              if (model.isProfile) {
                return BottomNavigationBarItem(
                  icon: _buildProfileIcon(style, false, model.icon),
                  activeIcon: _buildProfileIcon(style, true, model.icon),
                  label: model.label.tr,
                );
              }
              return BottomNavigationBarItem(
                icon: _getBottomNavigationBarIcon(model),
                activeIcon: SmartImage(path: model.activeIcon),
                label: model.label.tr,
              );
            }).toList(),
          );
        },
      ),
    );

    /// If `isShowSplashEffect` is `true`, then the splash effect is shown. Otherwise, the splash effect is disabled.
    /// By default, the splash effect is disabled. also the BottomNavigationBar has default splash effect.
    return isShowSplashEffect
        ? child
        : Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: child);
  }

  Widget _buildProfileIcon(TabBarStyle style, bool isActive, String iconPath) {
    return SmartImage(
      path: iconPath,
      imageBorderRadius: BorderRadius.circular(50.r),
      border: isActive ? Border.all(color: style.indicatorColor, width: 1.w) : null,
      height: 24.w,
      width: 24.w,
    );
  }

  Widget _getBottomNavigationBarIcon(BottomNavigationBarDataModel model) {
    Widget item = SmartImage(path: model.icon);
    if (model.notificationCount > 0) {
      item = Badge.count(
        count: model.notificationCount,
        child: item,
      );
    }
    return item;
  }
}
