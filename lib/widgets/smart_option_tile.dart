import 'package:kgk/kgk.dart';

class SmartOptionTile extends StatelessWidget {
  final ProfileListModel profileListModel;
  final Color? leadingImageColor;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final double? imageSize;

  const SmartOptionTile({
    super.key,
    required this.profileListModel,
    this.imageSize,
    this.leadingImageColor,
    this.titleStyle,
    this.subTitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).smartOptionTileStyle;
    return GestureDetector(
      onTap: () {
        if (profileListModel.onTap != null) {
          profileListModel.onTap!(context);
        }
      },
      child: Container(
        color: style.transparentColor,
        padding: EdgeInsetsDirectional.symmetric(vertical: 16.0.h),
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SmartImage(
                path: profileListModel.image ?? '',
                height: imageSize ?? 24.w,
                width: imageSize ?? 24.w,
                color: leadingImageColor,
                fit: BoxFit.contain,
                matchTextDirection: true,
              ),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (profileListModel.title.isNotNullNorEmpty)
                      SmartText(
                        profileListModel.title!.tr,
                        style: style.titleStyle.merge(titleStyle),
                      ),
                    if (profileListModel.title.isNotNullNorEmpty && profileListModel.subTitle.isNotNullNorEmpty)
                      SizedBox(
                        height: 1.h,
                      ),
                    if (profileListModel.subTitle.isNotNullNorEmpty)
                      SmartText(
                        profileListModel.subTitle!.tr,
                        style: style.subTextStyle.merge(subTitleStyle),
                      ),
                  ],
                ),
              ),
              if (profileListModel.trailingIcon.isNotNullNorEmpty)
                SizedBox(
                  width: 12.w,
                ),
              if (profileListModel.trailingIcon.isNotNullNorEmpty)
                Container(
                  height: 24.w,
                  width: 24.w,
                  alignment: AlignmentDirectional.center,
                  child: SmartImage(
                    path: profileListModel.trailingIcon ?? "",
                    color: style.arrowRightColor,
                    matchTextDirection: true,
                  ),
                ),
            ]),
          ],
        ),
      ),
    );
  }
}
