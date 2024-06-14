import 'package:kgk/kgk.dart';

class SmartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingImage;
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

  SmartAppBar({
    super.key,
    this.title,
    this.leadingImage,
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
    final CustomAppBarStyle style = AppTheme.of(context).appBarStyle;
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: isCenter,
      backgroundColor: backgroundColor ?? style.backgroundColor,
      surfaceTintColor: backgroundColor ?? style.backgroundColor,
      toolbarHeight: appBarHeight,
      elevation: 0,
      titleSpacing: 0,
      title: _buildTitle(style, context),
      actions: _buildActions(),
      shape: isBorder ? Border(bottom: BorderSide(color: style.borderColor)) : null,
    );
  }

  Widget leadingIcon(BuildContext context, CustomAppBarStyle style) {
    if (!isBack && leadingImage.isNotNullNorEmpty) {
      return SmartImage(
        path: leadingImage ?? '',
        height: 40.w,
        width: 40.w,
      );
    } else if (isBack) {
      return GestureDetector(
        onTap: () {
          if (onBack != null) {
            onBack!();
          } else {
            context.pop();
          }
        },
        child: Container(
          padding: EdgeInsets.only(left: 17.w),
          height: 72.w,
          width: 41.w,
          color: style.transparentColor,
          child: Center(
            child: SmartImage(
              path: AppImages.icBack,
              height: 24.w,
              width: 24.w,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildTitle(CustomAppBarStyle style, context) {
    return Row(
      mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        if (!isBack) SizedBox(width: 17.w),
        leadingIcon(context, style),
        if (isBack || leadingImage.isNotNullNorEmpty) SizedBox(width: 6.w),
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
      actions.add(_buildIconButton(onScan!, AppImages.icScanner, size: 24));
    }
    if (onFilter != null) {
      actions.add(_buildIconButton(onFilter!, AppImages.icSearch, size: 24));
    }
    if (onFavorite != null) {
      actions.add(_buildIconButton(onFavorite!, AppImages.icHeart, size: 24));
    }
    if (onNotification != null) {
      actions.add(_buildIconButton(onNotification!, AppImages.icNotification));
    }
    if (this.actions != null) {
      actions.add(SizedBox(width: 17.w));
    }
    actions.addAll(this.actions ?? []);
    actions.add(SizedBox(width: optionalEndSpacing ?? 17.w));
    return actions;
  }

  Widget _buildIconButton(VoidCallback onTap, String assetPath, {double? size}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: size?.w,
          width: size?.w,
          child: Center(
            child: SmartImage(
              path: assetPath,
              height: size?.w,
              width: size?.w,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? height);
}
