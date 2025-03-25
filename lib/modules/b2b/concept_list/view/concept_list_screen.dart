import 'package:kgk/kgk.dart';

class ConceptListScreen extends StatelessWidget {
  const ConceptListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConceptListBloc conceptListBloc = BlocProvider.of<ConceptListBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.concepts.tr),
      body: BlocBuilder<ConceptListBloc, ConceptListState>(
        buildWhen: (previous, current) => current is ConceptListLoadedState,
        builder: (context, state) {
          if (state is ConceptListLoadedState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.h),
                    SmartTextField(
                      controller: conceptListBloc.searchController,
                      hintText: APPStrings.searchConcept.tr,
                      onFieldSubmitted: (value) => conceptListBloc.add(const ConceptListSearchEvent()),
                      suffixIcon: SmartImage(
                        path: AppImages.icSearchThin,
                        padding: EdgeInsetsDirectional.all(14.w),
                      ),
                      onTapOutside: (event) {},
                    ),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: BlocBuilder<ConceptListBloc, ConceptListState>(
                        buildWhen: (previous, current) => current is ConceptListLoadedState || current is ConceptListLoadedMoreState,
                        builder: (context, state) {
                          if (conceptListBloc.conceptList.isEmpty) {
                            return NoDataFoundWidget(text: APPStrings.noConceptFound.tr);
                          }
                          return RefreshIndicator.adaptive(
                            child: ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsetsDirectional.only(bottom: 34.h),
                              controller: conceptListBloc.paginationScrollController.scrollController,
                              shrinkWrap: true,
                              itemCount: conceptListBloc.conceptList.length,
                              itemBuilder: (context, index) {
                                return BlocBuilder<ConceptListBloc, ConceptListState>(
                                  buildWhen: (previous, current) =>
                                      current is ConceptListLoadingMoreState || current is ConceptListLoadedMoreState,
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        B2BListingItem(
                                          onTap: () {
                                            showConceptDetailBottomSheet(
                                                context: context, concept: conceptListBloc.conceptList[index]);
                                          },
                                          onTapCircleWithText: () {
                                            context.pushNamed(AppRoutes.presentationPage,
                                                arguments: {RoutesData.presentationList: conceptListBloc.conceptList[index].presentationList});
                                          },
                                          type: B2BListingType.conceptListingType,
                                          listingItemModel: conceptListBloc.conceptList[index],
                                        ),
                                        if (state is ConceptListLoadingMoreState && index == conceptListBloc.conceptList.length - 1)
                                          const SmartCircularProgressIndicator(),
                                      ],
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(height: 16.h),
                            ),
                            onRefresh: () async {
                              conceptListBloc.add(ConceptListPullToRefreshEvent(context: context));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<ConceptListBloc, ConceptListState>(
        buildWhen: (previous, current) => current is ConceptListLoadedState,
        builder: (context, state) {
          if (state is ConceptListLoadedState) {
            return FilterBottomActionBar(
              controller: conceptListBloc.paginationScrollController.controller,
              onFilterTap: () {
                Utils.showSmartModalBottomSheet(
                  context: context,
                  builder: (_) => AdvanceFilterScreen(
                    onApply: (value) {
                      if (value != null && value is List<FilterData>) {
                        conceptListBloc.add(ConceptListFilterEvent(filterData: value, context: context));
                      }
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),

      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: conceptListBloc.paginationScrollController.canScrollToTop,
        onTap: conceptListBloc.paginationScrollController.scrollToTop,
      ),
    );
  }

  void showConceptDetailBottomSheet({required BuildContext context, required B2BCustomListingDataModel concept}) {
    List<String> dummy = [];
    if(concept.descriptionImageList.isNotNullNorEmpty){
      for (int i = 0; i < concept.descriptionImageList!.length; i++) {
        dummy.add(concept.descriptionImageList![i]);
      }
    }

    Utils.showSmartModalBottomSheet(
        context: context,
        builder: (context) {
          return ConceptInfoPopupScreen(
            imageList: dummy,
            conceptNo: concept.strConceptNumber ?? '',
            conceptDesc: concept.strDescription ?? '',
          );
        });
  }
}
