import 'package:kgk/kgk.dart';

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
        border: Border(
          top: BorderSide(
            color: style.borderColor,
            width: 1,
          ),
        ),
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
              BottomNavigationBarItem(
                icon: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SmartNetworkImage(
                      url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                      imageBorderRadius: BorderRadius.circular(12),
                    )),
                activeIcon: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: style.indicatorColor, width: 1),
                    ),
                    child: SmartNetworkImage(
                      url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                      imageBorderRadius: BorderRadius.circular(12),
                    )),
                label: APPStrings.profile.tr,
              ),
            ],
          );
        },
      ),
    );

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
