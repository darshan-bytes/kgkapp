import 'package:kgk/kgk.dart';

class ConceptInfoPopupScreen extends StatelessWidget {
  const ConceptInfoPopupScreen({super.key, required this.imageList, required this.conceptNo, required this.conceptDesc});

  final List<String> imageList;
  final String conceptNo;
  final String conceptDesc;

  @override
  Widget build(BuildContext context) {
    final ConceptInfoPopupScreenStyle style = AppTheme.of(context).conceptInfoPopupScreenStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SmartText(
                    APPStrings.conceptNoX.tr.interpolate([conceptNo]),
                    style: style.titleStyle,
                  ),
                  SizedBox(height: 8.h),
                  SmartText(
                    conceptDesc,
                    style: style.detailsTextStyle,
                  ),
                  SizedBox(height: 16.h),
                  SmartHorizontalItemBuilder(
                      itemCount: imageList.length,
                      listPadding: EdgeInsets.only(bottom: 16.h),
                      itemBetweenSpace: 16.w,
                      itemBuilder: (context, index) {
                        return SmartImage(
                          path: imageList[index],
                          height: 64.h,
                          width: 102.w,
                          imageBorderRadius: BorderRadius.circular(4.r),
                        );
                      }),
                ],
              ),
            ),
            Positioned(
              top: 16.w,
              right: 17.w,
              child: SmartImage(
                path: AppImages.icCross,
                height: 24.w,
                width: 24.w,
                color: style.iconColor,
                onTap: () {
                  context.pop();
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
