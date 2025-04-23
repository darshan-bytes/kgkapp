import 'package:kgk/kgk.dart';

class NewsletterSubscriberTabView extends StatelessWidget {
  final NewsletterBloc bloc;

  const NewsletterSubscriberTabView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: bloc.subscribersScrollController.canScrollToTop,
        onTap: bloc.subscribersScrollController.scrollToTop,
      ),
      body: Column(
        children: [
          SmartTextField.search(
            height: 48.w,
            padding: EdgeInsetsDirectional.symmetric(vertical: 24.w),
            hintText: APPStrings.searchSubscribers.tr,
            controller: bloc.subscribersSearchController,
          ),
          Expanded(
            child: BlocBuilder<NewsletterBloc, NewsletterState>(
              buildWhen:
                  (previous, current) =>
                      current is NewsletterListLoadedState ||
                      current is NewsletterListLoadedMoreState ||
                      current is NewsletterLoadingMoreState,
              builder: (context, state) {
                if (bloc.subscribersList.isEmpty) {
                  return NoDataFoundWidget(text: APPStrings.noDataFound.tr); // Adjust text based on the selected tab if necessary
                }
                return SmartRefreshIndicator(
                  onRefresh: () async {
                    await bloc.pullToRefresh();
                  },
                  child: ListView.builder(
                    itemCount: bloc.subscribersList.length,
                    controller: bloc.subscribersScrollController.scrollController,
                    itemBuilder: (context, index) {
                      return BlocBuilder<NewsletterBloc, NewsletterState>(
                        buildWhen: (previous, current) => current is NewsletterListLoadedMoreState || current is NewsletterLoadingMoreState,
                        builder: (context, state) {
                          B2BCustomListingDataModel item = bloc.subscribersList[index];
                          return Column(
                            children: [
                              B2BListingItem(
                                columns: 1,
                                listingItemModel: item,
                                type: B2BListingType.newsletterSubscribersType,
                                onTapMenuButton: () {},
                                onTap: () {},
                                margin: EdgeInsetsDirectional.only(
                                  bottom: (state is NewsletterLoadingMoreState && index == bloc.subscribersList.length - 1) ? 0 : 16.h,
                                ),
                              ),
                              if (state is NewsletterLoadingMoreState && index == bloc.subscribersList.length - 1)
                                const SmartCircularProgressIndicator(),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
