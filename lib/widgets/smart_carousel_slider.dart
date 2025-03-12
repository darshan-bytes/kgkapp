import 'package:kgk/kgk.dart';

class SmartCarouselSlider extends StatelessWidget {
  final List<String> imgList;
  final CarouselSliderController controller;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;
  final Function()? on360Tap;
  final Function()? onVideoTap;
  final Color? backgroundColor;
  final Function(int currentPage)? onTapFullImage;

  const SmartCarouselSlider({
    super.key,
    required this.imgList,
    required this.controller,
    this.onPageChanged,
    this.on360Tap,
    this.backgroundColor,
    this.onTapFullImage,
    this.onVideoTap,
  });

  @override
  Widget build(BuildContext context) {
    final ImageCarouselStyle imageCarouselStyle = AppTheme.of(context).imageCarouselStyle;
    ValueNotifier<int> currentPage = ValueNotifier<int>(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (onTapFullImage != null) {
                  onTapFullImage?.call(currentPage.value);
                }
              },
              child: Container(
                color: backgroundColor,
                child: CarouselSlider(
                  items: imgList.map((e) {
                    return SmartImage(path: e);
                  }).toList(),
                  carouselController: controller,
                  options: CarouselOptions(
                      autoPlay: imgList.length > 1 && onVideoTap != null,
                      enableInfiniteScroll: imgList.length > 1,
                      viewportFraction: 1.5,
                      aspectRatio: 1,
                      onPageChanged: (index, reason) {
                        currentPage.value = index;
                        onPageChanged?.call(index, reason);
                      }),
                ),
              ),
            ),
            if (on360Tap != null || onVideoTap != null)
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (on360Tap != null)
                      IconButton(
                        icon: SmartImage(
                          path: AppImages.ic360,
                          height: 36.w,
                          width: 36.w,
                        ),
                        onPressed: () {
                          on360Tap?.call();
                        },
                      ),
                    if (onVideoTap != null)
                      IconButton(
                        onPressed: () {
                          onVideoTap?.call();
                        },
                        icon: Icon(
                          Icons.video_file_outlined,
                          color: imageCarouselStyle.selectedDotColor,
                          size: 36.w,
                        ),
                      ),
                  ],
                ),
              )
          ],
        ),
        SizedBox(
          height: 60.h,
          child: ListView.builder(
              itemCount: imgList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => controller.animateToPage(index),
                  child: ValueListenableBuilder<int>(
                      valueListenable: currentPage,
                      builder: (context, value, child) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
                          child: Center(
                            child: SmartImage(
                              path: imgList[index],
                              width: 44.0.w,
                              height: 44.0.w,
                              border: Border.all(
                                color: currentPage.value == index ? imageCarouselStyle.selectedDotColor : imageCarouselStyle.dotColor,
                                width: 1.6.w,
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ),
      ],
    );
  }
}
