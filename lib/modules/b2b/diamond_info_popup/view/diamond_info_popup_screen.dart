import 'package:kgk/kgk.dart';

class DiamondInfoPopupScreen extends StatelessWidget {
  const DiamondInfoPopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.diamonds.tr,
        onFilter: () {},
        onFavorite: () {},
      ),
      body: Column(
        children: [],
      ),
    );
  }

  Widget _imageSlider(DiamondDetailBloc diamondBloc) {
    return BlocBuilder<DiamondDetailBloc, DiamondDetailState>(
      buildWhen: (_, current) => current is DiamondImagePageChangeState,
      builder: (context, state) {
        final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
        return Column(
          children: [
            CarouselSlider(
              items: diamondBloc.imgList.map((e) {
                return SmartImage(path: e);
              }).toList(),
              carouselController: diamondBloc.controller,
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.5,
                  aspectRatio: 1,
                  onPageChanged: (index, reason) {
                    diamondBloc.add(DiamondImagePageChangeEvent(index: index));
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: diamondBloc.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => diamondBloc.controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0.w,
                    height: 10.0.w,
                    margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: diamondBloc.current == entry.key ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
