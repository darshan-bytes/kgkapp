import 'package:kgk/kgk.dart';
import 'package:multiple_search_selection/overlay/overlay_options.dart';

class SharePresentationScreen extends StatelessWidget {
  ///[isPresentation] is a boolean variable that is used to determine whether the screen is for sharing a presentation or a catalogue.
  final bool isPresentation;
  final String? webUrl;

  const SharePresentationScreen({super.key, this.isPresentation = true, this.webUrl});

  @override
  Widget build(BuildContext context) {
    late SharePresentationBloc bloc;
    final SharePresentationStyle style = AppTheme.of(context).sharePresentationStyle;
    return BlocBuilder<SharePresentationBloc, SharePresentationState>(
      buildWhen: (previous, current) => current is SharePresentationTitleLoadedState,
      builder: (context, state) {
        if (state is SharePresentationTitleLoadedState) {
          bloc = BlocProvider.of<SharePresentationBloc>(context);
          return Container(
            margin: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: EdgeInsetsDirectional.only(bottom: 24.h),
            // constraints: BoxConstraints(maxHeight: 775.h),
            decoration: BoxDecoration(
              color: style.backgroundColor,
              borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(6.r), topEnd: Radius.circular(6.r)),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSharePresentationTitleSection(style),
                      _buildScrollableWidgetList(bloc, style, context),

                      /// Below code is commented because it is not used in the app for now. It will be used in future for B2B implementation.
                      _buildBottomStaticSection(bloc, style, context),
                    ],
                  ),
                  PositionedDirectional(
                    top: 16.h,
                    end: 16.w,
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
            optionalPadding: EdgeInsetsDirectional.only(top: 24.h, start: 17.w, end: 17.w, bottom: 17.h),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildScrollableWidgetList(SharePresentationBloc bloc, SharePresentationStyle style, BuildContext context) {
    return Flexible(
      child: SmartSingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShareButtonsRow(bloc, style),
              SizedBox(height: 24.h),
              _buildEmailTextField(bloc, context, style),
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
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [/*..._buildGeneralShareRow(bloc, style),*/ const Divider(), _buildBottomNavbar(bloc, style, context)],
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
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icWhatsapp, APPStrings.whatsapp.tr, () async {
          //TODO: Implement WhatsApp Share
          if (bloc.webUrl.isNotNullNorEmpty) {
            await Clipboard.setData(ClipboardData(text: bloc.webUrl!));
            await SharePlus.instance.share(ShareParams(uri: Uri.parse(bloc.webUrl!)));
          }
        }),
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icFaceBook, APPStrings.facebook.tr, () async {
          //TODO: Implement Facebook Share
          if (bloc.webUrl.isNotNullNorEmpty) {
            await Clipboard.setData(ClipboardData(text: bloc.webUrl!));
            await SharePlus.instance.share(ShareParams(uri: Uri.parse(bloc.webUrl!)));
          }
        }),
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icCopy, APPStrings.copyLink.tr, () async {
          //TODO: Implement Copy Link Share
          if (bloc.webUrl.isNotNullNorEmpty) {
            await Clipboard.setData(ClipboardData(text: bloc.webUrl!));
          }
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

  Widget _buildEmailTextField(SharePresentationBloc bloc, BuildContext context, SharePresentationStyle style) {
    return MultipleSearchSelection<UserIdDetails>.overlay(
      controller: bloc.controller,
      items: bloc.userIdDetailsList,
      caseSensitiveSearch: false,
      fuzzySearch: FuzzySearch.jaro,
      fieldToCheck: (UserIdDetails item) => item.fullName,
      onItemRemoved: (item) {},
      onItemAdded: (item) {},
      overlayOptions: OverlayOptions(),
      searchField: TextField(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(labelText: APPStrings.enterEmailAddress.tr, hintText: APPStrings.enterEmailAddress.tr),
      ),
      pickedItemBuilder: (UserIdDetails item) {
        return Container(
          decoration: BoxDecoration(color: style.pickedUserBorderColor, borderRadius: BorderRadius.circular(4.r)),
          padding: EdgeInsetsDirectional.symmetric(vertical: 4.h, horizontal: 6.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SmartImage(path: AppImages.icCross, height: 16.w, width: 16.w),
              SizedBox(width: 4.w),
              SmartText(item.fullName, style: style.userNamesTextStyle),
            ],
          ),
        );
      },
      itemBuilder: (UserIdDetails item, int index, bool isPicked) {
        return SmartText(
          item.fullName,
          style: style.userNamesTextStyle,
          optionalPadding: EdgeInsetsDirectional.symmetric(vertical: 4.h, horizontal: 6.w),
        );
        // return SmartCheckbox(
        //   value: isPicked,
        //   onChanged: (isPicked) {},
        //   label: item.fullName,
        //   padding: EdgeInsetsDirectional.symmetric(vertical: 4.h, horizontal: 6.w),
        // );
      },
    );
  }

  List<Widget> _buildPeopleWithAccess(SharePresentationBloc bloc, SharePresentationStyle style) {
    return [
      SmartText(APPStrings.peopleWithAccess.tr, style: style.userListTitleStyle),
      BlocBuilder<SharePresentationBloc, SharePresentationState>(
        bloc: bloc,
        buildWhen: (previous, current) => current is SharePresentationLoadedState || current is SharePresentationLoadingState,
        builder: (context, state) {
          if (state is SharePresentationLoadedState) {
            return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.symmetric(vertical: 14.h),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bloc.userList.length,
              itemBuilder: (context, index) {
                final PresentationSharedUserData user = bloc.userList[index];
                return _buildUserWidget(user, style, bloc);
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
            );
          } else {
            return const SmartCircularProgressIndicator();
          }
        },
      ),
    ];
  }

  Widget _buildUserWidget(PresentationSharedUserData user, SharePresentationStyle style, SharePresentationBloc bloc) {
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
        if (user.accessType != null) ...[SizedBox(width: 16.w), _buildPeopleAccessDropDownField(bloc, user)],
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
          SmartImage(path: AppImages.icAnyoneWithLink, height: 40.w, width: 40.w, imageBorderRadius: BorderRadius.circular(20.r)),
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
          _buildGeneralAccessDropDownField(bloc),
        ],
      ),
      SizedBox(height: 24.h),
    ];
  }

  Widget _buildBottomNavbar(SharePresentationBloc bloc, SharePresentationStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 24.h),
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

  Widget _buildPeopleAccessDropDownField(SharePresentationBloc bloc, PresentationSharedUserData user) {
    return BlocBuilder<SharePresentationBloc, SharePresentationState>(
      buildWhen: (previous, current) => current is ChangeUserAccessTypeState,
      builder: (context, state) {
        return SmartDropDown<UserAccessType>(
          contentPadding: EdgeInsetsDirectional.zero,
          isIcArrowDropDown: user.isModifiable,
          isExpanded: false,
          border: const BorderDirectional(top: BorderSide.none),
          items:
              (user.isModifiable ? bloc.arrPeopleAccessType : [UserAccessType(code: 'owner', accessType: 'owner'.tr)]).map((
                UserAccessType type,
              ) {
                return SmartDropDownItem<UserAccessType>(value: type, title: type.accessType ?? APPStrings.select.tr);
              }).toList(),
          onChanged: (type) {
            if (type != null) {
              bloc.add(ChangeUserAccessTypeEvent(type, user));
            }
          },
          selectedItem: UserAccessType(code: user.accessType, accessType: user.accessType?.tr),
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
          contentPadding: EdgeInsetsDirectional.zero,
          border: const BorderDirectional(top: BorderSide.none),
          items:
              bloc.arrGeneralAccessType.map((UserAccessType type) {
                return SmartDropDownItem<UserAccessType>(value: type, title: type.accessType ?? APPStrings.select.tr);
              }).toList(),
          onChanged: (type) {
            if (type != null) {
              // bloc.add(ChangeGeneralAccessTypeEvent(type));
            }
          },
          // selectedItem: bloc.selectedGeneralAccessType,
        );
      },
    );
  }
}
