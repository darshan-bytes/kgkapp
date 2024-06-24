import 'package:kgk/kgk.dart';

class PddListingScreen extends StatelessWidget {
  const PddListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PddListingBloc pddListingBloc = BlocProvider.of<PddListingBloc>(context);
    final diamondListingStyle = AppTheme.of(context).diamondListingStyle;
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.presentations.tr),
      bottomNavigationBar: _buildBottomNavigationBar(pddListingBloc, context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<PddListingBloc, PddListingState>(
            buildWhen: (previous, current) =>
                current is PddListingLoadedState ||
                current is PddListingChangeListingTypeState ||
                current is FilterPresentationState ||
                current is PddListingChangeListingTypeState,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: SmartTextField(
                          hintText: APPStrings.searchPresentation.tr,
                          controller: pddListingBloc.presentationSearchController,
                          onValueChanges: (value) => pddListingBloc.add(const FilterPresentationEvent()),
                          suffixIcon: SmartImage(
                            path: AppImages.icSearchThin,
                            padding: EdgeInsets.all(12.w),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SelectionButton(
                            width: 48.w,
                            isSelected: pddListingBloc.isGrid,
                            image: AppImages.icGrid,
                            selectedButtonColor: diamondListingStyle.gridBackgroundColor,
                            selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
                            selectedButtonIconColor: diamondListingStyle.gridIconColor,
                            unselectedButtonIconColor: diamondListingStyle.listIconColor,
                            unselectedButtonColor: diamondListingStyle.listBackgroundColor,
                            unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                            onTap: () {
                              pddListingBloc.add(const PresentationChangeListingTypeEvent());
                            },
                          ),
                          SelectionButton(
                            width: 48.w,
                            isSelected: !pddListingBloc.isGrid,
                            image: AppImages.icList,
                            selectedButtonColor: diamondListingStyle.gridBackgroundColor,
                            selectedButtonBorderColor: diamondListingStyle.gridBorderColor,
                            selectedButtonIconColor: diamondListingStyle.gridIconColor,
                            unselectedButtonIconColor: diamondListingStyle.listIconColor,
                            unselectedButtonColor: diamondListingStyle.listBackgroundColor,
                            unselectedButtonBorderColor: diamondListingStyle.listBorderColor,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                            onTap: () {
                              pddListingBloc.add(const PresentationChangeListingTypeEvent());
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: pddListingBloc.filteredPresentationList.length,
                      itemBuilder: (context, index) {
                        if (pddListingBloc.isGrid) {
                          return PresentationGridItem(b2bCustomListingDataModel: pddListingBloc.filteredPresentationList[index]);
                        } else {
                          return B2BListingItem(
                            type: B2BListingType.presentationListingType,
                            listingItemModel: pddListingBloc.filteredPresentationList[index],
                          );
                        }
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16.h),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(PddListingBloc pddListingBloc, BuildContext context) {
    return SafeArea(
      child: SelectionButton(
        borderRadius: BorderRadius.zero,
        isSelected: false,
        onTap: () {
          Utils.showSmartModalBottomSheet(
            context: context,
            builder: (context) => FilterScreen(
              onApply: () {},
            ),
          );
        },
        image: AppImages.icFilter,
        title: APPStrings.filter.tr,
      ),
    );
  }
}
