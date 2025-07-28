import 'package:kgk/kgk.dart';

class ExhibitionPlacesTabView extends StatelessWidget {
  final ExhibitionListingBloc exhibitionListingBloc;

  const ExhibitionPlacesTabView({super.key, required this.exhibitionListingBloc});

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
            return SmartSingleChildScrollView(
              key: exhibitionListingBloc.paginationScrollController.gridKey,
              onRefresh: () async {
                exhibitionListingBloc.add(ExhibitionListingPullToRefreshEvent(context: context));
              },
              controller: exhibitionListingBloc.paginationScrollController.controller,
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  _buildImageAndText(context, exhibitionListingBloc, listingItemStyle),
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

  Widget _buildImageAndText(BuildContext context, ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        if (bloc.imageUrl.isNotNullNorEmpty) SmartImage(path: bloc.imageUrl ?? '', width: context.width, fit: BoxFit.cover),
        Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 32.0.h, horizontal: 17.0.w),
          decoration: BoxDecoration(color: style.textBackgroundColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText(bloc.strapiExhibition?.title ?? APPStrings.maximizeYourReach.tr, style: style.titleStyle),
              SizedBox(height: 4.0.h),
              SmartText(
                bloc.strapiExhibition?.description ?? APPStrings.showcaseYourJewelleryExhibitionToAGlobalAudienceOnOurPlatform.tr,
                maxLines: 2,
                style: style.subTitleStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCatalogueExhibitionList(BuildContext context, ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: 24.h), _buildExhibitionSubList(bloc, style)]);
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
              SmartText(APPStrings.exhibitionsInX.tr.interpolate([item.title]), style: style.listTextStyle),
              ListView.separated(
                separatorBuilder: (context, subIndex) => const Divider(),
                itemCount: bloc.exhibitionNameListing[index].exhibitionSubList?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, subIndex) {
                  ExhibitionSubListingModel item = bloc.exhibitionNameListing[index].exhibitionSubList![subIndex];
                  return GestureDetector(
                    onTap: () {
                      /// If user is internal user then navigate to exhibition details page otherwise not navigate
                      UserType userType = BlocProvider.of<AppBloc>(context).userType;
                      if (userType == UserType.internal) {
                        context.pushNamed(AppRoutes.exhibitionDetailsPage, arguments: {RoutesData.exhibitionId: item.id});
                      }
                    },
                    child: Padding(
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
