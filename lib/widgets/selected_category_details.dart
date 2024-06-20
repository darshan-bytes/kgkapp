import 'package:kgk/kgk.dart';

class SelectedCategoryDetails extends StatelessWidget {
  final ArrowPosition arrowPosition;
  final List<String> productsDetailsList;
  final ScrollController scrollController;
  final void Function(dynamic) onProductSelected;

  const SelectedCategoryDetails({
    super.key,
    required this.arrowPosition,
    required this.productsDetailsList,
    required this.scrollController,
    required this.onProductSelected,
  });

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
            margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
            height: 260.w,
            alignment: Alignment.center,
            color: categoryTileStyle.backgroundColor,
            child: Scrollbar(
              trackVisibility: true,
              thumbVisibility: true,
              controller: scrollController,
              child: ListView.builder(
                  itemCount: productsDetailsList.length,
                  shrinkWrap: true,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onProductSelected(productsDetailsList[index]),
                      child: Container(
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
                            if (index != productsDetailsList.length - 1)
                              Container(
                                height: 0.8.h,
                                color: categoryTileStyle.dividerLineColor,
                              )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
