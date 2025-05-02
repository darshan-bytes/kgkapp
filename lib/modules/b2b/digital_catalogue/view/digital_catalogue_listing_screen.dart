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
              controller: digitalCatalogueBloc.paginationScrollController.controller,
              onFilterTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder:
                      (_) => AdvanceFilterScreen(
                        onApply: (value) {
                          if (value != null && value is List<FilterData>) {
                            digitalCatalogueBloc.add(DigitalCatalogueFilterEvent(filterData: value, context: context));
                          }
                        },
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
        child: Column(
          children: [
            SmartTextField(
              focusNode: digitalCatalogueBloc.focusNode,
              controller: digitalCatalogueBloc.searchController,
              hintText: APPStrings.searchCatalogue.tr,
              suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsetsDirectional.all(16.w)),
              padding: EdgeInsetsDirectional.symmetric(vertical: 24.w, horizontal: 16.w),
              onTapOutside: (value) => FocusScope.of(context).unfocus(),
              onValueChanges: (value) {
                digitalCatalogueBloc.add(DigitalCatalogueSearchEvent(context: context));
              },
              onFieldSubmitted: (value) {
                digitalCatalogueBloc.add(DigitalCatalogueSearchEvent(context: context));
              },
            ),
            BlocBuilder<DigitalCatalogueBloc, DigitalCatalogueState>(
              buildWhen: (previous, current) => current is DigitalCatalogueLoadedState || current is DigitalCatalogueLoadingState,
              builder: (context, state) {
                if (state is DigitalCatalogueLoadingState) return Expanded(child: Center(child: const SmartCircularProgressIndicator()));
                if (state is DigitalCatalogueLoadedState) {
                  return _digitalCatalogueList(digitalCatalogueBloc, context);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _digitalCatalogueList(DigitalCatalogueBloc digitalCatalogueBloc, BuildContext context) {
    final DigitalCatalogueStyle style = AppTheme.of(context).digitalCatalogueStyle;
    return Expanded(
      child: SmartRefreshIndicator(
        onRefresh: () async {
          digitalCatalogueBloc.add(DigitalCataloguePullToRefreshEvent(context: context));
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
              controller: digitalCatalogueBloc.paginationScrollController.controller,
              itemCount: digitalCatalogueBloc.digitalCatalogueList.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 100.h),
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
                        decoration: BoxDecoration(border: Border.all(color: style.borderColor, width: 1.w)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              children: [
                                SmartImage(path: item.image ?? "", height: 200.h, width: context.width, fit: BoxFit.fill),
                                PositionedDirectional(
                                  top: 10.w,
                                  end: 10.w,
                                  child: PopupMenuButton<PopupMenuOption>(
                                    initialValue: null,
                                    color: style.whiteColor,
                                    style: ButtonStyle(
                                      shadowColor: WidgetStateProperty.all(style.borderColor),
                                      backgroundColor: WidgetStateProperty.all(style.whiteColor),
                                    ),
                                    icon: SmartImage(path: AppImages.icMoreVertical, height: 24.w, width: 24.w),
                                    shadowColor: style.borderColor,
                                    position: PopupMenuPosition.under,
                                    onSelected: (PopupMenuOption option) {
                                      switch (option) {
                                        case PopupMenuOption.share:
                                          digitalCatalogueBloc.add(DigitalCatalogueShareEvent(context: context, index: index));
                                          break;
                                        case PopupMenuOption.remove:
                                          Utils.showDoubleActionDialog(
                                            title: APPStrings.removeCatalogue.tr,
                                            content: APPStrings.removeCatalogueMsg.tr,
                                            okButtonText: APPStrings.remove.tr,
                                            cancelButtonText: APPStrings.cancel.tr,
                                            onOkPressed: () {
                                              digitalCatalogueBloc.add(
                                                DeleteDigitalCatalogueEvent(context: context, catalogueId: item.id ?? ""),
                                              );
                                            },
                                          );
                                          break;
                                      }
                                    },
                                    itemBuilder:
                                        (BuildContext context) => [
                                          PopupMenuItem(value: PopupMenuOption.share, child: SmartText(APPStrings.share.tr)),
                                          PopupMenuItem(value: PopupMenuOption.remove, child: SmartText(APPStrings.remove.tr)),
                                        ],
                                  ),
                                ),
                                PositionedDirectional(
                                  start: 16.w,
                                  top: 16.w,
                                  child: SmartStatusBadge(currentStatus: item.status!, height: 32.h),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.all(16.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SmartText(item.name, style: style.titleStyle),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SmartText(APPStrings.xProducts.tr.interpolate([item.productCount]), style: style.subTitleStyle),
                                      SizedBox(width: 16.w),
                                      Flexible(child: SmartText(item.date, style: style.subTitleStyle, maxLines: 2)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    if (state is DigitalCatalogueLoadingMoreState && index == digitalCatalogueBloc.digitalCatalogueList.length - 1) {
                      return Column(children: [child, const SmartCircularProgressIndicator()]);
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
