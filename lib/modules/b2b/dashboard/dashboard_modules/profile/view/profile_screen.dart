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
        onScan: () {},
        onFavorite: () {},
        onNotification: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      imageBorderRadius: BorderRadius.circular(38.r),
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
                          SmartText('someone@example.com', style: style.subTextStyle)
                        ],
                      ),
                    ),
                    SmartImage(path: AppImages.icEditProfile, onTap: () {}),
                  ],
                ),
              ),
              Divider(color: style.dividerColor, thickness: 8.h),
              SmartText(
                APPStrings.myAccount.tr,
                style: style.subTitleStyle,
                optionalPadding: EdgeInsets.only(left: 17.w, top: 16.h),
              ),
              Padding(
                padding: EdgeInsets.only(left: 17.w, right: 17.w, bottom: 16.h),
                child: _buildAccountList(style, bloc),
              ),
              Divider(color: style.dividerColor, thickness: 8.h),
              _buildExpandList(style, bloc),
              _buildPopupList(style, bloc),
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

  Widget _buildExpandList(ProfileScreenStyle style, ProfileBloc bloc) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListView.builder(
        padding: EdgeInsets.only(bottom: 16.h),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 17.w, top: 16.h, right: 17.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartImage(
                  path: bloc.profileChildrenList[index].image ?? '',
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmartText(
                        bloc.profileChildrenList[index].title,
                        style: style.expandTitleStyle,
                        onTap: () {
                          bloc.add(ToggleProfileListEvent(index: index));
                        },
                      ),
                      if (bloc.profileChildrenList[index].profileChildrenList.isNotNullNorEmpty) SizedBox(height: 8.h),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: bloc.profileChildrenList[index].isSubListExpanded
                            ? ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: bloc.profileChildrenList[index].profileChildrenList?.length ?? 0,
                                itemBuilder: (context, childIndex) {
                                  return SmartText(
                                    bloc.profileChildrenList[index].profileChildrenList?[childIndex].title,
                                    style: style.expandTitleStyle,
                                    onTap: bloc.profileChildrenList[index].profileChildrenList?[childIndex].onTap,
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: bloc.profileChildrenList.length,
      );
    });
  }

  Widget _buildPopupList(ProfileScreenStyle style, ProfileBloc bloc) {
    return Container(
      color: style.dividerColor,
      padding: EdgeInsets.symmetric(horizontal: 17.0.w),
      child: Column(
        children: [
          _buildPopupItem(title: APPStrings.logout.tr, onTap: () {}, image: AppImages.icLogout, textStyle: style.logoutTextStyle),
          Divider(height: 16.h),
          _buildPopupItem(
              title: APPStrings.deleteAccount.tr, onTap: () {}, image: AppImages.icDeleteAccount, textStyle: style.fontTextStyle),
        ],
      ),
    );
  }

  Widget _buildPopupItem({required String title, required String image, required TextStyle textStyle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0.h),
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
}
