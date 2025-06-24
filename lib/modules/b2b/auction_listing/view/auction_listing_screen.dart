import 'package:kgk/kgk.dart';

class AuctionListingScreen extends StatelessWidget {
  const AuctionListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuctionListingBloc auctionListingBloc = BlocProvider.of<AuctionListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.auctions.tr),
      bottomNavigationBar: _buildBottomNavigationBar(auctionListingBloc, context),
      floatingActionButton: BlocBuilder<AuctionListingBloc, AuctionListingState>(
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
        buildWhen:
            (previous, current) =>
                current is AuctionListingLoadedState || current is AuctionListingReloadingState || current is AuctionListingLoadingState,
        builder: (context, state) {
          if (state is AuctionListingLoadingState) {
            return const SmartCircularProgressIndicator();
          }
          if (state is AuctionListingLoadedState || state is AuctionListingReloadingState) {
            return Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  _buildSearchTextField(auctionListingBloc, context),
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

  Widget _buildSearchTextField(AuctionListingBloc auctionListingBloc, BuildContext context) {
    return SmartTextField.search(
      height: 48.h,
      hintText: APPStrings.searchAuction.tr,
      controller: auctionListingBloc.auctionSearchController,
      onTapOutside: (value) => FocusScope.of(context).unfocus(),
      onValueChanges: (value) {
        auctionListingBloc.add(AuctionListSearchEvent(context: context));
      },
      onFieldSubmitted: (value) {
        auctionListingBloc.add(AuctionListSearchEvent(context: context));
      },
    );
  }

  Widget _buildAuctionList(AuctionListingBloc auctionListingBloc) {
    return Expanded(
      child: BlocBuilder<AuctionListingBloc, AuctionListingState>(
        buildWhen: (previous, current) => current is AuctionListLoadedMoreState || current is AuctionListLoadingMoreState,
        builder: (context, state) {
          if (auctionListingBloc.originalAuctionList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noAuctionsFound.tr);
          }
          return SmartSingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            onRefresh: () async {
              auctionListingBloc.add(AuctionListPullToRefreshEvent(context: context));
            },
            controller: auctionListingBloc.paginationScrollController.scrollController,
            child: Column(
              children: [
                ListView.separated(
                  itemCount: auctionListingBloc.originalAuctionList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 40.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    AuctionListModel auctionListModel = auctionListingBloc.originalAuctionList[index];
                    return AuctionListItem(auctionListModel: auctionListModel, stoneTypeImage: AppImages.icRingThin);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                ),
                if (state is AuctionListLoadingMoreState) const SmartCircularProgressIndicator(),
                SizedBox(height: 17.h),
              ],
            ),
          );
        },
      ),
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
                  builder:
                      (context) => AdvanceFilterScreen(
                        onApply: (value) {
                          if (value != null && value is List<FilterData>) {
                            auctionListingBloc.add(AuctionListFilterEvent(filterData: value, context: context));
                          }
                        },
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
