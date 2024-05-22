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
                  ? EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.15)
                  : arrowPosition == ArrowPosition.centerTop
                      ? EdgeInsets.zero
                      : EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
              child: ClipPath(
                clipper: TriangleClipper(arrowPosition: arrowPosition),
                child: Container(
                  color: categoryTileStyle.backgroundColor,
                  height: 10,
                  width: 20,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 260,
            alignment: Alignment.center,
            color: categoryTileStyle.backgroundColor,
            child: ListView.builder(
                itemCount: productsDetailsList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 14),
                          child: SmartText(
                            productsDetailsList[index],
                            style: categoryTileStyle.detailStyle,
                          ),
                        ),
                        if (index != 4)
                          Container(
                            height: 0.8,
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
