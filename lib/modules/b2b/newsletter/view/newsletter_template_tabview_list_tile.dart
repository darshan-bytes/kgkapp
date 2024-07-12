import 'package:kgk/kgk.dart';

class NewsletterTemplateTabView extends StatelessWidget {
  final NewsletterBloc bloc;

  const NewsletterTemplateTabView({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final NewsletterScreenStyle style = AppTheme.of(context).newsletterScreenStyle;
    return Scaffold(
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: bloc.templateScrollController.canScrollToTop,
        onTap: bloc.templateScrollController.scrollToTop,
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          _buildTemplateItemList(style: style),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return SmartTextField.search(
      height: 48.w,
      padding: EdgeInsets.symmetric(vertical: 24.w),
      hintText: APPStrings.searchTemplate.tr,
      controller: bloc.templateSearchController,
      onTapOutside: (event) {},
      textInputAction: TextInputAction.search,
    );
  }

  Widget _buildTemplateItemList({required NewsletterScreenStyle style}) {
    return Expanded(
      child: BlocBuilder<NewsletterBloc, NewsletterState>(
        buildWhen: (previous, current) =>
            current is NewsletterListLoadedState ||
            current is NewsletterListLoadedMoreState ||
            current is NewsletterLoadingMoreState ||
            current is ChangeNewsletterTabsState,
        builder: (context, state) {
          if (state is NewsletterListLoadedState ||
              state is NewsletterListLoadedMoreState ||
              state is NewsletterLoadingMoreState ||
              state is ChangeNewsletterTabsState) {
            if (bloc.templateList.isEmpty) {
              return NoDataFoundWidget(text: APPStrings.noDataFound.tr); // Adjust text based on the selected tab if necessary
            }
            return ListView.builder(
              itemCount: bloc.templateList.length,
              controller: bloc.templateScrollController.scrollController,
              itemBuilder: (context, index) {
                TemplateListModel templateListModel = bloc.templateList[index];

                return _buildTemplateSubItemList(
                  templateListModel: templateListModel,
                  isLastItem: index == bloc.templateList.length - 1 && state is NewsletterLoadingMoreState,
                  context: context,
                  padding: EdgeInsets.only(
                    bottom: (state is NewsletterLoadingMoreState && index == bloc.templateList.length - 1) ? 0 : 24.h,
                  ),
                  style: style,
                );
              },
            );
          }

          return const SmartCircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildTemplateSubItemList(
      {required TemplateListModel templateListModel,
      bool isLastItem = false,
      required BuildContext context,
      required EdgeInsets padding,
      required NewsletterScreenStyle style}) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (templateListModel.title.isNotNullNorEmpty) SmartText(templateListModel.title, style: style.labelStyle),
          SizedBox(height: 16.h),
          ...List.generate(
            templateListModel.templateSubList?.length ?? 0,
            (subIndex) {
              B2BCustomListingDataModel item = templateListModel.templateSubList?[subIndex] ?? B2BCustomListingDataModel();
              return _buildTemplateItem(
                context: context,
                onTap: () {},
                onTapMenuButton: () {},
                listingItemModel: item,
                margin: EdgeInsets.only(
                  bottom: subIndex == (templateListModel.templateSubList?.length ?? 0) - 1 ? 0 : 16.h,
                ),
              );
            },
          ),
          if (isLastItem) const SmartCircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildTemplateItem({
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
                          label: APPStrings.status.tr,
                          orderStatus: listingItemModel.status,
                        ),
                      ),
                    ),
                    Expanded(
                      child: B2BColumnDetailItem(
                        field: B2BItemField(
                            label: APPStrings.country.tr,
                            value: listingItemModel.strCountry,
                            isCircleImage: false,
                            imageUrl: listingItemModel.strCountryImageUrl),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0.h),
                Row(
                  children: [
                    Expanded(
                      child: B2BColumnDetailItem(
                        field: B2BItemField(
                          label: APPStrings.validity.tr,
                          value: listingItemModel.strValidity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: B2BColumnDetailItem(
                        field: B2BItemField(
                            label: APPStrings.createdBy.tr,
                            value: listingItemModel.strCreatedBy,
                            imageUrl: listingItemModel.strCreatedByImageUrl),
                      ),
                    ),
                  ],
                ),
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
