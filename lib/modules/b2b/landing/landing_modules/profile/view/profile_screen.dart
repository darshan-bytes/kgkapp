import 'package:kgk/kgk.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileScreenStyle style = AppTheme.of(context).profilePageScreenStyle;
    final ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        isBack: false,
        leadingImage: "https://i.ibb.co/cyvpMrR/KGK-Group-Logo-1.png",
        onScan: () {
          context.pushNamed(AppRoutes.qrScannerPage);
        },
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onNotification: () {
          context.pushNamed(AppRoutes.notificationPage);
        },
      ),
      body: SafeArea(
        child: SmartSingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(17.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmartImage(
                      path: 'https://i.ibb.co/GWFG9GF/Frame-1410088735.png',
                      height: 73.h,
                      width: 73.w,
                      imageBorderRadius: BorderRadius.circular(50.r),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SmartText('Alex Williams', style: style.titleStyle),
                          SizedBox(height: 1.h),
                          SmartText('+1 (323) 654 - 8542', style: style.subTextStyle),
                          SizedBox(height: 1.h),
                          InkWell(
                              onTap: () {
                                context.pushNamed(AppRoutes.pddListingPage);
                              },
                              child: SmartText('someone@example.com', style: style.subTextStyle))
                        ],
                      ),
                    ),
                    SmartImage(
                        path: AppImages.icEditProfile,
                        onTap: () {
                          Utils.showSmartModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
                              ),
                              builder: (context) => LayoutBuilder(
                                    builder: (context, _) {
                                      return AnimatedPadding(
                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                          duration: const Duration(milliseconds: 50),
                                          curve: Curves.easeOut,
                                          child: Container(
                                            constraints: BoxConstraints(maxHeight: context.height, minHeight: 660.h),
                                            child: const EditProfileBottomSheet(),
                                          ));
                                    },
                                  ));
                        }),
                  ],
                ),
              ),
              Divider(color: style.dividerColor, thickness: 8.h),
              SmartText(
                APPStrings.myAccount.tr,
                style: style.subTitleStyle,
                optionalPadding: EdgeInsets.only(left: 17.w, top: 16.h),
              ),
              _buildAccountList(style, bloc),
              if (bloc.userType == UserType.b2bUser) ...[
                Divider(color: style.dividerColor, thickness: 8.h),
                SmartText(
                  APPStrings.adminSection.tr,
                  style: style.subTitleStyle,
                  optionalPadding: EdgeInsets.only(left: 17.w, top: 16.h),
                ),
              ],
              _buildAdminList(style, bloc),
              Divider(color: style.dividerColor, thickness: 8.h),
              _buildExpandList(style, bloc),
              _buildPopupList(context, style, bloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountList(ProfileScreenStyle style, ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 17.w, right: 17.w, bottom: 16.h),
          primary: false,
          itemBuilder: (context, index) {
            return SmartOptionTile(
              profileListModel: bloc.profileActionList[index],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: bloc.profileActionList.length);
    });
  }

  Widget _buildAdminList(ProfileScreenStyle style, ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 17.w, right: 17.w, bottom: 16.h),
          primary: false,
          itemBuilder: (context, index) {
            return SmartOptionTile(
              leadingImageColor: style.arrowRightColor,
              profileListModel: bloc.profileAdminList[index],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: bloc.profileAdminList.length);
    });
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
              bloc.add(ToggleProfileListEvent(index: index));
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
                                      onTap: bloc.profileCMSList[index].profileSubList?[childIndex].onTap,
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
                _buildLogoutPopup(context);
              },
              image: AppImages.icLogout,
              textStyle: style.logoutTextStyle),
          const Divider(),
          _buildPopupItem(
              title: APPStrings.deleteAccount.tr,
              onTap: () {
                _buildDeletePopup(context);
              },
              image: AppImages.icDeleteAccount,
              textStyle: style.fontTextStyle),
          SizedBox(
            height: 10.h,
          )
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

  void _buildLogoutPopup(BuildContext context) {
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
        builder: (context) => ConfirmationDialog(
              title: APPStrings.logoutAsk.tr,
              message: APPStrings.logoutMsg.tr,
              onApproved: () {
                BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: context));
                context.pushNamedAndRemoveUntil(AppRoutes.getReadyPage, (route) => false);
              },
              onDenied: () => context.pop(),
              onApprovedText: APPStrings.logout.tr,
              onDeniedText: APPStrings.cancel.tr,
            ));
  }

  void _buildDeletePopup(BuildContext context) {
    Utils.showSmartModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
        ),
        builder: (context) => ConfirmationDialog(
              title: APPStrings.deleteAccountAsk.tr,
              message: APPStrings.deleteAccountDesc.tr,
              onApproved: () {
                BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.homeIndex, context: context));
                context.pushNamedAndRemoveUntil(AppRoutes.getReadyPage, (route) => false);
              },
              onDenied: () => context.pop(),
              onApprovedText: APPStrings.delete.tr,
              onDeniedText: APPStrings.cancel.tr,
            ));
  }
}
