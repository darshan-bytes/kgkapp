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
      ),
      body: _getBody(searchBloc, style: style),
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
                  searchItemBuilder(title: APPStrings.recentSearches.tr, searchList: searchBloc.recentSearchList, style: style),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchItemBuilder({required String title, required List<String> searchList, required SearchScreenStyle style}) {
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
                // context.pushNamed(AppRoutes.searchResultPage, arguments: searchList[index]);
              },
              child: Row(
                children: [
                  SmartText(
                    searchList[index],
                    style: style.searchItemStyle,
                  ),
                  const Spacer(),
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
}
