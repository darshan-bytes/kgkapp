import 'package:kgk/kgk.dart';

class SharePresentationScreen extends StatelessWidget {
  ///[isPresentation] is a boolean variable that is used to determine whether the screen is for sharing a presentation or a catalogue.
  final bool isPresentation;

  const SharePresentationScreen({super.key, this.isPresentation = true});

  @override
  Widget build(BuildContext context) {
    late SharePresentationBloc bloc;
    final SharePresentationStyle style = AppTheme.of(context).sharePresentationStyle;
    return BlocProvider(
      create: (context) {
        bloc = SharePresentationBloc()..add(SharePresentationInitialEvent(isPresentation: isPresentation));
        return bloc;
      },
      child: BlocBuilder<SharePresentationBloc, SharePresentationState>(
        buildWhen: (previous, current) => current is SharePresentationTitleLoadedState,
        builder: (context, state) {
          if (state is SharePresentationTitleLoadedState) {
            bloc = BlocProvider.of<SharePresentationBloc>(context);
            return Container(
              constraints: BoxConstraints(maxHeight: 775.h),
              decoration: BoxDecoration(
                color: style.backgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r)),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildSharePresentationTitleSection(style),
                        _buildScrollableWidgetList(bloc, style, context),
                        _buildBottomStaticSection(bloc, style, context)
                      ],
                    ),
                    Positioned(
                      top: 16.h,
                      right: 16.w,
                      child: SmartImage(
                        path: AppImages.icCross,
                        height: 24.w,
                        width: 24.w,
                        color: style.closeIconColor,
                        onTap: () {
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildSharePresentationTitleSection(SharePresentationStyle style) {
    return BlocBuilder<SharePresentationBloc, SharePresentationState>(
      buildWhen: (previous, current) => current is SharePresentationTitleLoadedState,
      builder: (context, state) {
        if (state is SharePresentationTitleLoadedState) {
          return SmartText(
            state.title,
            style: style.titleStyle,
            optionalPadding: EdgeInsets.only(top: 24.h, left: 17.w, right: 17.w, bottom: 17.h),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildScrollableWidgetList(SharePresentationBloc bloc, SharePresentationStyle style, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShareButtonsRow(bloc, style),
              SizedBox(height: 24.h),
              _buildEmailTextField(bloc, context),
              SizedBox(height: 24.h),
              ..._buildPeopleWithAccess(bloc, style),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomStaticSection(SharePresentationBloc bloc, SharePresentationStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 17.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildGeneralShareRow(bloc, style),
          const Divider(),
          _buildBottomNavbar(bloc, style, context),
        ],
      ),
    );
  }

  Widget _buildShareButtonsRow(SharePresentationBloc bloc, SharePresentationStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icQrCode, APPStrings.qrCode.tr, () {
          //TODO: Implement QR Code
        }),
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icWhatsapp, APPStrings.whatsapp.tr, () {
          //TODO: Implement WhatsApp Share
        }),
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icFaceBook, APPStrings.facebook.tr, () {
          //TODO: Implement Facebook Share
        }),
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icCopy, APPStrings.copyLink.tr, () {
          //TODO: Implement Copy Link Share
        }),
      ],
    );
  }

  Widget _buildShareButtons(TextStyle iconButtonTextStyle, String imagePath, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SmartImage(path: imagePath, height: 56.w, width: 56.w),
          SizedBox(height: 8.h),
          SmartText(text, style: iconButtonTextStyle),
        ],
      ),
    );
  }

  Widget _buildEmailTextField(SharePresentationBloc bloc, BuildContext context) {
    return SmartTextField(
      controller: bloc.emailController,
      labelText: APPStrings.enterEmailAddress.tr,
      onTapOutside: (event) {},
      textInputAction: TextInputAction.done,
    );
  }

