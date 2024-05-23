import 'package:kgk/kgk.dart';

class DiamondDetailScreen extends StatefulWidget {
  const DiamondDetailScreen({super.key});

  @override
  State<DiamondDetailScreen> createState() => _DiamondDetailScreenState();
}

class _DiamondDetailScreenState extends State<DiamondDetailScreen> {

  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
    AppImages.icEyeClose,
  ];

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondDetailScreenStyle;
    return Scaffold(
      appBar: CustomAppBar(
        title: '1.01 Carat Round Diamond',
        onFavorite: () { },
        onFilter: () { },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DiyProgressWidget(selectedStep: 1,),
            _imageSlider(),
            const SizedBox(height: 40,),
            _productDetail()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: BottomAppBar(
          color: colors(context).white.withOpacity(0.08),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colors(context).primary,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
            child: Text(
              APPStrings.selectDiamond.tr,
              style: style.selectDiamondStyle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageSlider() {
    return Column(
      children: [
        CarouselSlider(
          items: imgList.map((e) {
            return SmartImage(path: e, width: double.infinity,);
          }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.5,
              aspectRatio: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _productDetail() {
    final style = AppTheme.of(context).diamondDetailScreenStyle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            'SKU 14178065',
            style: style.skuStyle,
          ),
          const SizedBox(height: 8,),
          SmartText(
            '1.01 Carat Round Diamond',
            style: style.diamondNameStyle,
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              RatingBar(
                itemCount: 5,
                glowColor: colors(context).primary,
                onRatingUpdate: (double value) {  },
                allowHalfRating: false,
                itemSize: 16,
                itemPadding: const EdgeInsets.only(right: 2, left: 2),
                ratingWidget: RatingWidget(
                  empty: const SmartImage(path: AppImages.icEmptyStar),
                  full: const SmartImage(path: AppImages.icFullStar),
                  half: Container(),
                ),
              ),
              const SizedBox(width: 8,),
              SmartText(
                  APPStrings.reviews.interpolate([120]).tr,
                style: style.reviewStyle,
              )
            ],
          ),
          const SizedBox(height: 24,),
          const Divider(height: 1,),
          const SizedBox(height: 24,),
          SmartText(
              '\$3,020',
            style: style.priceStyle,
          ),
          Row(
            children: [
              SmartText(APPStrings.wantToSeeProductPhysically.tr, style: style.seeProductStyle,),
              const SizedBox(width: 8,),
              SmartText(APPStrings.orderSample.tr, style: style.orderSampleStyle,),
            ],
          ),
          const SizedBox(height: 24,),
          const Divider(height: 1,),
          const SizedBox(height: 24,),
          Row(
            children: [
              const SmartImage(path: AppImages.icDiamond),
              const SizedBox(width: 16,),
              SmartText(APPStrings.diamondPurityYouCanTrust.tr, style: style.diamondPurityStyle,)
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              const SmartImage(path: AppImages.icTruck),
              const SizedBox(width: 16,),
              SmartText(APPStrings.shippingAcrossAllCountries.tr, style: style.shippingStyle,)
            ],
          ),
          const SizedBox(height: 24,),
          _inquiryWidget(),
          const SizedBox(height: 24,),
          const Divider(height: 1,),
          const SizedBox(height: 24,),
        ],
      ),
    );
  }

  Widget _inquiryWidget() {
    final style = AppTheme.of(context).diamondDetailScreenStyle;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors(context).colorD3DAE0, width: 1),
        borderRadius: BorderRadius.circular(8)
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(APPStrings.haveAQuestion.tr, style: style.haveAQuestionStyle,),
                const SizedBox(height: 8,),
                SmartText(APPStrings.reachoutToOurExpert.tr, style: style.reachOutStyle,),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    const SmartImage(path: AppImages.icPhone),
                    const SizedBox(width: 8,),
                    SmartText('+91 - 1234567830', style: style.phoneStyle,)
                  ],
                ),
                const SizedBox(height: 14,),
                Row(
                  children: [
                    const SmartImage(path: AppImages.icMail),
                    const SizedBox(width: 8,),
                    SmartText('enquiry.diaind@kgkmail.com', style: style.emailStyle,)
                  ],
                ),
                const SizedBox(height: 16,),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 4),
            child: SmartImage(path: AppImages.icArrowRight, height: 16, width: 16,),
          )
        ],
      ),
    );
  }
}