import 'package:kgk/kgk.dart';

class ProjectListingScreen extends StatelessWidget {
  const ProjectListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectListingBloc projectListingBloc = BlocProvider.of<ProjectListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.projects.tr),
      bottomNavigationBar: _buildBottomNavigationBar(projectListingBloc, context),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: projectListingBloc.paginationScrollController.canScrollToTop,
        onTap: projectListingBloc.paginationScrollController.scrollToTop,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<ProjectListingBloc, ProjectListingState>(
            buildWhen: (previous, current) => current is ProjectListingLoadedState,
            builder: (context, state) {
              if (state is ProjectListingLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_buildSearchTextField(projectListingBloc), _buildProjectList(projectListingBloc)],
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
      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsetsDirectional.all(16.w)),
      padding: EdgeInsetsDirectional.symmetric(vertical: 24.w),
      onTapOutside: (event) {},
    );
  }

  Widget _buildProjectList(ProjectListingBloc projectListingBloc) {
    return Expanded(
      child: BlocBuilder<ProjectListingBloc, ProjectListingState>(
        buildWhen: (previous, current) => current is ProjectListLoadedMoreState || current is ProjectListLoadingMoreState,
        builder: (context, state) {
          return Column(
            children: [
              if (projectListingBloc.projectList.isEmpty)
                NoDataFoundWidget(text: APPStrings.noAuctionsFound.tr)
              else
                Expanded(
                  child: RefreshIndicator.adaptive(
                    child: ListView.separated(
                      shrinkWrap: true,
                      controller: projectListingBloc.paginationScrollController.scrollController,
                      itemCount: projectListingBloc.projectList.length,
                      itemBuilder: (context, index) {
                        B2BCustomListingDataModel projectItem = projectListingBloc.projectList[index];
                        return B2BListingItem(
                          type: B2BListingType.projectListingType,
                          listingItemModel: projectItem,
                          onTapMenuButton: () {},
                          onTap: () {
                            context.pushNamed(AppRoutes.designBriefsPage);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16.h),
                    ),
                    onRefresh: () async {
                      await projectListingBloc.pullToRefresh();
                    },
                  ),
                ),
              if (state is ProjectListLoadingMoreState) const SmartCircularProgressIndicator(),
              SizedBox(height: 17.h),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(ProjectListingBloc projectListingBloc, BuildContext context) {
    return BlocBuilder<ProjectListingBloc, ProjectListingState>(
      buildWhen: (previous, current) => current is ProjectListingLoadedState,
      builder: (context, state) {
        if (state is ProjectListingLoadedState) {
          return SafeArea(
            child: FilterBottomActionBar(
              controller: projectListingBloc.paginationScrollController.controller,
              onFilterTap: () {
                Utils.showSmartModalBottomSheet(context: context, builder: (context) => FilterScreen(onApply: () {}));
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
