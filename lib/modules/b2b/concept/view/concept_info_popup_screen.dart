import 'package:kgk/kgk.dart';

class ConceptInfoPopupScreen extends StatelessWidget {
  final List<String> imageList;
  final String conceptNo;
  final String conceptDesc;

  ConceptInfoPopupScreen({super.key, required this.imageList, required this.conceptNo, required this.conceptDesc});

  final ScrollController _scrollController = ScrollController();

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
              padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SmartText(APPStrings.conceptNoX.tr.interpolate([conceptNo]), style: style.titleStyle),
                  SizedBox(height: 8.h),
                  SmartText(conceptDesc, style: style.detailsTextStyle),
                  SizedBox(height: 16.h),
                  if (imageList.isNotEmpty)
                    Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: SmartHorizontalItemBuilder(
                        scrollController: _scrollController,
                        itemCount: imageList.length,
                        listPadding: EdgeInsetsDirectional.only(bottom: 16.h),
                        itemBetweenSpace: 16.w,
                        itemBuilder: (context, index) {
                          return SmartImage(
                            path: imageList[index],
                            height: 64.h,
                            width: 102.w,
                            fit: BoxFit.fill,
                            imageBorderRadius: BorderRadius.circular(4.r),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 16.w,
              end: 17.w,
              child: SmartImage(
                path: AppImages.icCross,
                height: 24.w,
                width: 24.w,
                color: style.iconColor,
                onTap: () {
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
