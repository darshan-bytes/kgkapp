import 'package:kgk/kgk.dart';

class AuctionListingScreen extends StatelessWidget {
  const AuctionListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuctionListingBloc bloc = BlocProvider.of<AuctionListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.auctions.tr),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: BlocBuilder<AuctionListingBloc, AuctionListingState>(
        buildWhen: (previous, current) => current is PresentationLoadedState,
        builder: (context, state) {
          return ScrollToTopFAB(
            canScrollToTop: bloc.paginationScrollController.canScrollToTop,
            onTap: bloc.paginationScrollController.scrollToTop,
          );
        },
      ),
      body: _getBody(bloc),
    );
  }

  Widget _getBody(AuctionListingBloc bloc) {
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
                children: [SizedBox(height: 24.h), _buildSearchTextField(bloc, context), SizedBox(height: 24.h), _buildAuctionList(bloc)],
              ),
            );
          } else {
            return const SmartCircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget _buildSearchTextField(AuctionListingBloc bloc, BuildContext context) {
    return SmartTextField.search(
      height: 48.h,
      hintText: APPStrings.searchAuction.tr,
      controller: bloc.auctionSearchController,
      onTapOutside: (value) => FocusScope.of(context).unfocus(),
      onValueChanges: (value) {
        bloc.add(AuctionListSearchEvent(context: context));
      },
      onFieldSubmitted: (value) {
        bloc.add(AuctionListSearchEvent(context: context));
      },
    );
  }

  Widget _buildAuctionList(AuctionListingBloc bloc) {
    return Expanded(
      child: BlocBuilder<AuctionListingBloc, AuctionListingState>(
        buildWhen: (previous, current) => current is AuctionListLoadedMoreState || current is AuctionListLoadingMoreState,
        builder: (context, state) {
          if (bloc.originalAuctionList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noAuctionsFound.tr);
          }
          return SmartSingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            onRefresh: () async {
              bloc.add(AuctionListPullToRefreshEvent(context: context));
            },
            controller: bloc.paginationScrollController.scrollController,
            child: Column(
              children: [
                ListView.separated(
                  itemCount: bloc.originalAuctionList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 40.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    AuctionListModel auctionListModel = bloc.originalAuctionList[index];
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

  Widget _buildBottomNavigationBar(AuctionListingBloc bloc, BuildContext context) {
    return BlocBuilder<AuctionListingBloc, AuctionListingState>(
      buildWhen: (previous, current) => current is AuctionListingLoadedState,
      builder: (context, state) {
        if (state is AuctionListingLoadedState) {
          return SafeArea(
            child: FilterBottomActionBar(
              controller: bloc.paginationScrollController.controller,
              onFilterTap: () {
                BlocProvider.of<AdvanceSortFilterBloc>(
                  context,
                ).add(AddAdvanceSortFilterDataEvent(filterOptionList: bloc.filterData, context: context));
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AdvanceFilterScreen(
                      onApply: (value) {
                        if (value != null && value is List<FilterData>) {
                          bloc.add(AuctionListFilterEvent(filterData: value, context: context));
                        }
                      },
                    );
                  },
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
