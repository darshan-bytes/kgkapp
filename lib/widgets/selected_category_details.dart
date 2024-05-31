import 'package:kgk/kgk.dart';

class SelectedCategoryDetails extends StatelessWidget {
  final ArrowPosition arrowPosition;
  final List<String> productsDetailsList;

  const SelectedCategoryDetails({super.key, required this.arrowPosition, required this.productsDetailsList});

  @override
  Widget build(BuildContext context) {
    final CategoryTileStyle categoryTileStyle = AppTheme.of(context).categoryTileStyle;
    return Center(
      child: Column(
        children: <Widget>[
          Align(
            alignment: arrowPosition == ArrowPosition.rightTop
                ? Alignment.centerRight
                : arrowPosition == ArrowPosition.centerTop
                    ? Alignment.center
                    : Alignment.centerLeft,
            child: Container(
              margin: arrowPosition == ArrowPosition.rightTop
                  ? EdgeInsets.only(right: context.width * 0.15)
                  : arrowPosition == ArrowPosition.centerTop
                      ? EdgeInsets.zero
                      : EdgeInsets.only(left: context.width * 0.15),
              child: ClipPath(
                clipper: TriangleClipper(arrowPosition: arrowPosition),
                child: Container(
                  color: categoryTileStyle.backgroundColor,
                  height: 10.h,
                  width: 20.w,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            height: 260.h,
            alignment: Alignment.center,
            color: categoryTileStyle.backgroundColor,
            child: ListView.builder(
                itemCount: productsDetailsList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
                          child: SmartText(
                            productsDetailsList[index],
                            style: categoryTileStyle.detailStyle,
                          ),
                        ),
                        if (index != 4)
                          Container(
                            height: 0.8.h,
                            color: categoryTileStyle.dividerLineColor,
                          )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
