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
  final EdgeInsetsGeometry? padding;
  final bool isSearchBar;
  final VoidCallback? onTapSuffixIconWithSearchBar;
  final VoidCallback? onTapSuffixIconWithImageSearch;
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
    this.onTapSuffixIconWithImageSearch,
    this.searchController,
  });

  final double height = AppBar().preferredSize.height;
  final AppBloc appBloc = AppBloc();

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
      actions: _buildActions(context),
      shape: isBorder ? BorderDirectional(bottom: BorderSide(color: isSearchBar ? style.transparentColor : style.borderColor)) : null,
    );
  }

  Widget leadingIcon(BuildContext context, CustomAppBarStyle style) {
    if (!isBack && leadingImage?.isNotEmpty == true) {
      return SmartImage(key: ValueKey(leadingImage!), path: leadingImage!, height: 40.w, width: 40.w);
    } else if (isBack) {
      return GestureDetector(
        onTap: onBack ?? () => context.pop(),
        child: Container(
          padding: EdgeInsetsDirectional.only(start: 17.w),
          height: 72.w,
          width: 41.w,
          color: style.transparentColor,
          child: Center(
            child: SmartImage(
              path: isSearchBar ? AppImages.icArrowLeftAppbar : AppImages.icBack,
              height: 24.w,
              width: 24.w,
              matchTextDirection: true,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
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
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {
                if (onTapSuffixIconWithSearchBar != null) {
                  onTapSuffixIconWithSearchBar!();
                }
                if (onTapSuffixIconWithImageSearch != null) {
                  onTapSuffixIconWithImageSearch!();
                }
              },
              suffixIcon: FittedBox(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (onTapSuffixIconWithImageSearch != null) {
                          onTapSuffixIconWithImageSearch!();
                        }
                      },
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 4.w, top: 8.w, bottom: 8.w, end: 8.w),
                        padding: EdgeInsetsDirectional.zero,
                        child: SmartImage(path: AppImages.icImgSearch, height: 16.w, width: 16.w),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (onTapSuffixIconWithSearchBar != null) {
                          onTapSuffixIconWithSearchBar!();
                        }
                      },
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 4.w, top: 8.w, bottom: 8.w, end: 10.w),
                        padding: EdgeInsetsDirectional.zero,
                        child: SmartImage(path: AppImages.icSearchThin, height: 16.w, width: 16.w),
                      ),
                    ),
                  ],
                ),
              ),
              contentPadding: EdgeInsetsDirectional.symmetric(vertical: 10.h, horizontal: 16.w),
            ),
          ),
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

  List<Widget> _buildActions(BuildContext context) {
    final List<Widget> actionsList = [];
    if (onScan != null && !(StorageManager.instance.getIsSkipLogin())) {
      actionsList.add(
        _buildIconButton(
          () {
            context.pushNamed(AppRoutes.qrScannerPage);
          },
          AppImages.icScanner,
          size: 24.w,
        ),
      );
    }
    if (onSearch != null) actionsList.add(_buildIconButton(onSearch!, AppImages.icSearch, size: 24.w));
    if (onFavorite != null &&
        (StorageManager.instance.getIsSkipLogin() ||
            (Utils.getPermissionByModuleName(moduleName: ModuleKey.wishlist)?.list?.allowed == true))) {
      actionsList.add(
        _buildIconButton(
          () async {
            // First check if the user is logged in or not
            if (StorageManager().getIsSkipLogin()) {
              bool isApproved = false;
              await Utils.showLoginRequiredDialog(
                context,
                onApproved: () {
                  isApproved = true;
                },
              );
              if (!isApproved) {
                return;
              }
            }
            onFavorite!();
          },
          AppImages.icHeart,
          size: 24.w,
        ),
      );
    }
    if (onNotification != null) actionsList.add(_getNotificationIcon());
    if (actions != null) actionsList.add(SizedBox(width: 17.w));
    actionsList.addAll(actions ?? []);
    actionsList.add(SizedBox(width: optionalEndSpacing ?? (appBloc.notificationCount > 99 ? 27.w : 17.w)));
    return actionsList;
  }

  Widget _buildIconButton(VoidCallback onTap, String assetPath, {double? size}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: size?.w,
          width: size?.w,
          child: Center(child: SmartImage(path: assetPath, height: size?.w, width: size?.w, matchTextDirection: true)),
        ),
      ),
    );
  }

  Widget _getNotificationIcon() {
    Widget item = _buildIconButton(onNotification!, AppImages.icNotification, size: 24);
    if (appBloc.notificationCount > 0) {
      item = Badge.count(
        count: appBloc.notificationCount,
        // alignment: Utils.isRtl ? AlignmentDirectional.topStart : AlignmentDirectional.topEnd,
        child: item,
      );
    }
    return item;
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? height);
}
