import 'package:kgk/kgk.dart';

class NewsletterCategoriesTabView extends StatelessWidget {
  final NewsletterBloc bloc;

  const NewsletterCategoriesTabView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: bloc.categoryScrollController.canScrollToTop,
        onTap: bloc.categoryScrollController.scrollToTop,
      ),
      body: Column(
        children: [
          SmartTextField.search(
            height: 48.w,
            padding: EdgeInsets.symmetric(vertical: 24.w),
            hintText: APPStrings.searchCategory.tr,
            controller: bloc.categorySearchController,
          ),
          Expanded(
            child: BlocBuilder<NewsletterBloc, NewsletterState>(
              buildWhen: (previous, current) =>
                  current is NewsletterListLoadedState || current is NewsletterListLoadedMoreState || current is NewsletterLoadingMoreState,
              builder: (context, state) {
                if (bloc.categoryList.isEmpty) {
                  return NoDataFoundWidget(text: APPStrings.noDataFound.tr); // Adjust text based on the selected tab if necessary
                }
                return ListView.builder(
                  itemCount: bloc.categoryList.length,
                  controller: bloc.categoryScrollController.scrollController,
                  itemBuilder: (context, index) {
                    return BlocBuilder<NewsletterBloc, NewsletterState>(
                      buildWhen: (previous, current) => current is NewsletterListLoadedMoreState || current is NewsletterLoadingMoreState,
                      builder: (context, state) {
                        B2BCustomListingDataModel item = bloc.categoryList[index];
                        return Column(
                          children: [
                            _buildCategoryItem(
                                context: context,
                                listingItemModel: item,
                                onTapMenuButton: () {},
                                onTap: () {},
                                margin: EdgeInsets.only(
                                    bottom: (state is NewsletterLoadingMoreState && index == bloc.categoryList.length - 1) ? 0 : 16.h)),
                            if (state is NewsletterLoadingMoreState && index == bloc.categoryList.length - 1)
                              const SmartCircularProgressIndicator(),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required BuildContext context,
    required B2BCustomListingDataModel listingItemModel,
    Function()? onTap,
    Function()? onTapMenuButton,
    EdgeInsets? margin,
  }) {
    final PddListingItemStyle style = AppTheme.of(context).pddListingItemStyle;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: margin,
            padding: EdgeInsets.all(16.0.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0.r),
              border: Border.all(color: style.borderColor),
            ),
            child: Column(
              children: [
                B2BColumnDetailItem(field: B2BItemField(label: APPStrings.name.tr, value: listingItemModel.strName)),
                SizedBox(height: 16.0.h),
                Row(
                  children: [
                    Expanded(
                      child: B2BColumnDetailItem(
                        field: B2BItemField(
                          label: APPStrings.createdBy.tr,
                          value: listingItemModel.strCreatedBy,
                          imageUrl: listingItemModel.strCreatedByImageUrl,
                        ),
                      ),
                    ),
                    Expanded(
                      child: B2BColumnDetailItem(
                        field: B2BItemField(
                          label: APPStrings.createdOn.tr,
                          value: listingItemModel.strCreatedOn,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 14.h,
            right: 14.w,
            child: SmartImage(
              path: AppImages.icMoreHorizontal,
              onTap: onTapMenuButton,
              padding: EdgeInsets.all(4.w),
              inkwellBorderRadius: BorderRadius.circular(4.0.r),
            ),
          ),
        ],
      ),
    );
  }
}
