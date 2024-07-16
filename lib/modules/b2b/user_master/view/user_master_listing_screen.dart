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
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: bloc.paginationScrollController.canScrollToTop,
        onTap: bloc.paginationScrollController.scrollToTop,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<UserMasterListingBloc, UserMasterListingState>(
            buildWhen: (previous, current) => current is UserMasterListingLoadedState,
            builder: (context, state) {
              if (state is UserMasterListingLoadedState) {
                return Column(
                  children: [
                    _buildSearchTextField(bloc, context),
                    _buildUserMasterList(bloc),
                  ],
                );
              }
              return const SmartCircularProgressIndicator();
            },
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
            padding: EdgeInsets.symmetric(vertical: 24.w),
            hintText: APPStrings.searchUser.tr,
            controller: bloc.userMasterSearchController,
            borderRadius: borderRadius,
            customFocusedBorder: outlineInputBorder,
            customDisabledBorder: outlineInputBorder,
            customErrorBorder: outlineInputBorder,
            customFocusedErrorBorder: outlineInputBorder,
          ),
        ),
        _buildOrderDropDownField(bloc, style),
      ],
    );
  }

  Widget _buildUserMasterList(UserMasterListingBloc bloc) {
    return Expanded(
      child: BlocBuilder<UserMasterListingBloc, UserMasterListingState>(
        buildWhen: (previous, current) =>
            current is UserMasterListLoadedMoreState ||
            current is UserMasterListLoadingMoreState ||
            current is UserMasterListingLoadedState,
        builder: (context, state) {
          if (bloc.userMasterList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noUserFound.tr);
          }
          return ListView.builder(
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
                          margin: EdgeInsets.only(
                              bottom: index == bloc.userMasterList.length - 1 && state is UserMasterListLoadingMoreState ? 0 : 16.0.h),
                          type: B2BListingType.userListingType,
                          listingItemModel: userItem,
                          gridSpacing: 10.w,
                          onTapMenuButton: () {},
                          onTap: () {},
                        ),
                        if (index == bloc.userMasterList.length - 1 && state is UserMasterListLoadingMoreState)
                          const SmartCircularProgressIndicator(),
                      ],
                    );
                  },
                );
              });
        },
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
            border: Border(
                right: BorderSide(color: style.dividerColor),
                top: BorderSide(color: style.dividerColor),
                bottom: BorderSide(color: style.dividerColor)),
            borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
            items: bloc.userLocationTypeList.map((UserLocationModel type) {
              return SmartDropDownItem<UserLocationModel>(
                value: type,
                title: type.name ?? APPStrings.select.tr,
              );
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

  Widget _buildBottomNavigationBar(UserMasterListingBloc bloc, BuildContext context) {
    return SafeArea(
      child: FilterBottomActionBar(
        onFilterTap: () {
          Utils.showSmartModalBottomSheet(
            context: context,
            builder: (context) => FilterScreen(
              onApply: () {},
            ),
          );
        },
      ),
    );
  }
}
