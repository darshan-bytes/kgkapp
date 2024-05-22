import '../kgk.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? appBarHeight;
  final VoidCallback? onBack;
  final VoidCallback? onScan;
  final VoidCallback? onFilter;
  final VoidCallback? onFavorite;
  final VoidCallback? onNotification;
  final Widget? child;
  final TextStyle? titleStyle;
  final bool isCenter;
  final bool isBack;
  final bool isBorder;
  final double? optionalEndSpacing;
  final EdgeInsets? padding;

  CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.onFilter,
    this.onScan,
    this.onFavorite,
    this.titleStyle,
    this.isCenter = false,
    this.isBack = true,
    this.isBorder = true,
    this.padding,
    this.appBarHeight = 72,
    this.onBack,
    this.onNotification,
    this.child,
    this.optionalEndSpacing,
  });

  final double height = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).appBarStyle;
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: isCenter,
      backgroundColor: backgroundColor ?? style.backgroundColor,
      surfaceTintColor: backgroundColor ?? style.backgroundColor,
      toolbarHeight: appBarHeight,
      elevation: 0,
      title: _buildTitle(style, context),
      leading: leading,
      actions: _buildActions(),
      shape: isBorder ? Border(bottom: BorderSide(color: style.borderColor)) : null,
    );
  }

  Widget leadingIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onBack != null) {
          onBack!();
        } else {
          Navigator.pop(context);
        }
      },
      child: SizedBox(
        height: 24,
        width: 24,
        child: Center(
          child: SvgPicture.asset(
            AppImages.icBack,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(CustomAppBarStyle style, context) {
    return Row(
      mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        if (leading == null && isBack) leadingIcon(context),
        if (leading == null && isBack) const SizedBox(width: 6),
        if (title != null)
          Expanded(
            child: SmartText(
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
              title!,
              style: titleStyle ?? style.titleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  List<Widget> _buildActions() {
    final List<Widget> actions = [];
    if (onScan != null) {
      actions.add(_buildIconButton(onScan!, AppImages.icHeart, 24));
    }
    if (onFilter != null) {
      actions.add(_buildIconButton(onFilter!, AppImages.icSearch, 24));
    }
    if (onFavorite != null) {
      actions.add(_buildIconButton(onFavorite!, AppImages.icHeart, 24));
    }
    if (onNotification != null) {
      actions.add(_buildIconButton(onNotification!, AppImages.icNotification, 24));
    }
    if (this.actions != null) {
      actions.add(const SizedBox(width: 17));
    }
    actions.addAll(this.actions ?? []);
    actions.add(SizedBox(width: optionalEndSpacing ?? 17));
    return actions;
  }

  Widget _buildIconButton(VoidCallback onTap, String assetPath, double size) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: size,
          width: size,
          child: Center(
            child: SvgPicture.asset(
              assetPath,
              height: size,
              width: size,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? height);
}
