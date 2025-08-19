import 'package:kgk/kgk.dart';

class UserMasterListingScreen extends StatelessWidget {
  const UserMasterListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserMasterListingBloc bloc = BlocProvider.of<UserMasterListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.userMaster.tr,
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
        onNotification: () => context.pushNamed(AppRoutes.notificationPage),
      ),

      ///TODO : bottomNavigationBar is not used so we have commented it as discussed with JD
      // bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: bloc.paginationScrollController.canScrollToTop,
        onTap: bloc.paginationScrollController.scrollToTop,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0.w),
          child: Column(
            children: [
              _buildSearchTextField(bloc, context),
              Expanded(
                child: BlocBuilder<UserMasterListingBloc, UserMasterListingState>(
                  buildWhen:
                      (previous, current) =>
                          current is UserMasterListingLoadedState ||
                          current is UserMasterLoadingState ||
                          current is UserMasterListLoadedMoreState ||
                          current is UserMasterListLoadingMoreState,
                  builder: (context, state) {
                    if (state is UserMasterLoadingState) {
                      return Center(child: const SmartCircularProgressIndicator());
                    } else if (state is UserMasterListingLoadedState) {
                      return _buildUserMasterList(bloc);
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField(UserMasterListingBloc bloc, BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;
    final BorderRadius borderRadius = BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r));
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: style.dividerColor),
      borderRadius: borderRadius,
    );
    return Row(
      children: [
        Expanded(
          child: SmartTextField.search(
            height: 48.w,
            prefixIconSize: 10.w,
            padding: EdgeInsetsDirectional.symmetric(vertical: 24.w),
            hintText: APPStrings.searchUser.tr,
            controller: bloc.userMasterSearchController,
            borderRadius: borderRadius,
            customFocusedBorder: outlineInputBorder,
            customDisabledBorder: outlineInputBorder,
            customErrorBorder: outlineInputBorder,
            customFocusedErrorBorder: outlineInputBorder,
            onTapOutside: (value) => FocusScope.of(context).unfocus(),
            onValueChanges: (value) {
              bloc.add(UserMasterListingSearchEvent(context: context));
            },
            onFieldSubmitted: (value) {
              bloc.add(UserMasterListingSearchEvent(context: context));
            },
          ),
        ),

        ///TODO : currently Location filter is not required so we have commented it as discussed with Shiva bhai
        // _buildOrderDropDownField(bloc, style),
      ],
    );
  }

  Widget _buildUserMasterList(UserMasterListingBloc bloc) {
    return BlocBuilder<UserMasterListingBloc, UserMasterListingState>(
      buildWhen:
          (previous, current) =>
              current is UserMasterListLoadedMoreState ||
              current is UserMasterListLoadingMoreState ||
              current is UserMasterListingLoadedState,
      builder: (context, state) {
        if (bloc.userMasterList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noUserFound.tr);
        }
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            bloc.add(UserMasterListingPullToRefreshEvent(context: context));
          },
          child: ListView.builder(
            shrinkWrap: true,
            controller: bloc.paginationScrollController.scrollController,
            itemCount: bloc.userMasterList.length,
            itemBuilder: (context, index) {
              B2BCustomListingDataModel userItem = bloc.userMasterList[index];
              return BlocBuilder<UserMasterListingBloc, UserMasterListingState>(
                buildWhen: (previous, current) => current is UserMasterListLoadedMoreState || current is UserMasterListLoadingMoreState,
                builder: (context, state) {
                  return Column(
                    children: [
                      B2BListingItem(
                        margin: EdgeInsetsDirectional.only(
                          bottom: index == bloc.userMasterList.length - 1 && state is UserMasterListLoadingMoreState ? 0 : 16.0.h,
                        ),
                        type: B2BListingType.userListingType,
                        listingItemModel: userItem,
                        isLastFullWidthRequired: true,
                        onTapMenuButton: () {
                          _showUserMasterBottomSheet(context, bloc, index: index);
                        },
                      ),
                      if (index == bloc.userMasterList.length - 1 && state is UserMasterListLoadingMoreState)
                        const SmartCircularProgressIndicator(),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showUserMasterBottomSheet(BuildContext screenContext, UserMasterListingBloc bloc, {required int index}) {
    OrderPopupStyle orderPopupStyle = AppTheme.of(screenContext).orderPopupStyle;
    Utils.showSmartModalBottomSheet(
      context: screenContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
            color: orderPopupStyle.whiteColor,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildPopupOption(
                  context,
                  text: bloc.userMasterDataList[index].status ? APPStrings.markAsInActive.tr : APPStrings.markAsActive.tr,
                  style: bloc.userMasterDataList[index].status ? orderPopupStyle.cancelTextStyle : orderPopupStyle.optionTextStyle,
                  onTap: () {
                    context.pop();
                    _buildChangeStatusConfirmPopup(screenContext, bloc, index);
                  },
                ),
                // Change Password
                _buildPopupOption(
                  context,
                  text: APPStrings.changePassword.tr,
                  style: orderPopupStyle.optionTextStyle,
                  onTap: () {
                    context.pop();
                    _buildChangePasswordBottomSheet(screenContext, bloc, index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _buildChangeStatusConfirmPopup(BuildContext screenContext, UserMasterListingBloc bloc, int index) {
    Utils.showSmartModalBottomSheet(
      context: screenContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder:
          (context) => ConfirmationDialog(
            title: APPStrings.areYouSure.tr,
            message: APPStrings.userStatusChangeMsg.tr,
            onApproved: () {
              context.pop();
              bloc.add(UserMasterChangeStatusEvent(context: screenContext, index: index));
            },
            onDenied: () => context.pop(),
            onApprovedText: APPStrings.yes.tr,
            onDeniedText: APPStrings.cancel.tr,
          ),
    );
  }

  /// Build popup option
  Widget _buildPopupOption(BuildContext context, {required String text, required TextStyle style, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: context.width,
        alignment: AlignmentDirectional.centerStart,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
        child: SmartText(text, style: style),
      ),
    );
  }

  Widget _buildOrderDropDownField(UserMasterListingBloc bloc, FilterBottomActionBarStyle style) {
    return BlocBuilder<UserMasterListingBloc, UserMasterListingState>(
      buildWhen: (previous, current) => current is UserMasterChangeLocationTypeState,
      builder: (context, state) {
        return SizedBox(
          width: 120.w,
          child: SmartDropDown<UserLocationModel>(
            border: BorderDirectional(
              end: BorderSide(color: style.dividerColor),
              top: BorderSide(color: style.dividerColor),
              bottom: BorderSide(color: style.dividerColor),
            ),
            borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
            items:
                bloc.userLocationTypeList.map((UserLocationModel type) {
                  return SmartDropDownItem<UserLocationModel>(value: type, title: type.name ?? APPStrings.select.tr);
                }).toList(),
            onChanged: (type) {
              if (type != null) {
                bloc.add(UserMasterChangeLocationTypeEvent(type));
              }
            },
            selectedItem: bloc.selectedUserLocationType,
          ),
        );
      },
    );
  }

  void _buildChangePasswordBottomSheet(BuildContext screenContext, UserMasterListingBloc bloc, int index) {
    Widget bottomSheet = ChangePasswordBottomSheetForUserMaster(index: index, bloc: bloc..add(UserMasterChangePasswordInitialEvent()));

    Utils.showSmartModalBottomSheet(
      context: screenContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder: (context) {
        return bottomSheet;
      },
    );
  }
}
