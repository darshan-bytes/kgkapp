import 'package:kgk/kgk.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenStyle style = AppTheme.of(context).profilePageScreenStyle;
    final ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: _buildAppBar(isSkipUser: bloc.isSkipUser, context: context),
      body: _getBody(style: style, context: context, bloc: bloc),
    );
  }

  PreferredSizeWidget? _buildAppBar({required bool isSkipUser, required BuildContext context}) {
    if (isSkipUser) return null;
    return SmartAppBar(
      isBack: false,
      leadingImage: "https://i.ibb.co/cyvpMrR/KGK-Group-Logo-1.png",
      onScan: () {},
      onFavorite: () {
        context.pushNamed(AppRoutes.wishListPage);
      },
      onNotification: () {
        context.pushNamed(AppRoutes.notificationPage);
      },
    );
  }

  Widget _getBody({required ProfileScreenStyle style, required BuildContext context, required ProfileBloc bloc}) {
    return SafeArea(
      child: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) => current is ProfileLoadedState,
        builder: (context, state) {
          if (state is ProfileLoadedState) {
            return SmartSingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProfileHeader(style: style, bloc: bloc, context: context),
                  Divider(color: style.dividerColor, thickness: 8.h),
                  SmartText(APPStrings.myAccount.tr, style: style.subTitleStyle, optionalPadding: EdgeInsets.only(left: 17.w, top: 16.h)),
                  _buildAccountList(style, bloc),
                  if (bloc.userType == UserType.internal) ...[
                    Divider(color: style.dividerColor, thickness: 8.h),
                    SmartText(
                      APPStrings.adminSection.tr,
                      style: style.subTitleStyle,
                      optionalPadding: EdgeInsets.only(left: 17.w, top: 16.h),
                    ),
                    _buildAdminList(style, bloc),
                  ],
                  Divider(color: style.dividerColor, thickness: 8.h),
                  _buildExpandList(style, bloc),
                  if (!bloc.isSkipUser) _buildPopupList(context, style, bloc),
                ],
              ),
            );
          }
          return SmartCircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildAccountList(ProfileScreenStyle style, ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListView.separated(
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 17.w, right: 17.w, bottom: 16.h),
          itemCount: bloc.profileActionList.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return SmartOptionTile(
              profileListModel: bloc.profileActionList[index],
            );
          },
        );
      },
    );
  }

  Widget _buildAdminList(ProfileScreenStyle style, ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListView.separated(
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 17.w, right: 17.w, bottom: 16.h),
          itemCount: bloc.profileAdminList.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return SmartOptionTile(
              leadingImageColor: style.arrowRightColor,
              profileListModel: bloc.profileAdminList[index],
            );
          },
        );
      },
    );
  }

  Widget _buildExpandList(ProfileScreenStyle style, ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        itemCount: bloc.profileCMSList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              bloc.add(ToggleProfileListEvent(index: index, context: context));
            },
            child: Container(
              color: style.transparentColor,
              padding: EdgeInsets.only(
                left: 17.w,
                top: index != 0 ? 16.h : 0,
                right: 17.w,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartImage(
                    path: bloc.profileCMSList[index].image ?? '',
                  ),
                  SizedBox(width: 12.h),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartText(
                          bloc.profileCMSList[index].title,
                          style: style.expandTitleStyle,
                        ),
                        if (bloc.profileCMSList[index].isSubListExpanded) SizedBox(height: 8.h),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          child: bloc.profileCMSList[index].isSubListExpanded
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: bloc.profileCMSList[index].profileSubList?.length ?? 0,
                                  itemBuilder: (context, childIndex) {
                                    return SmartText(
                                      bloc.profileCMSList[index].profileSubList?[childIndex].title,
                                      style: style.expandTitleStyle,
                                      onTap: bloc.profileCMSList[index].profileSubList?[childIndex].onTap != null
                                          ? () {
                                              bloc.profileCMSList[index].profileSubList?[childIndex].onTap!(context);
                                            }
                                          : null,
                                    );
                                  },
                                  separatorBuilder: (context, index) => SizedBox(height: 8.h),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  if (bloc.profileCMSList[index].profileSubList.isNotNullNorEmpty)
                    SmartImage(
                      color: style.arrowRightColor,
                      path: bloc.profileCMSList[index].isSubListExpanded ? AppImages.icArrowUp : AppImages.icArrowDown,
                    )
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildPopupList(BuildContext context, ProfileScreenStyle style, ProfileBloc bloc) {
    return Container(
      color: style.dividerColor,
      padding: EdgeInsets.symmetric(horizontal: 17.0.w),
      child: Column(
        children: [
          _buildPopupItem(
              title: APPStrings.logout.tr,
              onTap: () {
                _buildLogoutPopup(context, bloc);
              },
              image: AppImages.icLogout,
              textStyle: style.logoutTextStyle),
          const Divider(),
          _buildPopupItem(
              title: APPStrings.deleteAccount.tr,
              onTap: () {
                _buildDeletePopup(context, bloc);
              },
              image: AppImages.icDeleteAccount,
              textStyle: style.fontTextStyle),
          SizedBox(height: 10.h)
        ],
      ),
    );
  }

  Widget _buildPopupItem({required String title, required String image, required TextStyle textStyle, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 66.h,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmartImage(path: image),
            SizedBox(width: 12.h),
            SmartText(title, style: textStyle),
          ],
        ),
      ),
    );
  }

  void _buildLogoutPopup(BuildContext context, ProfileBloc bloc) {
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (context) => ConfirmationDialog(
        title: APPStrings.logoutAsk.tr,
        message: APPStrings.logoutMsg.tr,
        onApproved: () {
          bloc.add(LogoutEvent(context: context));
        },
        onDenied: () => context.pop(),
        onApprovedText: APPStrings.logout.tr,
        onDeniedText: APPStrings.cancel.tr,
      ),
    );
  }

  void _buildDeletePopup(BuildContext context, ProfileBloc bloc) {
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (context) => ConfirmationDialog(
        title: APPStrings.deleteAccountAsk.tr,
        message: APPStrings.deleteAccountDesc.tr,
        onApproved: () {
          bloc.add(DeleteProfileEvent(context: context));
        },
        onDenied: () => context.pop(),
        onApprovedText: APPStrings.delete.tr,
        onDeniedText: APPStrings.cancel.tr,
      ),
    );
  }

  Widget _buildProfileHeader({required ProfileScreenStyle style, required ProfileBloc bloc, required BuildContext context}) {
    if (bloc.isSkipUser) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: style.backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: style.primaryColor,
              child: SmartImage(path: AppImages.icUser, height: 30.h),
            ),
            SizedBox(height: 12.h),
            SmartText(APPStrings.account.tr, style: style.titleStyle),
            SizedBox(height: 8.h),
            SmartText(APPStrings.loginMsg.tr, style: style.subTextStyle, textAlign: TextAlign.center),
            SizedBox(height: 16.h),
            SmartButton(
              title: APPStrings.login.tr,
              onTap: () {
                BlocProvider.of<LandingBloc>(context).add(const LandingLogoutEvent());
                context.pushNamedAndRemoveUntil(AppRoutes.signInPage, (route) => false);
              },
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(17.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartImage(
            path: bloc.profilePickedImage != null ? bloc.profilePickedImage!.path : AppImages.icProfilePic,
            height: 73.w,
            width: 73.w,
            fit: BoxFit.cover,
            imageBorderRadius: BorderRadius.circular(50.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartText(bloc.userIdDetails?.fullName, style: style.titleStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                SizedBox(height: 1.h),
                SmartText(bloc.userIdDetails?.phoneNumber, style: style.subTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 1.h),
                SmartText(bloc.userIdDetails?.email, style: style.subTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          SmartImage(path: AppImages.icEditProfile, onTap: () => bloc.onTapEditProfileButton(context: context))
        ],
      ),
    );
  }
}
