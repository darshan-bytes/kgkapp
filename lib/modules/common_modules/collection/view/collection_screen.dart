import 'package:kgk/kgk.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionViewStyle style = AppTheme.of(context).collectionViewStyle;
    final CollectionBloc bloc = BlocProvider.of<CollectionBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.collection.tr,
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
        onSearch: () => context.pushNamed(AppRoutes.searchPage),
      ),
      body: _getBody(bloc: bloc, style: style, context: context),
    );
  }

  Widget _getBody({required CollectionBloc bloc, required CollectionViewStyle style, required BuildContext context}) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CollectionBloc, CollectionState>(
            buildWhen: (previous, current) => current is CollectionMasterListLoadedState,
            builder: (context, state) {
              if (state is CollectionMasterListLoadedState) {
                return SmartTabBar(
                  length: bloc.tabs.length,
                  isExpanded: true,
                  isScrollable: true,
                  physics: const ScrollPhysics(),
                  tabAlignment: TabAlignment.start,
                  onTabInitialized: (tabController) {
                    /// Here TabController is initialized
                    bloc.tabController = tabController;
                  },
                  onTapTab: (int index) {
                    bloc.add(ChangeCollectionTabsEvent(context: context, index: index));
                  },
                  tabs: bloc.tabs.map((e) => e.child).toList(),
                  indicatorSize: TabBarIndicatorSize.label,
                  tabBarView: _buildTabBarView(bloc, style: style),
                  // tabBarColor: Colors.red,
                );
              }
              return SmartCircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTabBarView(CollectionBloc bloc, {required CollectionViewStyle style}) {
    return List.generate(bloc.tabs.length, (index) {
      return _buildCollectionItemList(bloc: bloc, style: style);
    });
  }

  Widget _buildCollectionItemList({required CollectionBloc bloc, required CollectionViewStyle style}) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      buildWhen: (previous, current) => current is CollectionMasterListLoadedState || current is CollectionLoadingState,
      builder: (context, state) {
        if (state is CollectionLoadingState) {
          return const SmartCircularProgressIndicator();
        }
        if (state is CollectionMasterListLoadedState) {
          if (bloc.collectionMasterList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
          }
          return BlocBuilder<CollectionBloc, CollectionState>(
            buildWhen: (previous, current) =>
                current is CollectionListLoadedMoreState ||
                current is CollectionListLoadingMoreState ||
                current is CollectionMasterListLoadedState ||
                current is CollectionLoadingState,
            builder: (context, state) {
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  bloc.add(CollectionListPullToRefreshEvent(context));
                },
                child: ListView.builder(
                  controller: bloc.paginationScrollController.controller,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  shrinkWrap: true,
                  itemCount: bloc.collectionMasterList.length,
                  itemBuilder: (context, index) {
                    CollectionDataItemsModel collectionDataModel = bloc.collectionMasterList[index];
                    return Column(
                      children: [
                        SmartImage(
                          onTap: () =>
                              bloc.navigateToJewelleryListingScreen(context: context, collectionName: collectionDataModel.name ?? ""),
                          path: collectionDataModel.image ?? '',
                          width: context.width,
                          fit: BoxFit.contain,
                          margin: EdgeInsets.only(bottom: 16.h),
                        ),
                        if (state is CollectionListLoadingMoreState && index == bloc.collectionMasterList.length - 1)
                          const SmartCircularProgressIndicator()
                      ],
                    );
                  },
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
