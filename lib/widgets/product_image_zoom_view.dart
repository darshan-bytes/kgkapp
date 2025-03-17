import 'package:kgk/kgk.dart';

/// A custom widget for displaying a gallery of product photos.
class ProductPhotoViewGallery extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ProductPhotoViewGallery({super.key, required this.imageUrls, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: initialIndex);
    final ValueNotifier<int> currentPage = ValueNotifier<int>(initialIndex);
    final ProductPhotoViewGalleryStyle style = AppTheme.of(context).productPhotoViewGalleryStyle;
    return Scaffold(
      backgroundColor: style.blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            _buildPhotoGallery(pageController, currentPage, style: style),
            _buildAppBar(context, currentPage.value, style: style),
            _buildImageIndicator(currentPage, style: style),
            _buildThumbnailList(pageController, currentPage, style: style),
          ],
        ),
      ),
    );
  }

  /// Builds the app bar with a back button and title.
  Widget _buildAppBar(BuildContext context, int currentPage, {required ProductPhotoViewGalleryStyle style}) {
    return PositionedDirectional(
      top: 10.w,
      start: 10.w,
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back, color: style.whiteColor),
      ),
    );
  }

  /// Builds the fullscreen photo gallery.
  Widget _buildPhotoGallery(PageController controller, ValueNotifier<int> currentPage, {required ProductPhotoViewGalleryStyle style}) {
    return PhotoViewGallery.builder(
      itemCount: imageUrls.length,
      pageController: controller,
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (context, index) => PhotoViewGalleryPageOptions(
        gestureDetectorBehavior: HitTestBehavior.opaque,
        imageProvider: CachedNetworkImageProvider(imageUrls[index]),
        heroAttributes: PhotoViewHeroAttributes(tag: imageUrls[index]),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2.0,
      ),
      backgroundDecoration: BoxDecoration(color: style.blackColor),
      onPageChanged: (index) => currentPage.value = index,
      loadingBuilder: (context, event) => Center(
        child: CircularProgressIndicator(
          value: event == null ? null : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
        ),
      ),
    );
  }

  /// Builds the image index indicator.
  Widget _buildImageIndicator(ValueNotifier<int> currentPage, {required ProductPhotoViewGalleryStyle style}) {
    return PositionedDirectional(
      top: 20.w,
      end: 20.w,
      child: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, index, child) {
          return Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: style.blackColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: SmartText(
              "${index + 1} / ${imageUrls.length}",
              style: TextStyle(color: style.whiteColor, fontSize: 14.sp),
            ),
          );
        },
      ),
    );
  }

  /// Builds the thumbnail list at the bottom of the screen.
  Widget _buildThumbnailList(PageController controller, ValueNotifier<int> currentPage, {required ProductPhotoViewGalleryStyle style}) {
    return PositionedDirectional(
      bottom: 20.w,
      start: 0,
      end: 0,
      child: SizedBox(
        height: 80.h,
        child: ValueListenableBuilder<int>(
          valueListenable: currentPage,
          builder: (context, currentIndex, child) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.jumpToPage(index);
                    currentPage.value = index;
                  },
                  child: _buildThumbnailItem(imageUrls[index], currentIndex == index, index, style: style),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 10.h),
            );
          },
        ),
      ),
    );
  }

  /// Builds a single thumbnail item with hover and selection effects.
  Widget _buildThumbnailItem(String imageUrl, bool isSelected, int index, {required ProductPhotoViewGalleryStyle style}) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: index == 0 ? 10.w : 0.w),
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isSelected ? style.blueAccentColor : style.transparentColor,
          width: 2.w,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.blueAccent.withValues(alpha: 0.5),
                  blurRadius: 10.r,
                  spreadRadius: 2.r,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: SmartImage(path: imageUrl, imageBorderRadius: BorderRadius.circular(8.r), fit: BoxFit.cover),
      ),
    );
  }
}
