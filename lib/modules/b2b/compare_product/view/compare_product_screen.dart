import 'package:kgk/kgk.dart';

class CompareProductScreen extends StatelessWidget {
  const CompareProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CompareProductStyle style = AppTheme.of(context).compareProductStyle;
    return Scaffold(
        appBar: SmartAppBar(
          title: APPStrings.compareProduct.tr,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(14.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Table(
                        defaultColumnWidth: const IntrinsicColumnWidth(),
                        columnWidths: {
                          0: FixedColumnWidth(124.w),
                        },
                        children: [_buildTableRow(style)],
                      ),
                      SizedBox(
                        height: 132.h,
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 132.w,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5.r,
                        blurRadius: 7.r,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    columnWidths: {
                      0: FixedColumnWidth(124.w),
                    },
                    children: [
                      TableRow(
                          children: List.generate(
                              5,
                              (index) => SizedBox(
                                  width: 130.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SmartButton(
                                        onTap: () {},
                                        title: APPStrings.addToBag.tr,
                                        width: 114.w,
                                        height: 48.w,
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 48.h,
                                          width: 114.w,
                                          alignment: Alignment.center,
                                          child: SmartText(APPStrings.remove.tr, style: style.productRemoveStyle),
                                        ),
                                      ),
                                    ],
                                  ))))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  TableRow _buildTableRow(CompareProductStyle style) {
    return TableRow(children: List.generate(5, (index) => _buildTableCell(index, style)));
  }

  Widget _buildTableCell(int index, CompareProductStyle style) {
    return Container(
      width: 130.w,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartImage(
            path: 'https://www.figma.com/file/xHJugBedFGw3uWVpWmaqcF/image/9b088e68788432f985282804ce6fe7e5cba65948',
            width: 114.w,
            height: 114.w,
            color: Colors.black,
          ),
          SizedBox(height: 8.h),
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: SmartText(
              'Diamond Vine Ring in 18k Rose Gold',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: style.productTitleStyle,
            ),
          ),
          SizedBox(height: 8.h),
          SmartText(
            '\$5,000.00',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.productPriceStyle,
          ),
          SizedBox(height: 28.h),
          _buildProductDetailWidgets(index, APPStrings.brand.tr, "Flyerfit", style),
          _buildProductDetailWidgets(index, APPStrings.productType.tr, "Engagement Ring", style),
          _buildProductDetailWidgets(index, APPStrings.metalType.tr, "Platinum", style),
          _buildProductDetailWidgets(index, APPStrings.settingType.tr, "Micropave Halo", style),
          _buildProductDetailWidgets(index, APPStrings.metalType.tr, "Diamond 0.31 Cts H/I/SI2", style),
          _buildProductDetailWidgets(index, APPStrings.certified.tr, "Oval 11 Certified Diamond 1.200 Cts H-SI1 GIA/6412091876", style,
              textHeight: 100, maxLines: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: index == 0,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: SmartText(
                  APPStrings.reviewsX.tr.interpolate(['']),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: style.productSubTitleStyle,
                ),
              ),
              SizedBox(height: 8.h),
              Divider(height: 1.h),
              SizedBox(height: 8.h),
              SmartText(
                '4.0',
                style: style.productTitleStyle,
              ),
              SizedBox(height: 4.h),
              SmartRatingBar(
                initialRating: 3,
                itemSize: 14,
                ignoreGestures: true,
                onRatingUpdate: (rating) {
                  printWrapped(rating.toString());
                },
              ),
              SizedBox(height: 6.h),
              SmartText(
                "120 reviews",
                style: style.productReviewStyle,
              ),
              SizedBox(height: 14.h),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductDetailWidgets(int index, String label, String value, CompareProductStyle style,
      {double textHeight = 48, int maxLines = 2}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Visibility(
        visible: index == 0,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: SmartText(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: style.productSubTitleStyle,
        ),
      ),
      SizedBox(height: 8.h),
      Divider(height: 1.h),
      SizedBox(height: 8.h),
      Container(
        margin: EdgeInsets.only(right: 12.w),
        height: textHeight.h,
        child: SmartText(
          value,
          style: style.productTitleStyle,
          maxLines: maxLines,
        ),
      ),
      SizedBox(height: 14.h),
    ]);
  }
}
