import 'package:kgk/kgk.dart';

class ExhibitionTabView extends StatelessWidget {
  final ExhibitionListingBloc exhibitionListingBloc;
  const ExhibitionTabView({super.key, required this.exhibitionListingBloc});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;
    ExhibitionListingItemStyle listingItemStyle = AppTheme.of(context).exhibitionListingItemStyle;
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: style.dividerColor),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
    );
    return Scaffold(
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: exhibitionListingBloc.paginationScrollController.canScrollToTop,
        onTap: exhibitionListingBloc.paginationScrollController.scrollToTop,
      ),
      body: BlocBuilder<ExhibitionListingBloc, ExhibitionListingState>(
        buildWhen: (previous, current) => current is ExhibitionListingLoadedState || current is ExhibitionListingLoadingState,
        builder: (context, state) {
          if (state is ExhibitionListingLoadingState) {
            return const SmartCircularProgressIndicator();
          }
          if (state is ExhibitionListingLoadedState) {
            return SmartSingleChildScrollView(
              key: exhibitionListingBloc.paginationScrollController.listKey,
              onRefresh: () async {
                exhibitionListingBloc.add(ExhibitionListingPullToRefreshEvent(context: context));
              },
              controller: exhibitionListingBloc.paginationScrollController.scrollController,
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  _buildImageAndText(exhibitionListingBloc, listingItemStyle),
                  SizedBox(height: 24.h),
                  _buildCatalogueExhibitionList(context, exhibitionListingBloc, listingItemStyle),
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

  Widget _buildImageAndText(ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return Column(
      children: [
        SmartImage(
          path: 'https://i.ibb.co/RQj8JGk/Rectangle-651.png',
          width: 390.w,
          height: 283.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 32.0.h, horizontal: 17.0.w),
          decoration: BoxDecoration(
            color: style.textBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText(
                'Maximize your reach',
                style: style.titleStyle,
              ),
              SizedBox(
                height: 4.0.h,
              ),
              SmartText(
                'Showcase your jewellery exhibition to a global audience on our platform.',
                maxLines: 2,
                style: style.subTitleStyle,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCatalogueExhibitionList(BuildContext context, ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartTextField(
          controller: bloc.searchController,
          hintText: APPStrings.searchX.tr.interpolate([APPStrings.exhibition.tr.toLowerCase()]),
          prefixIcon: SmartImage(
            path: AppImages.icSearchThin,
            padding: EdgeInsets.all(17.w),
          ),
          onTapOutside: (value) => FocusScope.of(context).unfocus(),
          onValueChanges: (value) {
            bloc.add(ExhibitionListingSearchEvent(context: context));
          },
          onFieldSubmitted: (value) {
            bloc.add(ExhibitionListingSearchEvent(context: context));
          },
        ),
        SizedBox(
          height: 24.h,
        ),
        _buildExhibitionCatalogueList(bloc, style),
      ],
    );
  }

  Widget _buildExhibitionCatalogueList(ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return BlocBuilder<ExhibitionListingBloc, ExhibitionListingState>(
      buildWhen: (previous, current) =>
          current is ExhibitionListingLoadedState || current is ExhibitionListingReloadState || current is ExhibitionListingLoadingState,
      builder: (context, state) {
        if (state is ExhibitionListingLoadingState) {
          return const SmartCircularProgressIndicator();
        }
        if (state is ExhibitionListingLoadedState) {
          return Column(
            children: [
              ListView.builder(
                itemCount: bloc.exhibitionCatalogueList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final ExhibitionListingModel item = bloc.exhibitionCatalogueList[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 32.0.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: style.borderColor,
                        width: 1.w,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppRoutes.exhibitionDetailsPage, arguments: {
                          RoutesData.exhibitionId: bloc.exhibitionCatalogueList[index].id,
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            children: [
                              SmartImage(
                                path: item.image ?? "",
                                height: 200.h,
                                width: context.width,
                              ),
                              if (item.status != null)
                                Positioned(
                                  top: 16.h,
                                  left: 16.w,
                                  child: _buildStatusBadge(style, item.status!),
                                ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmartText(
                                  item.name,
                                  style: style.listTitleStyle,
                                ),
                                SizedBox(height: 2.h),
                                SmartText(
                                  item.author,
                                  style: style.listAuthorStyle,
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    SmartImage(
                                      path: AppImages.icCalendar,
                                      height: 16.h,
                                      width: 16.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    SmartText(
                                      item.date,
                                      style: style.listSubTitleStyle,
                                    ),
                                    const Spacer(),
                                    SmartImage(
                                      path: AppImages.icClock,
                                      height: 16.h,
                                      width: 16.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    SmartText(
                                      item.time,
                                      style: style.listSubTitleStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    SmartImage(
                                      path: AppImages.icMapPin,
                                      height: 16.h,
                                      width: 16.w,
                                      color: style.iconColor,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    SmartText(
                                      item.location,
                                      style: style.listSubTitleStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (state is ExhibitionListLoadingMoreState) const SmartCircularProgressIndicator(),
              SizedBox(height: 17.h),
            ],
          );
        } else {
          return SmartCircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildExhibitionSubList(ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return ListView.builder(
      itemCount: bloc.exhibitionNameListing.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final ExhibitionListingModel item = bloc.exhibitionNameListing[index];
        return Container(
          margin: EdgeInsets.only(bottom: 24.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SmartText(
                item.title,
                style: style.listTextStyle,
              ),
              ListView.separated(
                separatorBuilder: (context, subIndex) => const Divider(),
                itemCount: bloc.exhibitionNameListing[index].exhibitionSubList?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, subIndex) {
                  ExhibitionSubListingModel item = bloc.exhibitionNameListing[index].exhibitionSubList![subIndex];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartText(
                          item.name ?? '',
                          maxLines: 2,
                          style: style.listTitleStyle,
                        ),
                        SizedBox(height: 8.h),
                        SmartText(
                          item.author,
                          style: style.listAuthorStyle,
                        ),
                        SizedBox(height: 12.h),
                        if (item.status != null) _buildStatusBadge(style, item.status!),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(ExhibitionListingItemStyle style, String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: Border.all(color: style.borderColor, width: 1.w),
      ),
      child: SmartText(
        status,
        style: style.listStatusStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
