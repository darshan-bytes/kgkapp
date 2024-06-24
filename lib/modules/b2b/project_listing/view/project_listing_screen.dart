import 'package:kgk/kgk.dart';

class ProjectListingScreen extends StatelessWidget {
  const ProjectListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectListingBloc projectListingBloc = BlocProvider.of<ProjectListingBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.projects.tr),
      bottomNavigationBar: _buildBottomNavigationBar(projectListingBloc, context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<ProjectListingBloc, ProjectListingState>(
            buildWhen: (previous, current) =>
                current is ProjectListingLoadedState ||
                current is ProjectListingChangeListingTypeState ||
                current is FilterProjectState ||
                current is ProjectListingChangeListingTypeState,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.h),
                  SmartTextField(
                    hintText: APPStrings.searchProjects.tr,
                    controller: projectListingBloc.projectSearchController,
                    onValueChanges: (value) => projectListingBloc.add(const FilterProjectEvent()),
                    suffixIcon: SmartImage(
                      path: AppImages.icSearchThin,
                      padding: EdgeInsets.all(16.w),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: projectListingBloc.filteredProjectList.length,
                      itemBuilder: (context, index) {
                        return B2BListingItem(
                          type: B2BListingType.projectListingType,
                          listingItemModel: projectListingBloc.filteredProjectList[index],
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

  Widget _buildBottomNavigationBar(ProjectListingBloc projectListingBloc, BuildContext context) {
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
