import 'package:kgk/kgk.dart';

class TrashTabviewTileListTile extends StatelessWidget {
  final MessagesBloc messagesBloc;

  const TrashTabviewTileListTile({super.key, required this.messagesBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: messagesBloc.currentController.canScrollToTop,
        onTap: messagesBloc.currentController.scrollToTop,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: SmartTextField.search(
                    height: 48.w,
                    onTapOutside: (p) {},
                    hintText: APPStrings.searchX.tr.interpolate([APPStrings.messages.tr.toLowerCase()]),
                    controller: messagesBloc.trashSearchController,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                  ),
                ),
                SizedBox(width: 16.0.w),
                SelectionButton(
                  width: 48.w,
                  imageHeight: 24.5.w,
                  imageWidth: 24.5.w,
                  isSelected: false,
                  image: AppImages.icMenu,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 24.h),
            messagesBloc.buildListView(context, MessagesTab.trash),
          ],
        ),
      ),
    );
  }
}
