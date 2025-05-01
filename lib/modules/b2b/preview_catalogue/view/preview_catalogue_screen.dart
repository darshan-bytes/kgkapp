import 'package:kgk/kgk.dart';

class PreviewCatalogueScreen extends StatelessWidget {
  const PreviewCatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PreviewCatalogueBloc bloc = BlocProvider.of<PreviewCatalogueBloc>(context);
    final PreviewCatalogueStyle style = AppTheme.of(context).previewCatalogueStyle;
    return Scaffold(appBar: appBarPreferredSize(bloc, context), body: buildBody(bloc, context, style));
  }

  PreferredSizeWidget appBarPreferredSize(PreviewCatalogueBloc bloc, BuildContext context) {
    return PreferredSize(
      preferredSize: context.appBarHeight,
      child: BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
        buildWhen: (previous, current) => current is PreviewCatalogueLoadedState,
        builder: (context, state) {
          return SmartAppBar(
            title: bloc.titleOfCatalogue,
            onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
            onSearch: () => context.pushNamed(AppRoutes.searchPage),
          );
        },
      ),
    );
  }

  Widget buildBody(PreviewCatalogueBloc bloc, BuildContext context, PreviewCatalogueStyle style) {
    return BlocBuilder<PreviewCatalogueBloc, PreviewCatalogueState>(
      buildWhen: (previous, current) => current is PreviewCatalogueLoadedState,
      builder: (context, state) {
        if (state is PreviewCatalogueLoadedState) {
          return Column(
            children: [
              if (bloc.previewCatalogueDataModel?.isPublic == true) _buildCommentAndShareRow(bloc, style, context),
              Expanded(
                child: bloc.isWebView ? WebViewWidget(controller: bloc.webViewController) : _buildCustomCatalogueView(bloc, style, context),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildCommentAndShareRow(PreviewCatalogueBloc bloc, PreviewCatalogueStyle style, BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: style.backgroundColor, borderRadius: BorderRadius.circular(8.w)),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: SmartButton(
              onTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  enableDrag: false,
                  builder: (context) => SharePresentationScreen(isPresentation: false, webUrl: bloc.digitalCatalogueListingModel?.webUrl),
                );
              },
              title: APPStrings.share.tr,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomCatalogueView(PreviewCatalogueBloc bloc, PreviewCatalogueStyle style, BuildContext context) {
    return SmartSingleChildScrollView(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 27.h),
      child: Column(
        children: [
          SmartText(bloc.previewCatalogueDataModel?.title ?? '', style: style.titleStyle),
          SizedBox(height: 12.h),
          SmartText(bloc.previewCatalogueDataModel?.description ?? '', style: style.subTitleStyle, textAlign: TextAlign.center),
          SizedBox(height: 32.h),
          SmartGridView(
            items: List.generate(bloc.productList.length, (index) {
              return ProductGridItem(
                productDetails: bloc.productList[index],
                isBadgeVisible: false,
                isCrtAndGramVisible:
                    (bloc.productList[index].commodity != Commodity.diamond) && (bloc.productList[index].commodity != Commodity.gemstone),
                isHidePriceView: _isHidePriceView(bloc.productList[index].commodity!),
                isCommentSelected: bloc.productList[index].isCommentVisible,
                onCommentTap: () {
                  context.pushNamed(
                    AppRoutes.commentListingPage,
                    arguments: {
                      RoutesData.catalogueId: bloc.digitalCatalogueListingModel?.id ?? "",
                      RoutesData.productId: bloc.productList[index].productId ?? "",
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  bool _isHidePriceView(Commodity commodity) {
    return ![Commodity.jewellery, Commodity.gemstone, Commodity.diamond, Commodity.skuLibrary].contains(commodity);
  }
}
