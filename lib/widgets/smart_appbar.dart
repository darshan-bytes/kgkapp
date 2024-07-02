import 'package:kgk/kgk.dart';

class SmartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingImage;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? appBarHeight;
  final VoidCallback? onBack;
  final VoidCallback? onScan;
  final VoidCallback? onSearch;
  final VoidCallback? onFavorite;
  final VoidCallback? onNotification;
  final Widget? child;
  final TextStyle? titleStyle;
  final bool isCenter;
  final bool isBack;
  final bool isBorder;
  final double? optionalEndSpacing;
  final EdgeInsets? padding;
  final bool isSearchBar;
  final VoidCallback? onTapSuffixIconWithSearchBar;
  final TextEditingController? searchController;

  SmartAppBar({
    super.key,
    this.title,
    this.leadingImage,
    this.actions,
    this.backgroundColor,
    this.onSearch,
    this.onScan,
    this.onFavorite,
    this.titleStyle,
    this.isCenter = false,
    this.isBack = true,
    this.isBorder = true,
    this.padding,
    this.appBarHeight,
    this.onBack,
    this.onNotification,
    this.child,
    this.optionalEndSpacing,
    this.isSearchBar = false,
    this.onTapSuffixIconWithSearchBar,
    this.searchController,
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
      toolbarHeight: appBarHeight ?? 72.h,
      elevation: 0,
      titleSpacing: 0,
      title: _buildTitle(style, context),
      actions: _buildActions(),
      shape: isBorder ? Border(bottom: BorderSide(color: isSearchBar ? style.transparentColor : style.borderColor)) : null,
    );
  }

  Widget leadingIcon(BuildContext context, CustomAppBarStyle style) {
    if (!isBack && leadingImage?.isNotEmpty == true) {
      return SmartImage(
        path: leadingImage!,
        height: 40.w,
        width: 40.w,
      );
    } else if (isBack) {
      return GestureDetector(
        onTap: onBack ?? () => context.pop(),
        child: Container(
          padding: EdgeInsets.only(left: 17.w),
          height: 72.w,
          width: 41.w,
          color: style.transparentColor,
          child: Center(
            child: SmartImage(
              path: isSearchBar ? AppImages.icArrowLeftAppbar : AppImages.icBack,
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

  Widget _buildTitle(CustomAppBarStyle style, BuildContext context) {
    if (isSearchBar) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          leadingIcon(context, style),
          SizedBox(width: 12.w),
          Expanded(
              child: SmartTextField(
            height: 40.w,
            hintText: APPStrings.search.tr,
            onTapOutside: (event) {},
            controller: searchController,
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            style: style.searchBarTextStyle,
            suffixIcon: GestureDetector(
              onTap: () {
                if (onTapSuffixIconWithSearchBar != null) {
                  onTapSuffixIconWithSearchBar!();
                }
              },
              child: FittedBox(
                child: Container(
                  margin: EdgeInsets.only(left: 4.w, top: 8.w, bottom: 8.w, right: 0.w),
                  padding: EdgeInsets.zero,
                  child: SmartImage(
                    path: AppImages.icSearchThin,
                    height: 16.w,
                    width: 16.w,
                  ),
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          )),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (!isBack) SizedBox(width: 17.w),
          leadingIcon(context, style),
          if (isBack || leadingImage?.isNotEmpty == true) SizedBox(width: 6.w),
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
  }

  List<Widget> _buildActions() {
    final List<Widget> actionsList = [];
    if (onScan != null) actionsList.add(_buildIconButton(onScan!, AppImages.icScanner, size: 24));
    if (onSearch != null) actionsList.add(_buildIconButton(onSearch!, AppImages.icSearch, size: 24));
    if (onFavorite != null) actionsList.add(_buildIconButton(onFavorite!, AppImages.icHeart, size: 24));
    if (onNotification != null) actionsList.add(_buildIconButton(onNotification!, AppImages.icNotification, size: 24));
    if (actions != null) actionsList.add(SizedBox(width: 17.w));
    actionsList.addAll(actions ?? []);
    actionsList.add(SizedBox(width: optionalEndSpacing ?? 17.w));
    return actionsList;
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
