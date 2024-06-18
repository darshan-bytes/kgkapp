import 'package:kgk/kgk.dart';

class SmartOptionTile extends StatelessWidget {
  final ProfileListModel profileListModel;
  final double? imageSize;

  const SmartOptionTile({
    super.key,
    required this.profileListModel,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).smartOptionTileStyle;
    return GestureDetector(
      onTap: () {
        if (profileListModel.onTap != null) {
          profileListModel.onTap!();
        }
      },
      child: Container(
        color: style.transparentColor,
        padding: EdgeInsets.symmetric(vertical: 16.0.h),
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SmartImage(
                path: profileListModel.image ?? '',
                height: imageSize ?? 24.w,
                width: imageSize ?? 24.w,
                color: style.primaryColor,
                fit: BoxFit.contain,
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
                        profileListModel.title,
                        style: style.titleStyle,
                      ),
                    if (profileListModel.title.isNotNullNorEmpty && profileListModel.subTitle.isNotNullNorEmpty)
                      SizedBox(
                        height: 1.h,
                      ),
                    if (profileListModel.subTitle.isNotNullNorEmpty)
                      SmartText(
                        profileListModel.subTitle,
                        style: style.subTextStyle,
                      ),
                  ],
                ),
              ),
              if (profileListModel.trailingIcon.isNotNullNorEmpty)
                SizedBox(
                  width: 12.w,
                ),
              Container(
                height: 24.w,
                width: 24.w,
                alignment: Alignment.center,
                child: SmartImage(
                  path: profileListModel.trailingIcon!,
                  color: style.arrowRightColor,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