  List<Widget> _buildPeopleWithAccess(SharePresentationBloc bloc, SharePresentationStyle style) {
    return [
      SmartText(APPStrings.peopleWithAccess.tr, style: style.userListTitleStyle),
      SizedBox(height: 14.h),
      BlocBuilder<SharePresentationBloc, SharePresentationState>(
        bloc: bloc,
        buildWhen: (previous, current) => current is SharePresentationLoadedState || current is SharePresentationLoadingState,
        builder: (context, state) {
          if (state is SharePresentationLoadedState) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bloc.userList.length,
              itemBuilder: (context, index) {
                final UserListModel user = bloc.userList[index];
                return _buildUserWidget(user, style, bloc);
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
            );
          } else {
            return const SmartCircularProgressIndicator();
          }
        },
      )
    ];
  }

  Widget _buildUserWidget(UserListModel user, SharePresentationStyle style, SharePresentationBloc bloc) {
    return Row(
      children: [
        if (user.image.isNotNullNorEmpty) ...[
          SmartImage(path: user.image ?? '', height: 40.w, width: 40.w, imageBorderRadius: BorderRadius.circular(20.r)),
          SizedBox(width: 8.w),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText(user.name ?? '', style: style.userNamesTextStyle),
              SizedBox(height: 2.h),
              SmartText(user.email ?? '', style: style.userEmailTextStyle),
            ],
          ),
        ),
        if (user.role != null) ...[
          SizedBox(width: 16.w),
          _buildPeopleAccessDropDownField(bloc, user),
        ],
      ],
    );
  }

  List<Widget> _buildGeneralShareRow(SharePresentationBloc bloc, SharePresentationStyle style) {
    return [
      SizedBox(height: 24.h),
      SmartText(APPStrings.generalAccess.tr, style: style.userListTitleStyle),
      SizedBox(height: 16.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SmartImage(
            path: AppImages.icAnyoneWithLink,
            height: 40.w,
            width: 40.w,
            imageBorderRadius: BorderRadius.circular(20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmartText(APPStrings.anyoneWithTheLink.tr, style: style.userNamesTextStyle),
                    SizedBox(width: 4.w),
                    SmartImage(path: AppImages.icArrowDropDown, height: 16.w, width: 16.w),
                  ],
                ),
                SizedBox(height: 2.h),
                SmartText(APPStrings.anyoneWithTheLinkDesc.tr, style: style.userEmailTextStyle),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          _buildGeneralAccessDropDownField(bloc)
        ],
      ),
      SizedBox(height: 24.h),
    ];
  }

  Widget _buildBottomNavbar(SharePresentationBloc bloc, SharePresentationStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        children: [
          Expanded(
            child: SmartButton(
              title: APPStrings.cancel.tr,
              onTap: () {
                context.pop();
              },
              activeBackgroundColor: style.backgroundColor,
              titleStyle: style.userListTitleStyle,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: SmartButton(
              title: APPStrings.share.tr,
              onTap: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeopleAccessDropDownField(SharePresentationBloc bloc, UserListModel user) {
    return BlocBuilder<SharePresentationBloc, SharePresentationState>(
      buildWhen: (previous, current) => current is ChangeUserAccessTypeState,
      builder: (context, state) {
        return SmartDropDown<UserAccessType>(
          contentPadding: EdgeInsets.zero,
          isIcArrowDropDown: user.role!.isModifiable,
          isExpanded: false,
          border: const Border(top: BorderSide.none),
          items: bloc.arrPeopleAccessType.map((UserAccessType type) {
            return SmartDropDownItem<UserAccessType>(
              value: type,
              title: type.accessType ?? APPStrings.select.tr,
            );
          }).toList(),
          onChanged: (type) {
            if (type != null) {
              bloc.add(ChangeUserAccessTypeEvent(type, user));
            }
          },
          selectedItem: user.userAccessType,
        );
      },
    );
  }

  Widget _buildGeneralAccessDropDownField(SharePresentationBloc bloc) {
    return BlocBuilder<SharePresentationBloc, SharePresentationState>(
      buildWhen: (previous, current) => current is ChangeGeneralAccessTypeState,
      builder: (context, state) {
        return SmartDropDown<UserAccessType>(
          isIcArrowDropDown: true,
          isExpanded: false,
          contentPadding: EdgeInsets.zero,
          border: const Border(top: BorderSide.none),
          items: bloc.arrGeneralAccessType.map((UserAccessType type) {
            return SmartDropDownItem<UserAccessType>(
              value: type,
              title: type.accessType ?? APPStrings.select.tr,
            );
          }).toList(),
          onChanged: (type) {
            if (type != null) {
              bloc.add(ChangeGeneralAccessTypeEvent(type));
            }
          },
          selectedItem: bloc.selectedGeneralAccessType,
        );
      },
    );
  }
}
