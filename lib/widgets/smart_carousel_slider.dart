import 'package:kgk/kgk.dart';

class SmartCarouselSlider extends StatelessWidget {
  final List<String> imgList;
  final CarouselController controller;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;
  final Function()? on360Tap;
  final Color? backgroundColor;

  const SmartCarouselSlider({
    super.key,
    required this.imgList,
    required this.controller,
    this.onPageChanged,
    this.on360Tap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
    ValueNotifier<int> currentPage = ValueNotifier<int>(0);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: backgroundColor,
              child: CarouselSlider(
                items: imgList.map((e) => SmartImage(path: e)).toList(),
                carouselController: controller,
                options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1.5,
                    aspectRatio: 1,
                    onPageChanged: (index, reason) {
                      currentPage.value = index;
                      onPageChanged?.call(index, reason);
                    }),
              ),
            ),
            if (on360Tap != null)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: SmartImage(
                    path: AppImages.ic360,
                    height: 36.w,
                    width: 36.w,
                  ),
                  onPressed: () {
                    on360Tap?.call();
                  },
                ),
              )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imgList.length,
            (index) {
              return GestureDetector(
                onTap: () => controller.animateToPage(index),
                child: ValueListenableBuilder<int>(
                    valueListenable: currentPage,
                    builder: (context, value, child) {
                      return Container(
                        width: 10.0.w,
                        height: 10.0.w,
                        margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage.value == index ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor),
                      );
                    }),
              );
            },
          ),
        ),
      ],
    );
  }
}
