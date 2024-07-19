import 'package:kgk/kgk.dart';

class PresentationScreen extends StatelessWidget {
  const PresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PresentationBloc bloc = BlocProvider.of<PresentationBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.presentations.tr.toUpperCamelCase),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: BlocBuilder<PresentationBloc, PresentationState>(
        buildWhen: (previous, current) => current is PresentationLoadedState,
        builder: (context, state) {
          return ScrollToTopFAB(
            canScrollToTop: bloc.paginationScrollController.canScrollToTop,
            onTap: bloc.paginationScrollController.scrollToTop,
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<PresentationBloc, PresentationState>(
            buildWhen: (previous, current) => current is PresentationLoadedState,
            builder: (context, state) {
              if (state is PresentationLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.h),
                    SmartTextField(
                      hintText: APPStrings.searchPresentation.tr,
                      controller: bloc.presentationSearchController,
                      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
                      onTapOutside: (val) {},
                      textInputAction: TextInputAction.search,
                    ),
                    _buildPresentationList(bloc),
                  ],
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

  Widget _buildPresentationList(PresentationBloc bloc) {
    return Expanded(
      child: BlocBuilder<PresentationBloc, PresentationState>(
        buildWhen: (previous, current) => current is PresentationListLoadedMoreState || current is PresentationListLoadingMoreState,
        builder: (context, state) {
          if (bloc.presentationList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
          }
          return SmartRefreshIndicator(
            onRefresh: () async {
              await bloc.pullToRefresh();
            },
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 24.w),
              controller: bloc.paginationScrollController.scrollController,
              itemCount: bloc.presentationList.length,
              itemBuilder: (context, index) {
                B2BCustomListingDataModel presentationItem = bloc.presentationList[index];
                return BlocBuilder<PresentationBloc, PresentationState>(
                  buildWhen: (previous, current) =>
                      current is PresentationListLoadedMoreState || current is PresentationListLoadingMoreState,
                  builder: (context, state) {
                    return Column(
                      children: [
                        B2BListingItem(
                          type: B2BListingType.presentationType,
                          listingItemModel: presentationItem,
                          onTapMenuButton: () {},
                          onTap: () {},
                        ),
                        if (index == bloc.presentationList.length - 1 && state is PresentationListLoadingMoreState)
                          const SmartCircularProgressIndicator(),
                      ],
                    );
                  },
                );
              },
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(PresentationBloc bloc, BuildContext context) {
    return SafeArea(
        child: FilterBottomActionBar(
      controller: bloc.paginationScrollController.controller,
      onFilterTap: () {
        Utils.showSmartModalBottomSheet(
          context: context,
          builder: (context) => FilterScreen(
            onApply: () {},
          ),
        );
      },
    ));
  }
}
