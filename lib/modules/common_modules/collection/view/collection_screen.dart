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
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
      ),
      body: SmartSingleChildScrollView(
        child: Column(children: [
          Container(
            width: context.width,
            margin: EdgeInsets.only(bottom: 20.h),
            height: 176.h,
            color: style.headerBgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmartText(
                  "Explore Collection Set",
                  style: style.headerTitleStyle,
                ),
                SmartText(
                  "Discover our new\ncollections",
                  style: style.headerSubTitleStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          _buildCollectionItemList(bloc: bloc, style: style)
        ]),
      ),
    );
  }

  Widget _buildCollectionItemList({required CollectionBloc bloc, required CollectionViewStyle style}) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      buildWhen: (previous, current) => current is CollectionMasterListLoadedState,
      builder: (context, state) {
        if (state is CollectionMasterListLoadedState) {
          if (bloc.collectionMasterList.isEmpty) {
            return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: bloc.collectionMasterList.length,
            itemBuilder: (context, index) {
              CollectionDataModel collectionDataModel = bloc.collectionMasterList[index];
              return _buildCollectionSubItemList(collectionDataModel: collectionDataModel, context: context, style: style, bloc: bloc);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCollectionSubItemList(
      {required CollectionDataModel collectionDataModel,
      required BuildContext context,
      required CollectionViewStyle style,
      required CollectionBloc bloc}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (collectionDataModel.iId.toString().isNotNullNorEmpty)
          SmartText(collectionDataModel.iId.toString(), style: style.headerTitleStyle),
        ...List.generate(
          collectionDataModel.items?.length ?? 0,
          (subIndex) {
            // TODO: If an image exists, display SmartImage otherwise, show the "NO IMAGE FOUND" text.
            CollectionDataItemsModel item = collectionDataModel.items?[subIndex] ?? CollectionDataItemsModel();
            Widget child;
            if (item.image.isNotNullNorEmpty) {
              child = SmartImage(path: item.image ?? '', width: context.width, fit: BoxFit.fill, margin: EdgeInsets.only(bottom: 16.h));
            } else {
              child = const SmartText("NO IMAGE FOUND");
            }
            return InkWell(
              onTap: () => bloc.navigateToJewelleryListingScreen(context: context, collectionName: item.name ?? ""),
              child: child,
            );
          },
        ),
      ],
    );
  }
}
