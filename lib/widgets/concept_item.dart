import 'package:kgk/kgk.dart';

class ConceptItem extends StatelessWidget {
  final ConceptListModel conceptListModel;
  final Function() onTap;

  const ConceptItem({super.key, required this.conceptListModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ConceptListingStyle style = AppTheme.of(context).conceptListingStyle;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0.r),
          border: Border.all(
            width: 1.w,
            color: style.borderColor,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmartImage(
                  path: AppImages.icBadge,
                  height: 24.w,
                  width: 24.w,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: SmartText(
                      conceptListModel.id,
                      style: style.titleStyle,
                    )),
                Expanded(
                    flex: 4,
                    child: SmartText(
                      conceptListModel.name,
                      style: style.titleStyle,
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    flex: 2,
                    child: SmartText(
                      conceptListModel.designId,
                      style: style.titleStyle,
                    )),
              ],
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmartText(
                  conceptListModel.origin,
                  style: style.titleStyle,
                ),
                SmartStatusBadge(
                  currentStatus: conceptListModel.status ?? ProjectStatus.wip,
                ),
                SmartText(
                  conceptListModel.date,
                  style: style.titleStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
