import 'package:kgk/kgk.dart';

class InboxTabviewListTile extends StatelessWidget {
  final MessagesBloc messagesBloc;

  const InboxTabviewListTile({super.key, required this.messagesBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller: messagesBloc.inboxSearchController,
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
            messagesBloc.buildListView(context, MessagesTab.inbox),
          ],
        ),
      ),
      floatingActionButton: ScrollToTopFAB(
        canScrollToTop: messagesBloc.currentController.canScrollToTop,
        onTap: messagesBloc.currentController.scrollToTop,
      ),
    );
  }
}
