import 'package:kgk/kgk.dart';

class AllReviewScreen extends StatelessWidget {
  const AllReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllReviewBloc bloc = BlocProvider.of<AllReviewBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.allReviews.tr),
      body: BlocBuilder<AllReviewBloc, AllReviewState>(
        buildWhen: (previous, current) => (current is AllReviewLoadedState || current is AllReviewLoadedMoreState),
        builder: (context, state) {
          if (state is AllReviewLoadedState || state is AllReviewLoadedMoreState) {
            return ListView.separated(
              controller: bloc.paginationScrollController.scrollController,
              padding: EdgeInsetsDirectional.all(16.w),
              itemCount: bloc.reviewList.length,
              itemBuilder: (context, index) {
                return BlocBuilder<AllReviewBloc, AllReviewState>(
                  buildWhen: (previous, current) =>
                      previous != current && (current is AllReviewLoadedMoreState || current is AllReviewLoadingMoreState),
                  builder: (context, state) {
                    return Column(
                      children: [
                        ProductCustomerReviewWidget(reviewDataModel: bloc.reviewList[index]),
                        if (index == bloc.reviewList.length - 1 && state is AllReviewLoadingMoreState)
                          const SmartCircularProgressIndicator(),
                      ],
                    );
                  },
                );
              },
              separatorBuilder: (_, __) => Divider(height: 32.h),
            );
          } else if (state is AllReviewLoadingState) {
            return const SmartCircularProgressIndicator();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: bloc.paginationScrollController.canScrollToTop,
        onTap: bloc.paginationScrollController.scrollToTop,
      ),
    );
  }
}
