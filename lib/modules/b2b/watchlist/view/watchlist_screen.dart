import 'package:kgk/kgk.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WatchlistBloc bloc = BlocProvider.of<WatchlistBloc>(context);
    return PopScope(
      onPopInvokedWithResult: (_, _) {
        bloc.add(const WatchListCloseEvent());
      },
      child: Scaffold(
        floatingActionButton: ScrollToTopFAB(
          canScrollToTop: bloc.paginationScrollController.canScrollToTop,
          onTap: bloc.paginationScrollController.scrollToTop,
        ),
        appBar: SmartAppBar(
          title: APPStrings.watchlist.tr,
          onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
          onSearch: () => context.pushNamed(AppRoutes.searchPage),
          onBack: () {
            bloc.add(WatchListCloseEvent(context: context));
          },
        ),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          buildWhen: (previous, current) => current is WatchlistLoadedState,
          builder: (context, state) {
            if (state is WatchlistLoadedState) {
              return _buildWatchlistContent(context);
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      ),
    );
  }

  Widget _buildWatchlistContent(BuildContext context) {
    final bloc = BlocProvider.of<WatchlistBloc>(context);

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w, vertical: 24.0.h),
      child: Column(
        children: [_buildSearchField(bloc, context), SizedBox(height: 24.h), Expanded(child: _buildWatchlistList(bloc, context))],
      ),
    );
  }

  Widget _buildSearchField(WatchlistBloc bloc, BuildContext context) {
    return SmartTextField.search(
      height: 48.h,
      hintText: APPStrings.searchWatchlist.tr,
      controller: bloc.watchlistSearchController,
      onValueChanges: (value) {
        /// We can use this function inside watchlist bloc using TextEditingController.addListener
        /// but we need BuildContext inside the function so called from here
        bloc.searchListener(context);
      },
    );
  }

  Widget _buildWatchlistList(WatchlistBloc bloc, BuildContext context) {
    if (bloc.watchListingList.isEmpty) {
      return NoDataFoundWidget(text: APPStrings.noWatchlistFound.tr);
    }
    return SmartSingleChildScrollView(
      onRefresh: () async => await bloc.pullToRefresh(context: context),
      controller: bloc.paginationScrollController.controller,
      child: BlocBuilder<WatchlistBloc, WatchlistState>(
        buildWhen:
            (previous, current) =>
                current is WatchlistLoadedState ||
                current is WatchlistLoadedMoreState ||
                current is WatchlistDeleteState ||
                current is WatchlistLoadingState,
        builder: (builderContext, state) {
          return _buildListView(bloc, builderContext);
        },
      ),
    );
  }

  Widget _buildListView(WatchlistBloc bloc, BuildContext builderContext) {
    return ListView.builder(
      itemCount: bloc.watchListingList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 40.h),
      itemBuilder: (context, index) => _buildWatchlistItem(bloc, index, builderContext),
    );
  }

  /// Build Watchlist Item Widget
  Widget _buildWatchlistItem(WatchlistBloc bloc, int index, BuildContext screenContext) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      buildWhen: (previous, current) => current is WatchlistLoadingMoreState || current is WatchlistLoadedMoreState,
      builder: (context, state) {
        return Column(
          children: [
            B2BListingItem(
              onTapMenuButton:
                  (bloc.canEditWatchlist || bloc.canDeleteWatchlist)
                      ? () {
                        _showWatchlistBottomSheet(screenContext, bloc, index: index);
                      }
                      : null,
              type: B2BListingType.watchlistType,
              listingItemModel: bloc.watchListingList[index],
              margin: EdgeInsetsDirectional.only(bottom: 16.h),
              onTap: () {
                context
                    .pushNamed(AppRoutes.watchlistDetailsPage, arguments: {RoutesData.watchlistId: bloc.watchlistDataList[index].sId})
                    .then((value) {
                      if (value != null && (value as Map).isNotEmpty) {
                        if (value[RoutesData.isWatchlistUpdated] == true || value[RoutesData.isWatchlistDeleted] == true) {
                          if (value[RoutesData.watchlistData] != null && value[RoutesData.watchlistData] is WatchlistData) {
                            bloc.add(
                              WatchListUpdateItemEvent(
                                index: index,
                                watchlistData: value[RoutesData.watchlistData],
                                isWatchlistDeleted: value[RoutesData.isWatchlistDeleted],
                              ),
                            );
                          }
                        }
                      }
                    });
              },
            ),
            if (state is WatchlistLoadingMoreState && index == bloc.watchListingList.length - 1) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(WatchlistBloc bloc, BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      buildWhen: (previous, current) => current is WatchlistLoadedState,
      builder: (context, state) {
        if (state is WatchlistLoadedState) {
          return SafeArea(
            child: ScrollToHideWidget(
              controller: bloc.paginationScrollController.controller,
              child: FilterBottomActionBar(
                onFilterTap: () {
                  BlocProvider.of<AdvanceSortFilterBloc>(
                    context,
                  ).add(AddAdvanceSortFilterDataEvent(filterOptionList: bloc.filterData, context: context));
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    builder:
                        (context) => AdvanceFilterScreen(
                          onApply: (value) {
                            if (value != null && value is List<FilterData>) {
                              bloc.add(WatchListFilterEvent(filterData: value, context: context));
                            }
                          },
                        ),
                  );
                },
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  /// Show watchlist bottom sheet with edit and delete option
  void _showWatchlistBottomSheet(BuildContext screenContext, WatchlistBloc bloc, {required int index}) {
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
          height: 170.h,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (bloc.canEditWatchlist)
                    _buildPopupOption(
                      context,
                      text: APPStrings.editWatchlist.tr,
                      style: orderPopupStyle.optionTextStyle,
                      onTap: () async {
                        context.pop();
                        BlocProvider.of<EditWatchlistBloc>(
                          context,
                        ).add(EditWatchlistInitialEvent(isEdit: true, watchlistData: bloc.watchlistDataList[index]));

                        final result = await Utils.showSmartModalBottomSheet(
                          context: context,
                          enableDrag: false,
                          builder: (context) {
                            return const EditWatchlistScreen();
                          },
                        );
                        if (result?[RoutesData.isWatchlistUpdated] == true) {
                          bloc.pullToRefresh(context: screenContext);
                        }
                      },
                    ),
                  if (bloc.canDeleteWatchlist)
                    _buildPopupOption(
                      context,
                      text: APPStrings.removeWatchlist.tr,
                      style: orderPopupStyle.cancelTextStyle,
                      onTap: () {
                        context.pop();
                        WatchlistData watchlistData = WatchlistData.fromJson(bloc.watchlistDataList[index].toJson());
                        _buildRemoveWatchlistPopup(screenContext, bloc, watchlistData: watchlistData);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Remove Watchlist Popup
  void _buildRemoveWatchlistPopup(BuildContext screenContext, WatchlistBloc bloc, {required WatchlistData watchlistData}) {
    Utils.showSmartModalBottomSheet(
      context: screenContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(16.r), topEnd: Radius.circular(16.r)),
      ),
      builder:
          (context) => ConfirmationDialog(
            title: APPStrings.removeWatchlistName.tr,
            message: APPStrings.addedXProductsWillBeRemoved.tr.interpolate([watchlistData.products?.length ?? 0]),
            onApproved: () {
              bloc.add(WatchListDeleteEvent(watchlistData.sId, context, screenContext));
            },
            onDenied: () => context.pop(),
            onApprovedText: APPStrings.remove.tr,
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
}
