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
            buildWhen: (previous, current) => current is ProjectListingLoadedState,
            builder: (context, state) {
              if (state is ProjectListingLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_buildSearchTextField(projectListingBloc), Expanded(child: _buildProjectList(projectListingBloc))],
                );
              } else {
                return const SmartCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField(ProjectListingBloc projectListingBloc) {
    return SmartTextField(
      hintText: APPStrings.searchProjects.tr,
      controller: projectListingBloc.projectSearchController,
      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
      padding: EdgeInsets.symmetric(vertical: 24.w),
    );
  }

  Widget _buildProjectList(ProjectListingBloc projectListingBloc) {
    return BlocBuilder<ProjectListingBloc, ProjectListingState>(
      buildWhen: (previous, current) => current is ProjectListLoadedMoreState || current is ProjectListLoadingMoreState,
      builder: (context, state) {
        return Column(
          children: [
            if (projectListingBloc.projectList.isEmpty)
              NoDataFoundWidget(text: APPStrings.noAuctionsFound.tr)
            else
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: projectListingBloc.paginationScrollController.scrollController,
                  itemCount: projectListingBloc.projectList.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    B2BCustomListingDataModel projectItem = projectListingBloc.projectList[index];
                    return B2BListingItem(
                      type: B2BListingType.projectListingType,
                      listingItemModel: projectItem,
                      onTapMenuButton: () {},
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                ),
              ),
            if (state is ProjectListLoadingMoreState) const SmartCircularProgressIndicator(),
            SizedBox(height: 17.h),
          ],
        );
      },
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
