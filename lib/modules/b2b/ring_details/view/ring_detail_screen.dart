import 'package:kgk/kgk.dart';

class RingDetailScreen extends StatefulWidget {
  const RingDetailScreen({super.key});

  @override
  State<RingDetailScreen> createState() => _RingDetailScreenState();
}

class _RingDetailScreenState extends State<RingDetailScreen> {

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
    final style = AppTheme.of(context).ringDetailScreenStyle;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'DIY',
        onFavorite: () { },
        onFilter: () { },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DiyProgressWidget(selectedStep: 2,),
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
              APPStrings.selectSetting.tr,
              style: style.selectSettingStyle,
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
    final style = AppTheme.of(context).ringDetailScreenStyle;
    final ringDetailBloc = context.read<RingDetailBloc>();
    return BlocBuilder<RingDetailBloc, RingDetailState>(
      buildWhen: (_, current) => current is RingSettingState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SmartText(
                    'Martin Flyer',
                    style: style.ringTypeStyle,
                  ),
                  const SizedBox(width: 8,),
                  SmartText(
                    '●',
                    color: colors(context).color8C8C8C,
                  ),
                  const SizedBox(width: 8,),
                  SmartText(
                    'DERC03RDA',
                    style: style.ringCodeStyle,
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              SmartText(
                '1.01 Carat Round Diamond',
                style: style.ringNameStyle,
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
              const SizedBox(height: 20,),
              const Divider(height: 1,),
              const SizedBox(height: 20,),
              _metalSelectionWidget(),
              const SizedBox(height: 10,),
              const Divider(height: 1,),
              const SizedBox(height: 16,),
              Row(
                children: [
                  SmartText(
                    APPStrings.approxPrice.tr,
                    style: style.approxPriceLabelStyle,
                  ),
                  const SizedBox(width: 12,),
                  SmartText(
                    '\$1200.00',
                    style: style.priceStyle,
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                  SmartText(
                    APPStrings.buyingInBulk.tr,
                    style: style.buyInBulkStyle,
                  ),
                  const SizedBox(width: 12,),
                  InkWell(
                    onTap: () {},
                    child: SmartText(
                      APPStrings.askForQuotation.tr,
                      style: style.askQuestionStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              SmartText(
                APPStrings.approxPriceNote.tr,
                style: style.approxPriceNoteStyle,
              ),
              const SizedBox(height: 32,),
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
              const SizedBox(height: 32,),
              const Divider(height: 1,),
              const SizedBox(height: 32,),
              GestureDetector(
                onTap: () {
                  ringDetailBloc.add(RingSettingEvent(isSettingOpen: ringDetailBloc.isSettingOpen ? false : true));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmartText(APPStrings.settingDetails, style: style.settingHeaderStyle,),
                    if (!ringDetailBloc.isSettingOpen) ... [
                      const Icon(Icons.keyboard_arrow_up, size: 24,),
                    ] else ...[
                      const Icon(Icons.keyboard_arrow_down, size: 24,),
                    ],
                  ],
                ),
              ),
              if (!ringDetailBloc.isSettingOpen) ... [
                const SizedBox(height: 16,),
                _settingWidget(APPStrings.productType.tr, 'Engagement Ring'),
                const SizedBox(height: 14,),
                _settingWidget(APPStrings.brand, 'Flyerfit'),
                const SizedBox(height: 14,),
                _settingWidget(APPStrings.meleeWeight, 'SA-.25cts Dia-0.28cts'),
              ],
              const SizedBox(height: 28,),
              const Divider(height: 1,),
              const SizedBox(height: 28,),
              _settingWidget('Shape', 'Round'),
              const SizedBox(height: 12,),
              _settingWidget('Quantity', '1'),
              const SizedBox(height: 12,),
              _settingWidget('Total carat (min)', '1'),
              const SizedBox(height: 12,),
              _settingWidget('Color', 'F-G'),
              const SizedBox(height: 12,),
              _settingWidget('Clarity', 'VS2-SI1'),
              const SizedBox(height: 12,),
              _settingWidget('Setting', 'TypeThree Stone'),
              const SizedBox(height: 28,),
              const Divider(height: 1,),
              const SizedBox(height: 28,),
              _inquiryWidget(),
              const SizedBox(height: 24,),
            ],
          ),
        );
      },
    );
  }

  Widget _inquiryWidget() {
    final style = AppTheme.of(context).ringDetailScreenStyle;
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

  Widget _metalSelectionWidget() {
    final style = AppTheme.of(context).ringDetailScreenStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.metal.tr, style: style.metalHeaderStyle,),
        const SizedBox(height: 12,),
        Container(
          height: 100,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              bool isSelected = index % 3 == 0;
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 34, width: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors(context).white,
                          border: isSelected ? Border.all(color: colors(context).color083458, width: 1) : null,
                        ),
                        child: Center(
                          child: FractionallySizedBox(
                            heightFactor: 0.8,
                            widthFactor: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: colors(context).primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      SmartText(
                        'White \nGold',
                        style: isSelected ? style.selectedMetalNameStyle : style.metalNameStyle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _settingWidget(String type, String value) {
    final style = AppTheme.of(context).ringDetailScreenStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(type, style: style.settingTypeStyle,),
        SmartText(value, style: style.settingValueStyle,),
      ],
    );
  }
}