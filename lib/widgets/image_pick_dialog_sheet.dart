import 'package:kgk/kgk.dart';

class ImagePickDialogSheet extends StatelessWidget {
  final Function(ImageSource) onTapSource;

  const ImagePickDialogSheet({super.key, required this.onTapSource});

  @override
  Widget build(BuildContext context) {
    final ProductMenuBottomSheetStyle style = AppTheme.of(context).productMenuBottomSheetStyle;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAppBar(context, style),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: pickOption(context, icon: AppImages.icCamera, label: APPStrings.camera.tr, onTap: () {
                            Navigator.pop(context);
                            onTapSource(ImageSource.camera);
                          }),
                        ),
                        Expanded(
                          child: pickOption(context, icon: AppImages.icImage, label: APPStrings.gallery.tr, onTap: () {
                            Navigator.pop(context);
                            onTapSource(ImageSource.gallery);
                          }),
                        )
                      ],
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pickOption(context, {required String icon, required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 72.w,
              width: 72.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              alignment: Alignment.center,
              child: SmartImage(
                path: icon,
              )),
          SmartText(
            label,
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ProductMenuBottomSheetStyle style) {
    return SmartAppBar(
      isBack: false,
      appBarHeight: 56.h,
      isBorder: false,
      backgroundColor: style.backgroundColor,
      actions: [
        InkWell(
          onTap: () {
            context.pop();
          },
          child: SmartImage(
            path: AppImages.icCross,
            color: style.primaryColor,
          ),
        ),
      ],
    );
  }
}
