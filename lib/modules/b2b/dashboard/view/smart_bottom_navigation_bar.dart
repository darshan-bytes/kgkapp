import 'package:kgk/kgk.dart';

/// `SmartBottomNavigationBar` is a stateless widget that builds a custom bottom navigation bar.
/// It takes a boolean `isShowSplashEffect` as a parameter to control the splash effect.
class SmartBottomNavigationBar extends StatelessWidget {
  final bool isShowSplashEffect;

  const SmartBottomNavigationBar({super.key, this.isShowSplashEffect = false});

  @override
  Widget build(BuildContext context) {
    final DashboardBloc dashboardBloc = context.read<DashboardBloc>();
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
      child: BlocBuilder<DashboardBloc, DashboardState>(
        buildWhen: (previous, current) {
          return current is DashboardChangeTabState;
        },
        builder: (context, state) {
          return BottomNavigationBar(
            elevation: 0,
            backgroundColor: style.backgroundColor,
            currentIndex: dashboardBloc.currentIndex,
            onTap: (int index) {
              dashboardBloc.add(DashboardChangeTabEvent(index));
            },
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: style.labelStyle,
            unselectedLabelStyle: style.unselectedLabelStyle,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.icHome),
                activeIcon: SvgPicture.asset(AppImages.icHomeActive),
                label: APPStrings.home.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.icCategories),
                activeIcon: SvgPicture.asset(AppImages.icCategoriesActive),
                label: APPStrings.categories.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.icShoppingBag),
                activeIcon: SvgPicture.asset(AppImages.icShoppingBagActive),
                label: APPStrings.myBag.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.icSupport),
                activeIcon: SvgPicture.asset(AppImages.icSupportActive),
                label: APPStrings.support.tr,
              ),
              //TODO: Replace the image URL with the actual image URL
              BottomNavigationBarItem(
                icon: Container(
                    height: 24.w,
                    width: 24.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: SmartImage(
                      path: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                      imageBorderRadius: BorderRadius.circular(12.r),
                    )),
                activeIcon: Container(
                    height: 24.w,
                    width: 24.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: style.indicatorColor, width: 1.w),
                    ),
                    child: SmartImage(
                      path: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                      imageBorderRadius: BorderRadius.circular(12.r),
                    )),
                label: APPStrings.profile.tr,
              ),
            ],
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
}
