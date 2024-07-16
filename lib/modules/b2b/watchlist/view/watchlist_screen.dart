import 'package:kgk/kgk.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WatchlistBloc bloc = BlocProvider.of<WatchlistBloc>(context);
    return Scaffold(
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
              padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 24.0.h),
              controller: bloc.paginationScrollController.controller,
              child: Column(
                children: [
                  SmartTextField.search(
                    height: 48.h,
                    hintText: APPStrings.searchWatchlist.tr,
                    controller: bloc.watchlistSearchController,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  BlocBuilder<WatchlistBloc, WatchlistState>(
                    buildWhen: (previous, current) => current is WatchlistLoadedState || current is WatchlistLoadedMoreState,
                    builder: (context, state) {
                      if (bloc.watchListingList.isEmpty) {
                        return NoDataFoundWidget(text: APPStrings.noWatchlistFound.tr);
                      }
                      return ListView.builder(
                        itemCount: bloc.watchListingList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _buildWatchlistItem(bloc, index, context),
                      );
                    },
                  )
                ],
              ),
            );
          }
          return const SmartCircularProgressIndicator();
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
    );
  }

  /// Build Watchlist Item Widget
  Widget _buildWatchlistItem(WatchlistBloc bloc, int index, BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      buildWhen: (previous, current) => current is WatchlistLoadingMoreState || current is WatchlistLoadedMoreState,
      builder: (context, state) {
        return Column(
          children: [
            B2BListingItem(
              onTapMenuButton: () {
                _showWatchlistBottomSheet(context);
              },
              type: B2BListingType.watchlistType,
              listingItemModel: bloc.watchListingList[index],
              margin: EdgeInsets.only(bottom: 16.h),
              onTap: () {
                context.pushNamed(AppRoutes.watchlistDetailsPage, arguments: {RoutesData.watchlistId: bloc.watchListingList[index].id});
              },
            ),
            if (state is WatchlistLoadingMoreState && index == bloc.watchListingList.length - 1) const SmartCircularProgressIndicator(),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(WatchlistBloc bloc, BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 16.0.h),
            child: SmartButton(
                onTap: () {
                  BlocProvider.of<EditWatchlistBloc>(context).add(const EditWatchlistInitialEvent(isEdit: false));
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    builder: (context) {
                      return const EditWatchlistScreen();
                    },
                  );
                },
                title: APPStrings.create.tr),
          ),
          SelectionButton(
            borderRadius: BorderRadius.zero,
            isSelected: false,
            onTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => FilterScreen(
                  onApply: () {},
                ),
              );
            },
            image: AppImages.icFilter,
            title: APPStrings.filter.tr,
          ),
        ],
      ),
    );
  }

  /// Show watchlist bottom sheet with edit and delete option
  void _showWatchlistBottomSheet(BuildContext context) {
    OrderPopupStyle orderPopupStyle = AppTheme.of(context).orderPopupStyle;
    Utils.showSmartModalBottomSheet(
        context: context,
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
                    _buildPopupOption(context, text: APPStrings.editWatchlist.tr, style: orderPopupStyle.optionTextStyle, onTap: () {
                      context.pop();
                      BlocProvider.of<EditWatchlistBloc>(context).add(const EditWatchlistInitialEvent());
                      Utils.showSmartModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        builder: (context) {
                          return const EditWatchlistScreen();
                        },
                      );
                    }),
                    _buildPopupOption(context, text: APPStrings.removeWatchlist.tr, style: orderPopupStyle.cancelTextStyle, onTap: () {
                      context.pop();
                      _buildRemoveWatchlistPopup(context);
                    }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  /// Remove Watchlist Popup
  void _buildRemoveWatchlistPopup(BuildContext context) {
    Utils.showSmartModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (context) => ConfirmationDialog(
        title: APPStrings.removeWatchlistName.tr,
        message: APPStrings.addedXProductsWillBeRemoved.tr.interpolate([56]),
        onApproved: () => context.pop(),
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
