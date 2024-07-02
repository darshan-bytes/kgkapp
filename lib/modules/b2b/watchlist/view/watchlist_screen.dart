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
              controller: bloc.paginationScrollController.scrollController,
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

  Widget _buildWatchlistItem(WatchlistBloc bloc, int index, BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      buildWhen: (previous, current) => current is WatchlistLoadingMoreState || current is WatchlistLoadedMoreState,
      builder: (context, state) {
        return Column(
          children: [
            B2BListingItem(
              onTapMenuButton: () {},
              type: B2BListingType.watchlistType,
              listingItemModel: bloc.watchListingList[index],
              margin: EdgeInsets.only(bottom: 16.h),
              onTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  enableDrag: false,
                  builder: (context) {
                    BlocProvider.of<EditWatchlistBloc>(context).add(const EditWatchlistInitialEvent());
                    return const EditWatchlistScreen();
                  },
                );
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
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    builder: (context) {
                      BlocProvider.of<EditWatchlistBloc>(context).add(const EditWatchlistInitialEvent());
                      return const EditWatchlistScreen();
                    },
                  );
                },
                title: APPStrings.create.tr),
          ),
          SelectionButton(
            borderRadius: BorderRadius.zero,
            isSelected: false,
            onTap: () {},
            image: AppImages.icFilter,
            title: APPStrings.filter.tr,
          ),
        ],
      ),
    );
  }
}
