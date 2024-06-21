import 'package:kgk/kgk.dart';

class ConceptListScreen extends StatelessWidget {
  const ConceptListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConceptListBloc conceptListBloc = BlocProvider.of<ConceptListBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.concepts.tr),
      body: SafeArea(
        child: SmartSingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              BlocBuilder<ConceptListBloc, ConceptListState>(
                buildWhen: (previous, current) => current is ConceptListLoadedState,
                builder: (context, state) {
                  if (conceptListBloc.conceptList.isEmpty) {
                    return NoDataFoundWidget(text: APPStrings.noConceptFound.tr);
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: conceptListBloc.conceptList.length,
                    itemBuilder: (context, index) {
                      return B2BListingItem(
                        type: B2BListingType.conceptListingType,
                        listingItemModel: conceptListBloc.conceptList[index],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  );
                },
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
    );
  }
}
