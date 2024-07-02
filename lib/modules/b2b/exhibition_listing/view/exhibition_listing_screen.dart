import 'package:kgk/kgk.dart';

class ExhibitionListingScreen extends StatelessWidget {
  const ExhibitionListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExhibitionListingBloc exhibitionListingBloc = BlocProvider.of<ExhibitionListingBloc>(context);
    final ExhibitionListingItemStyle style = AppTheme.of(context).exhibitionListingItemStyle;
    return Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomNavigationBar(exhibitionListingBloc, context),
      body: SafeArea(
        child: BlocBuilder<ExhibitionListingBloc, ExhibitionListingState>(
          buildWhen: (previous, current) => current is ExhibitionListingLoadedState,
          builder: (context, state) {
            return SmartSingleChildScrollView(
              child: Column(
                children: [
                  _buildImageAndText(exhibitionListingBloc, style),
                  SizedBox(
                    height: 24.h,
                  ),
                  _buildCatalogueExhibitionList(exhibitionListingBloc, style),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SmartAppBar _buildAppBar(BuildContext context) {
    return SmartAppBar(
      title: APPStrings.exhibition.tr,
      onSearch: () {
        context.pushNamed(AppRoutes.searchPage);
      },
      onFavorite: () {
        context.pushNamed(AppRoutes.wishListPage);
      },
    );
  }

  Widget _buildBottomNavigationBar(ExhibitionListingBloc bloc, BuildContext context) {
    return FilterBottomActionBar(
      onFilterTap: () {
        Utils.showSmartModalBottomSheet(
          context: context,
          builder: (context) => FilterScreen(
            onApply: () {},
          ),
        );
      },
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

  Widget _buildCatalogueExhibitionList(ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            APPStrings.exhibitions.tr,
            style: style.listTextStyle,
          ),
          SizedBox(
            height: 16.h,
          ),
          SmartTextField(
            hintText: APPStrings.searchX.tr.interpolate([APPStrings.exhibition.tr.toLowerCase()]),
            prefixIcon: SmartImage(
              path: AppImages.icSearchThin,
              padding: EdgeInsets.all(17.w),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          _buildExhibitionCatalogueList(bloc, style),
          _buildExhibitionSubList(bloc, style),
        ],
      ),
    );
  }

  Widget _buildExhibitionCatalogueList(ExhibitionListingBloc bloc, ExhibitionListingItemStyle style) {
    return ListView.builder(
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
        );
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
          margin: EdgeInsets.only(bottom: 40.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SmartText(
                item.title,
                style: style.listTextStyle,
              ),
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: bloc.exhibitionSubList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartText(
                          bloc.exhibitionSubList[index].name,
                          maxLines: 2,
                          style: style.listTitleStyle,
                        ),
                        SizedBox(height: 8.h),
                        SmartText(
                          bloc.exhibitionSubList[index].author,
                          style: style.listAuthorStyle,
                        ),
                        SizedBox(height: 12.h),
                        if (bloc.exhibitionSubList[index].status != null) _buildStatusBadge(style, bloc.exhibitionSubList[index].status!),
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
        status.tr,
        style: style.listStatusStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
