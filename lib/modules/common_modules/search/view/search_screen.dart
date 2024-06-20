import 'package:kgk/kgk.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);
    final SearchScreenStyle style = AppTheme.of(context).searchScreenStyle;
    return Scaffold(
      appBar: SmartAppBar(
        isSearchBar: true,
        searchController: searchBloc.searchController,
        onTapSuffixIconWithSearchBar: () {
          if (searchBloc.searchController.text.trim().isNotEmpty) {
            context.pushNamed(AppRoutes.searchResultPage, arguments: {
              RoutesData.searchResultData: searchBloc.searchController.text,
              RoutesData.isNoDataFound: true,
            });
          }
        },
      ),
      body: _getBody(searchBloc, style: style),
      bottomNavigationBar: _buildSearchByCategory(searchBloc, style),
    );
  }

  Widget _getBody(SearchBloc searchBloc, {required SearchScreenStyle style}) {
    return SafeArea(
      child: BlocBuilder<SearchBloc, SearchState>(
        buildWhen: (_, current) => current is SearchInitial || current is SearchReloadState,
        builder: (context, state) {
          return SmartSingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                children: [
                  searchItemBuilder(title: APPStrings.popularSearches.tr, searchList: searchBloc.popularSearchList, style: style),
                  SizedBox(height: 24.h),
                  searchItemBuilder(title: APPStrings.recentSearches.tr, searchList: searchBloc.recentSearchList, style: style),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchItemBuilder({required String title, required List<String> searchList, required SearchScreenStyle style}) {
    if (searchList.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(
          title,
          style: style.titleStyle,
          optionalPadding: EdgeInsets.symmetric(vertical: 16.w),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: searchList.length > 5 ? 5 : searchList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.pushNamed(AppRoutes.searchResultPage, arguments: {RoutesData.searchResultData: searchList[index]});
              },
              child: Row(
                children: [
                  Expanded(
                      child: SmartText(
                    searchList[index],
                    style: style.searchItemStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  const SmartImage(path: AppImages.icArrowUpLeft),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
        ),
      ],
    );
  }

  Widget _buildSearchByCategory(SearchBloc searchBloc, SearchScreenStyle style) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<SearchBloc, SearchState>(
          buildWhen: (_, current) => current is SearchInitial || current is SearchReloadState,
          builder: (context, state) {
            return SmartHorizontalItemBuilder(
              backgroundColor: style.searchByCategoryColor,
              itemCount: searchBloc.searchByCategoryList.length,
              title: APPStrings.searchByCategory.tr,
              titleStyle: style.searchByCategoryStyle,
              titleOptionalPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
              listPadding: EdgeInsets.only(bottom: 16.h),
              itemBetweenSpace: 16.w,
              itemBuilder: (context, index) {
                AuctionListModel item = searchBloc.searchByCategoryList[index];
                return SmartImageTitleColumn(
                  title: item.name ?? '',
                  imageSize: 80.w,
                  padding: index == 0 ? EdgeInsets.only(left: 17.w) : EdgeInsets.zero,
                  imageBorderRadius: BorderRadius.circular(40.r),
                  imageColor: style.whiteColor,
                  fit: BoxFit.contain,
                  imageBorder: Border.all(color: style.searchByCategoryItemBorderColor, width: 1.w),
                  imageUrl: item.imageUrl ?? '',
                );
              },
            );
          },
        ),
      ],
    );
  }
}
