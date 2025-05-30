import 'package:kgk/kgk.dart';

class ExhibitionTabView extends StatelessWidget {
  final ExhibitionListingBloc exhibitionListingBloc;

  const ExhibitionTabView({super.key, required this.exhibitionListingBloc});

  @override
  Widget build(BuildContext context) {
    ExhibitionListingItemStyle listingItemStyle = AppTheme.of(context).exhibitionListingItemStyle;
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
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                exhibitionListingBloc.add(ExhibitionListingPullToRefreshEvent(context: context));
              },
              child: CustomScrollView(
                shrinkWrap: true,
                controller: exhibitionListingBloc.paginationScrollController.controller,
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                key: exhibitionListingBloc.paginationScrollController.listKey,
                slivers: <Widget>[
                  SliverToBoxAdapter(child: _buildImageAndText(exhibitionListingBloc, listingItemStyle)),
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    toolbarHeight: 80.h,
                    foregroundColor: listingItemStyle.backgroundColor,
                    backgroundColor: listingItemStyle.backgroundColor,
                    surfaceTintColor: listingItemStyle.backgroundColor,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    title: SmartTextField(
                      controller: exhibitionListingBloc.searchController,
                      hintText: APPStrings.searchX.tr.interpolate([APPStrings.exhibition.tr.toLowerCase()]),
                      prefixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsetsDirectional.all(17.w)),
                      onTapOutside: (value) => FocusScope.of(context).unfocus(),
                      onValueChanges: (value) {
                        exhibitionListingBloc.add(ExhibitionListingSearchEvent(context: context));
                      },
                      onFieldSubmitted: (value) {
                        exhibitionListingBloc.add(ExhibitionListingSearchEvent(context: context));
                      },
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(childCount: exhibitionListingBloc.exhibitionCatalogueList.length, (
                      context,
                      index,
                    ) {
                      final ExhibitionListingModel item = exhibitionListingBloc.exhibitionCatalogueList[index];
                      return _buildExhibitionCatalogueListItem(context: context, item: item, style: listingItemStyle);
                    }),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 48.h)),
                ],
              ),
            );
          }
          return const SmartCircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildImageAndText(ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        SmartImage(path: 'https://i.ibb.co/RQj8JGk/Rectangle-651.png', width: 390.w, height: 283.h),
        Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 32.0.h, horizontal: 17.0.w),
          decoration: BoxDecoration(color: style.textBackgroundColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText(APPStrings.maximizeYourReach.tr, style: style.titleStyle),
              SizedBox(height: 4.0.h),
              SmartText(
                APPStrings.showcaseYourJewelleryExhibitionToAGlobalAudienceOnOurPlatform.tr,
                maxLines: 2,
                style: style.subTitleStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExhibitionCatalogueListItem({
    required BuildContext context,
    required ExhibitionListingModel item,
    required ExhibitionListingItemStyle style,
  }) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 16.0.h),
      decoration: BoxDecoration(border: Border.all(color: style.borderColor, width: 1.w)),
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
        onTap: () {
          /// If user is internal user then navigate to exhibition details page otherwise not navigate
          UserType userType = BlocProvider.of<AppBloc>(context).userType;
          if (userType == UserType.internal) {
            context.pushNamed(AppRoutes.exhibitionDetailsPage, arguments: {RoutesData.exhibitionId: item.id});
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SmartImage(path: item.image ?? "", fit: BoxFit.cover),
                if (item.status != null) PositionedDirectional(top: 16.h, start: 16.w, child: _buildStatusBadge(style, item.status!)),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.all(16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartText(item.name, style: style.listTitleStyle),
                  SizedBox(height: 2.h),
                  SmartText(item.author, style: style.listAuthorStyle),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            SmartImage(path: AppImages.icCalendar, height: 16.h, width: 16.w),
                            SizedBox(width: 2.w),
                            SmartText(item.date, style: style.listSubTitleStyle),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SmartImage(path: AppImages.icClock, height: 16.h, width: 16.w),
                            SizedBox(width: 2.w),
                            SmartText(item.time, style: style.listSubTitleStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      SmartImage(path: AppImages.icMapPin, height: 16.h, width: 16.w, color: style.iconColor),
                      SizedBox(width: 2.w),
                      SmartText(item.location, style: style.listSubTitleStyle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
          margin: EdgeInsetsDirectional.only(bottom: 24.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SmartText(item.title, style: style.listTextStyle),
              ListView.separated(
                separatorBuilder: (context, subIndex) => const Divider(),
                itemCount: bloc.exhibitionNameListing[index].exhibitionSubList?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, subIndex) {
                  ExhibitionSubListingModel item = bloc.exhibitionNameListing[index].exhibitionSubList![subIndex];
                  return Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartText(item.name ?? '', maxLines: 2, style: style.listTitleStyle),
                        SizedBox(height: 8.h),
                        SmartText(item.author, style: style.listAuthorStyle),
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
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(color: style.backgroundColor, border: Border.all(color: style.borderColor, width: 1.w)),
      child: SmartText(status, style: style.listStatusStyle, textAlign: TextAlign.center),
    );
  }
}
