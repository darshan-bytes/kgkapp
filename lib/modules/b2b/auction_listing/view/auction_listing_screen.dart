import 'package:kgk/kgk.dart';

class AuctionListingScreen extends StatelessWidget {
  const AuctionListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuctionListingBloc auctionListingBloc = BlocProvider.of<AuctionListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.auctions.tr),
      bottomNavigationBar: _buildBottomNavigationBar(auctionListingBloc, context),
      floatingActionButton: BlocBuilder<PresentationBloc, PresentationState>(
        buildWhen: (previous, current) => current is PresentationLoadedState,
        builder: (context, state) {
          return ScrollToTopFAB(
            canScrollToTop: auctionListingBloc.paginationScrollController.canScrollToTop,
            onTap: auctionListingBloc.paginationScrollController.scrollToTop,
          );
        },
      ),
      body: _getBody(auctionListingBloc),
    );
  }

  Widget _getBody(AuctionListingBloc auctionListingBloc) {
    return SafeArea(
      child: BlocBuilder<AuctionListingBloc, AuctionListingState>(
        buildWhen: (previous, current) => current is AuctionListingLoadedState || current is AuctionListingReloadingState,
        builder: (context, state) {
          if (state is AuctionListingLoadedState || state is AuctionListingReloadingState) {
            return SmartSingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              onRefresh: () async {
                await auctionListingBloc.pullToRefresh();
              },
              controller: auctionListingBloc.paginationScrollController.scrollController,
              padding: EdgeInsets.symmetric(horizontal: 17.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  _buildSearchTextField(auctionListingBloc),
                  SizedBox(height: 24.h),
                  _buildAuctionList(auctionListingBloc),
                ],
              ),
            );
          } else {
            return const SmartCircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildSearchTextField(AuctionListingBloc auctionListingBloc) {
    return SmartTextField.search(
      height: 48.h,
      hintText: APPStrings.searchAuction.tr,
      controller: auctionListingBloc.auctionSearchController,
    );
  }

  Widget _buildAuctionList(AuctionListingBloc auctionListingBloc) {
    return BlocBuilder<AuctionListingBloc, AuctionListingState>(
      buildWhen: (previous, current) => current is AuctionListLoadedMoreState || current is AuctionListLoadingMoreState,
      builder: (context, state) {
        return Column(
          children: [
            if (auctionListingBloc.auctionList.isEmpty)
              NoDataFoundWidget(text: APPStrings.noAuctionsFound.tr)
            else
              ListView.separated(
                itemCount: auctionListingBloc.auctionList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  AuctionListModel auctionListModel = auctionListingBloc.auctionList[index];
                  return AuctionListItem(
                    onTap: () => context.pushNamed(AppRoutes.auctionPage),
                    auctionListModel: auctionListModel,
                    stoneTypeImage: AppImages.icRingThin,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
              ),
            if (state is AuctionListLoadingMoreState) const SmartCircularProgressIndicator(),
            SizedBox(height: 17.h),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(AuctionListingBloc auctionListingBloc, BuildContext context) {
    return BlocBuilder<AuctionListingBloc, AuctionListingState>(
      buildWhen: (previous, current) => current is AuctionListingLoadedState,
      builder: (context, state) {
        if (state is AuctionListingLoadedState) {
          return SafeArea(
            child: FilterBottomActionBar(
              controller: auctionListingBloc.paginationScrollController.controller,
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
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
