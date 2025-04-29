import 'package:kgk/kgk.dart';

class SelectedCategoryDetails extends StatelessWidget {
  final ArrowPosition arrowPosition;
  final List<ProductDetailModel> productsDetailsList;
  final ScrollController scrollController;
  final void Function(ProductDetailModel) onProductSelected;

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment:
              arrowPosition == ArrowPosition.rightTop
                  ? AlignmentDirectional.centerEnd
                  : arrowPosition == ArrowPosition.centerTop
                  ? AlignmentDirectional.center
                  : AlignmentDirectional.centerStart,
          child: Container(
            margin:
                arrowPosition == ArrowPosition.rightTop
                    ? EdgeInsetsDirectional.only(end: context.width * 0.15)
                    : arrowPosition == ArrowPosition.centerTop
                    ? EdgeInsetsDirectional.zero
                    : EdgeInsetsDirectional.only(start: context.width * 0.15),
            child: ClipPath(
              clipper: TriangleClipper(arrowPosition: arrowPosition),
              child: Container(color: categoryTileStyle.colorD5E7F1, height: 10.h, width: 20.w),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 10.w),
          constraints: BoxConstraints(maxHeight: 320.w),
          color: categoryTileStyle.colorD5E7F1,
          child: Scrollbar(
            trackVisibility: true,
            thumbVisibility: true,
            controller: scrollController,
            child: ListView.builder(
              itemCount: productsDetailsList.length,
              shrinkWrap: true,
              controller: scrollController,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onProductSelected(productsDetailsList[index]),
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SmartImage(path: productsDetailsList[index].image ?? '', height: 34.w, width: 34.w),
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 18.h, bottom: 18.h, start: 10.w),
                              child: SmartText(
                                Utils.getCategoryDisplayName(productsDetailsList[index].name ?? ''),
                                style: categoryTileStyle.detailStyle,
                              ),
                            ),
                          ],
                        ),
                        if (index != productsDetailsList.length - 1) Container(height: 0.8.h, color: categoryTileStyle.dividerLineColor),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
