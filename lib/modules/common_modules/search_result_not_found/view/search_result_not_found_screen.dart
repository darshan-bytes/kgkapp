import 'package:kgk/kgk.dart';

class SearchResultNotFoundScreen extends StatelessWidget {
  const SearchResultNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchResultScreenStyle searchResultScreenStyle = AppTheme.of(context).searchResultScreenStyle;
    final SearchResultNotFoundStyle style = AppTheme.of(context).searchResultNotFoundStyle;

    final SearchResultNotFoundBloc searchResultNotFoundBloc = BlocProvider.of<SearchResultNotFoundBloc>(context);
    return Scaffold(
      appBar: _buildAppBar(searchResultNotFoundBloc),
      body: _buildBody(searchResultScreenStyle, style, searchResultNotFoundBloc),
    );
  }

  Widget _buildBody(
      SearchResultScreenStyle searchResultScreenStyle, SearchResultNotFoundStyle style, SearchResultNotFoundBloc searchResultNotFoundBloc) {
    return SmartSingleChildScrollView(
      child: BlocBuilder<SearchResultNotFoundBloc, SearchResultNotFoundState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  SmartText(APPStrings.searchResult.tr, style: searchResultScreenStyle.titleStyle),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      SmartText("0", style: searchResultScreenStyle.foundItemStyle),
                      SizedBox(width: 5.w),
                      Flexible(
                        child: SmartText(APPStrings.resultFoundFor.tr, style: searchResultScreenStyle.subTitleStyle),
                      ),
                      SizedBox(width: 5.w),
                      SmartText("''${searchResultNotFoundBloc.appbarTitle}''", style: searchResultScreenStyle.appbarTextStyle),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  SmartText(APPStrings.searchResultNotFoundDesc.tr, style: searchResultScreenStyle.subTitleStyle),
                  SizedBox(height: 24.h),
                  _buildNeedHelpSection(style),
                  SizedBox(height: 40.h),
                  _buildProductList(searchResultNotFoundBloc),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNeedHelpSection(SearchResultNotFoundStyle style) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: style.needHelpColor, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SmartText(APPStrings.needHelp.tr, style: style.needHelpStyle),
          SizedBox(height: 4.h),
          SmartText(APPStrings.reachOutToOurCustomerService.tr, style: style.needHelpTitleStyle),
          SizedBox(height: 2.h),
          SmartText("+91 98765 43210", style: style.phoneNumberStyle),
        ],
      ),
    );
  }

  Widget _buildProductList(SearchResultNotFoundBloc searchResultNotFoundBloc) {
    return BlocBuilder<SearchResultNotFoundBloc, SearchResultNotFoundState>(
      builder: (context, state) {
        if (searchResultNotFoundBloc.productList.isEmpty) {
          return Center(child: SmartText(APPStrings.emptyProducts.tr));
        } else {
          return Column(
            children: [
              SmartGridView(
                  items: searchResultNotFoundBloc.productList.map((ProductDetails productDetails) {
                return ProductGridItem(
                  productDetails: productDetails,
                  onEyeTap: () {},
                  onFavTap: () {},
                  onTap: () {
                    context.pushNamed(AppRoutes.settingDetailPage);
                  },
                );
              }).toList()),
              SizedBox(
                height: 17.h,
              )
            ],
          );
        }
      },
    );
  }

  PreferredSizeWidget _buildAppBar(SearchResultNotFoundBloc searchResultNotFoundBloc) {
    return PreferredSize(
      preferredSize: AppConst.appBarHeight,
      child: BlocBuilder<SearchResultNotFoundBloc, SearchResultNotFoundState>(
        builder: (context, state) {
          return SmartAppBar(
            title: searchResultNotFoundBloc.appbarTitle,
            onFilter: () {
              context.pushNamed(AppRoutes.searchPage);
            },
            onFavorite: () {
              context.pushNamed(AppRoutes.wishListPage);
            },
          );
        },
      ),
    );
  }
}
