import 'package:kgk/kgk.dart';

class ConceptListScreen extends StatelessWidget {
  const ConceptListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConceptListBloc conceptListBloc = BlocProvider.of<ConceptListBloc>(context);
    return BlocBuilder<ConceptListBloc, ConceptListState>(
      buildWhen: (previous, current) => current is ConceptListLoadedState,
      builder: (context, state) {
        if (state is ConceptListLoadedState) {
          return Scaffold(
            appBar: SmartAppBar(title: APPStrings.concepts.tr),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
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
                        padding: EdgeInsets.all(12.w),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: BlocBuilder<ConceptListBloc, ConceptListState>(
                        buildWhen: (previous, current) => current is ConceptListLoadedState || current is ConceptListLoadedMoreState,
                        builder: (context, state) {
                          if (conceptListBloc.conceptList.isEmpty) {
                            return NoDataFoundWidget(text: APPStrings.noConceptFound.tr);
                          }
                          return ListView.separated(
                            padding: EdgeInsets.only(bottom: 24.h),
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
                                          showConceptDetailBottomSheet(context: context, concept: conceptListBloc.conceptList[index]);
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: SelectionButton(
                borderRadius: BorderRadius.zero,
                isSelected: false,
                onTap: () {},
                image: AppImages.icFilter,
                title: APPStrings.filter.tr,
              ),
            ),
            floatingActionButton: ScrollToTopFAB(
              canScrollToTop: conceptListBloc.paginationScrollController.canScrollToTop,
              onTap: conceptListBloc.paginationScrollController.scrollToTop,
            ),
          );
        } else {
          return const SmartCircularProgressIndicator();
        }
      },
    );
  }

  void showConceptDetailBottomSheet({required BuildContext context, required B2BCustomListingDataModel concept}) {
    Utils.showSmartModalBottomSheet(
        context: context,
        builder: (context) {
          return ConceptInfoPopupScreen(
            imageList: const [
              "https://i.ibb.co/Bq1jYmy/Rectangle-1862.png",
              "https://i.ibb.co/MV2wMVZ/Rectangle-1863.png",
              "https://i.ibb.co/Z8KQJqp/Rectangle-1864.png",
              "https://i.ibb.co/Bq1jYmy/Rectangle-1862.png",
              "https://i.ibb.co/MV2wMVZ/Rectangle-1863.png",
              "https://i.ibb.co/Z8KQJqp/Rectangle-1864.png",
            ],
            conceptNo: concept.strConceptNumber ?? '',
            conceptDesc:
                'A jewellery collection inspired by the moon\'s allure. Rings, necklaces, and earrings that capture its luminous beauty.',
          );
        });
  }
}
