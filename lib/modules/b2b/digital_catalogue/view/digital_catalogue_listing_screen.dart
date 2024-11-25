import 'package:kgk/kgk.dart';

class DigitalCatalogueListingScreen extends StatelessWidget {
  const DigitalCatalogueListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DigitalCatalogueBloc digitalCatalogueBloc = BlocProvider.of<DigitalCatalogueBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.catalogue.tr,
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
      ),
      bottomNavigationBar: BlocBuilder<DigitalCatalogueBloc, DigitalCatalogueState>(
        buildWhen: (previous, current) => current is DigitalCatalogueLoadedState,
        builder: (context, state) {
          if (state is DigitalCatalogueLoadedState) {
            return FilterBottomActionBar(
              controller: digitalCatalogueBloc.digitalCatalogueScrollController.controller,
              onFilterTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder: (context) => FilterScreen(
                    onApply: () {},
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      body: SafeArea(
          child: BlocBuilder<DigitalCatalogueBloc, DigitalCatalogueState>(
              buildWhen: (previous, current) => current is DigitalCatalogueLoadedState,
              builder: (context, state) {
                if (state is DigitalCatalogueLoadedState) {
                  return Column(
                    children: [
                      SmartTextField(
                        controller: digitalCatalogueBloc.searchController,
                        hintText: APPStrings.searchCatalogue.tr,
                        suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
                        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
                        onTapOutside: (value) => FocusScope.of(context).unfocus(),
                        onValueChanges: (value) {
                          digitalCatalogueBloc.add(DigitalCatalogueSearchEvent(context: context));
                        },
                        onFieldSubmitted: (value) {
                          digitalCatalogueBloc.add(DigitalCatalogueSearchEvent(context: context));
                        },
                      ),
                      _digitalCatalogueList(digitalCatalogueBloc, context),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })),
    );
  }

  Widget _digitalCatalogueList(DigitalCatalogueBloc digitalCatalogueBloc, BuildContext context) {
    final DigitalCatalogueStyle style = AppTheme.of(context).digitalCatalogueStyle;
    return Expanded(
      child: SmartRefreshIndicator(
        onRefresh: () async {
          await digitalCatalogueBloc.pullToRefresh();
        },
        child: BlocBuilder<DigitalCatalogueBloc, DigitalCatalogueState>(
          bloc: digitalCatalogueBloc,
          buildWhen: (previous, current) => current is DigitalCatalogueLoadedState || current is DigitalCatalogueLoadMoreState,
          builder: (context, state) {
            if ((state is! DigitalCatalogueLoadedState || state is! DigitalCatalogueLoadMoreState) &&
                digitalCatalogueBloc.digitalCatalogueList.isEmpty) {
              return NoDataFoundWidget(text: APPStrings.noCatalogueFound.tr);
            }
            return ListView.separated(
              controller: digitalCatalogueBloc.digitalCatalogueScrollController.controller,
              itemCount: digitalCatalogueBloc.digitalCatalogueList.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 24.h,
                );
              },
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              itemBuilder: (context, index) {
                return BlocBuilder<DigitalCatalogueBloc, DigitalCatalogueState>(
                  buildWhen: (previous, current) => current is DigitalCatalogueLoadingMoreState || current is DigitalCatalogueLoadMoreState,
                  builder: (context, state) {
                    final DigitalCatalogueListingModel item = digitalCatalogueBloc.digitalCatalogueList[index];
                    Widget child = InkWell(
                      onTap: () {
                        context.pushNamed(AppRoutes.previewCataloguePage, arguments: {RoutesData.catalogueData: item});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: style.borderColor, width: 1.w),
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
                                Container(
                                  padding: EdgeInsets.all(16.w),
                                  alignment: Alignment.topRight,
                                  child: SmartImage(
                                    path: AppImages.icMoreVerticalCircle,
                                    imageBorderRadius: BorderRadius.circular(4.0.r),
                                    width: 32.w,
                                    height: 32.w,
                                    onTap: () {},
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmartText(
                                    item.name,
                                    style: style.titleStyle,
                                  ),
                                  Row(
                                    children: [
                                      SmartText(
                                        APPStrings.xProducts.tr.interpolate([item.productCount]),
                                        style: style.subTitleStyle,
                                      ),
                                      const Spacer(),
                                      SmartText(
                                        item.date,
                                        style: style.subTitleStyle,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                    if (state is DigitalCatalogueLoadingMoreState && index == digitalCatalogueBloc.digitalCatalogueList.length - 1) {
                      return Column(
                        children: [child, const SmartCircularProgressIndicator()],
                      );
                    }
                    return child;
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
