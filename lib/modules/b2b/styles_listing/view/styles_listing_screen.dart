import 'package:kgk/kgk.dart';

class StylesListingScreen extends StatelessWidget {
  const StylesListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StylesListingBloc bloc = BlocProvider.of<StylesListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.styles.tr,
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: bloc.paginationScrollController.canScrollToTop,
        onTap: bloc.paginationScrollController.scrollToTop,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<StylesListingBloc, StylesListingState>(
            buildWhen: (previous, current) => current is StylesListingLoadedState,
            builder: (context, state) {
              if (state is StylesListingLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSearchTextField(bloc),
                    Expanded(child: _buildStylesList(bloc)),
                  ],
                );
              } else {
                return const SmartCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField(StylesListingBloc stylesListingBloc) {
    return SmartTextField(
      hintText: APPStrings.searchX.tr.interpolate([APPStrings.styles.tr.toLowerCase()]),
      controller: stylesListingBloc.searchController,
      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
      padding: EdgeInsets.symmetric(vertical: 24.w),
      onTapOutside: (event) {},
    );
  }

  Widget _buildStylesList(StylesListingBloc stylesListingBloc) {
    return BlocBuilder<StylesListingBloc, StylesListingState>(
      buildWhen: (previous, current) => current is StylesListingLoadedMoreState || current is StylesListingLoadingMoreState,
      builder: (context, state) {
        if (stylesListingBloc.stylesList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noStylesFound.tr);
        }
        return RefreshIndicator.adaptive(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 24.h),
            controller: stylesListingBloc.paginationScrollController.scrollController,
            shrinkWrap: true,
            itemCount: stylesListingBloc.stylesList.length,
            itemBuilder: (context, index) {
              return BlocBuilder<StylesListingBloc, StylesListingState>(
                buildWhen: (previous, current) => current is StylesListingLoadingMoreState || current is StylesListingLoadedMoreState,
                builder: (context, state) {
                  B2BCustomListingDataModel stylesItem = stylesListingBloc.stylesList[index];
                  return Column(
                    children: [
                      B2BListingItem(
                        type: B2BListingType.stylesListingType,
                        listingItemModel: stylesItem,
                        onTapMenuButton: () {},
                      ),
                      if (state is StylesListingLoadingMoreState && index == stylesListingBloc.stylesList.length - 1)
                        const SmartCircularProgressIndicator(),
                    ],
                  );
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
          ),
          onRefresh: () async {
            await stylesListingBloc.pullToRefresh();
          },
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(StylesListingBloc stylesListingBloc, BuildContext context) {
    return BlocBuilder<StylesListingBloc, StylesListingState>(
      buildWhen: (previous, current) => current is StylesListingLoadedState,
      builder: (context, state) {
        if (state is StylesListingLoadedState) {
          return SafeArea(
              child: FilterBottomActionBar(
            controller: stylesListingBloc.paginationScrollController.controller,
            onFilterTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => FilterScreen(
                  onApply: () {},
                ),
              );
            },
          ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
