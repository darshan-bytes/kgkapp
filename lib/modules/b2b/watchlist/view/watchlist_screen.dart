import 'package:kgk/kgk.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WatchlistBloc bloc = BlocProvider.of<WatchlistBloc>(context);
    return PopScope(
      onPopInvokedWithResult: (_, __) {
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
        ),
        body: BlocBuilder<WatchlistBloc, WatchlistState>(
          buildWhen: (previous, current) => current is WatchlistLoadedState,
          builder: (context, state) {
            if (state is WatchlistLoadedState) {
              return SmartSingleChildScrollView(
                onRefresh: () async {
                  await bloc.pullToRefresh(context: context);
                },
                padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 24.0.h),
                controller: bloc.paginationScrollController.controller,
                child: Column(
                  children: [
                    SmartTextField.search(
                      height: 48.h,
                      hintText: APPStrings.searchWatchlist.tr,
                      controller: bloc.watchlistSearchController,
                      onValueChanges: (value) {
                        /// We can use this function inside watchlist bloc using TextEditingController.addListener
                        /// but we need BuildContext inside the function so called from here
                        bloc.searchListener(context);
                      },
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<WatchlistBloc, WatchlistState>(
                      buildWhen: (previous, current) =>
                          current is WatchlistLoadedState ||
                          current is WatchlistLoadedMoreState ||
                          current is WatchlistDeleteState ||
                          current is WatchlistLoadingState,
                      builder: (builderContext, state) {
                        if (bloc.watchListingList.isEmpty && state is! WatchlistLoadingState) {
                          return NoDataFoundWidget(
                            text: APPStrings.noWatchlistFound.tr,
                            onRetry: () {
                              bloc.pullToRefresh(context: builderContext);
                            },
                          );
                        }
                        return ListView.builder(
                          itemCount: bloc.watchListingList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _buildWatchlistItem(bloc, index, builderContext),
                        );
                      },
                    )
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      ),
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
              onTapMenuButton: () {
                _showWatchlistBottomSheet(screenContext, bloc, index: index);
              },
              type: B2BListingType.watchlistType,
              listingItemModel: bloc.watchListingList[index],
              margin: EdgeInsets.only(bottom: 16.h),
              onTap: () {
                context.pushNamed(AppRoutes.watchlistDetailsPage, arguments: {RoutesData.watchlistId: bloc.watchlistDataList[index].sId});
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
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    builder: (context) => FilterScreen(
                      onApply: () {},
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
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
        ),
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
              color: orderPopupStyle.whiteColor,
            ),
            height: 170.h,
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildPopupOption(context, text: APPStrings.editWatchlist.tr, style: orderPopupStyle.optionTextStyle, onTap: () async {
                      context.pop();
                      BlocProvider.of<EditWatchlistBloc>(context)
                          .add(EditWatchlistInitialEvent(isEdit: true, watchlistData: bloc.watchlistDataList[index]));

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
                    }),
                    _buildPopupOption(context, text: APPStrings.removeWatchlist.tr, style: orderPopupStyle.cancelTextStyle, onTap: () {
                      context.pop();
                      WatchlistData watchlistData = WatchlistData.fromJson(bloc.watchlistDataList[index].toJson());
                      _buildRemoveWatchlistPopup(screenContext, bloc, watchlistData: watchlistData);
                    }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  /// Remove Watchlist Popup
  void _buildRemoveWatchlistPopup(BuildContext screenContext, WatchlistBloc bloc, {required WatchlistData watchlistData}) {
    Utils.showSmartModalBottomSheet(
      context: screenContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (context) => ConfirmationDialog(
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
  Widget _buildPopupOption(
    BuildContext context, {
    required String text,
    required TextStyle style,
    EdgeInsets? padding,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: context.width,
        alignment: Alignment.centerLeft,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
        child: SmartText(text, style: style),
      ),
    );
  }
}
