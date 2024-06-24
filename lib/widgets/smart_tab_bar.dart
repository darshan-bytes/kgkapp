import 'package:kgk/kgk.dart';

class SmartTabBar extends StatefulWidget {
  final int length;
  final List<Widget> tabs;
  final List<Widget> tabBarView;
  final Function(TabController)? onTabInitialized;
  final bool isScrollable;
  final Function(int)? onTapTab;
  final ScrollPhysics physics;
  final Widget? tabBetweenView;
  final Color? tabBarColor;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final EdgeInsetsGeometry? labelPadding;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final TabBarIndicatorSize? indicatorSize;
  final double? indicatorHeight;
  final Color? dividerColor;
  final TabAlignment? tabAlignment;
  final EdgeInsetsGeometry? padding;

  const SmartTabBar({
    super.key,
    required this.length,
    required this.tabs,
    required this.tabBarView,
    this.onTabInitialized,
    this.isScrollable = false,
    this.onTapTab,
    this.physics = const NeverScrollableScrollPhysics(),
    this.tabBetweenView,
    this.tabBarColor,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelPadding,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorSize,
    this.indicatorHeight,
    this.dividerColor,
    this.tabAlignment,
    this.padding,
  });

  @override
  State<SmartTabBar> createState() => _SmartTabBarState();
}

class _SmartTabBarState extends State<SmartTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.length, vsync: this);
    if (widget.onTabInitialized != null) {
      widget.onTabInitialized!(_tabController);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SmartTabBarStyle style = AppTheme.of(context).smartTabBarStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: widget.tabBarColor,
          padding: widget.padding ?? EdgeInsets.zero,
          child: TabBar(
              physics: widget.physics,
              isScrollable: widget.isScrollable,
              tabAlignment: widget.tabAlignment,
              onTap: widget.onTapTab,
              controller: _tabController,
              tabs: widget.tabs,
              dividerHeight: 1.h,
              dividerColor: widget.dividerColor ?? style.tabDividerColor,
              indicatorColor: widget.indicatorColor ?? style.primaryColor,
              labelColor: widget.labelColor ?? style.labelColor,
              unselectedLabelColor: widget.unselectedLabelColor ?? style.unselectedLabelColor,
              labelPadding: widget.labelPadding,
              labelStyle: style.selectedTabTextStyle.merge(widget.labelStyle),
              unselectedLabelStyle: style.unselectedTabTextStyle.merge(widget.unselectedLabelStyle),
              indicatorSize: widget.indicatorSize ?? TabBarIndicatorSize.tab,
              indicator: UnderlineTabIndicator(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10.0.r), topLeft: Radius.circular(10.0.r)),
                borderSide: BorderSide(width: widget.indicatorHeight ?? 3.0.h, color: widget.indicatorColor ?? style.primaryColor),
              )),
        ),
        if (widget.tabBetweenView != null) widget.tabBetweenView!,
        Expanded(
            child: TabBarView(
          physics: widget.physics,
          controller: _tabController,
          children: widget.tabBarView,
        )),
      ],
    );
  }
}
