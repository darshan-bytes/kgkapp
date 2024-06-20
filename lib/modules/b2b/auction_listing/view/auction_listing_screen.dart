import 'package:kgk/kgk.dart';

class AuctionListingScreen extends StatelessWidget {
  const AuctionListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuctionListingBloc auctionListingBloc = BlocProvider.of<AuctionListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.auctions.tr),
      bottomNavigationBar: _buildBottomNavigationBar(auctionListingBloc),
      body: _getBody(auctionListingBloc),
    );
  }

  Widget _getBody(AuctionListingBloc auctionListingBloc) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            _buildSearchTextField(auctionListingBloc),
            SizedBox(height: 24.h),
            Expanded(child: _buildAuctionList(auctionListingBloc)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTextField(AuctionListingBloc auctionListingBloc) {
    return SmartTextField.search(
      height: 48.h,
      onValueChanges: (value) => auctionListingBloc.add(const FilterAuctionsEvent()),
      onFieldSubmitted: (value) => auctionListingBloc.add(const FilterAuctionsEvent()),
      hintText: APPStrings.searchAuction.tr,
      controller: auctionListingBloc.auctionSearchController,
    );
  }

  Widget _buildAuctionList(AuctionListingBloc auctionListingBloc) {
    return BlocBuilder<AuctionListingBloc, AuctionListingState>(
      buildWhen: (previous, current) => current is FilterAuctionsState || current is AuctionListingReloadState,
      builder: (context, state) {
        if (auctionListingBloc.filteredAuctionList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noAuctionsFound.tr);
        } else {
          return ListView.separated(
            itemCount: auctionListingBloc.filteredAuctionList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              AuctionListModel auctionListModel = auctionListingBloc.filteredAuctionList[index];
              return AuctionListItem(
                onTap: () => context.pushNamed(AppRoutes.auctionPage),
                auctionListModel: auctionListModel,
                stoneTypeImage: AppImages.icRingThin,
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
          );
        }
      },
    );
  }

  Widget _buildBottomNavigationBar(AuctionListingBloc auctionListingBloc) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<AuctionListingBloc, AuctionListingState>(
            buildWhen: (previous, current) => current is ChangeAuctionListingPageNumberState,
            builder: (context, state) {
              return SmartPagination(
                pageNumbers: auctionListingBloc.pageNumbers,
                currentPage: auctionListingBloc.selectedPageNumber,
                onPageChanged: (int index, String newValue) {
                  auctionListingBloc.add(ChangeAuctionListingPageNumberEvent(newValue));
                },
              );
            },
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
