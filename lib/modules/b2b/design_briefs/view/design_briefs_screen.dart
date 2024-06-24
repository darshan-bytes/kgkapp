import 'package:kgk/kgk.dart';

class DesignBriefsScreen extends StatelessWidget {
  const DesignBriefsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DesignBriefsBloc designBriefsBloc = BlocProvider.of<DesignBriefsBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.designBriefs.tr),
      bottomNavigationBar: _buildBottomNavigationBar(designBriefsBloc, context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<DesignBriefsBloc, DesignBriefsState>(
            buildWhen: (previous, current) => current is DesignBriefsLoadedState || current is FilterDesignBriefsState,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.h),
                  SmartTextField(
                    hintText: APPStrings.searchProjects.tr,
                    controller: designBriefsBloc.designBriefsSearchController,
                    onValueChanges: (value) => designBriefsBloc.add(const FilterDesignBriefsEvent()),
                    suffixIcon: SmartImage(
                      path: AppImages.icSearchThin,
                      padding: EdgeInsets.all(16.w),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: designBriefsBloc.filteredDesignBriefsList.length,
                      itemBuilder: (context, index) {
                        return B2BListingItem(
                          type: B2BListingType.designBriefsType,
                          listingItemModel: designBriefsBloc.filteredDesignBriefsList[index],
                          onTapMenuButton: () {},
                        );
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

  Widget _buildBottomNavigationBar(DesignBriefsBloc designBriefsBloc, BuildContext context) {
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
