import 'package:kgk/kgk.dart';

class ProductReviewsDetails extends StatelessWidget {
  final VoidCallback onTap;

  const ProductReviewsDetails({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartText(APPStrings.customerReviews.tr, style: style.customerReviewTitleStyle),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: style.customiseBoxBorderColor)),
                ),
                padding: EdgeInsets.fromLTRB(0, 42.w, 24.h, 42.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmartText('4.0', style: style.averageRatingStyle),
                        SizedBox(width: 4.w),
                        SmartImage(path: AppImages.icFullStar, height: 20.h, width: 20.w),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    SmartText(
                      APPStrings.reviewsX.tr.interpolate([120]),
                      style: style.productCodeStyle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        SmartText('5'.tr),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.8,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SmartText('4'.tr),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.5,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SmartText('3'.tr),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.0,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SmartText('2'.tr),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.1,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SmartText('1'.tr),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.2,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SmartButton(
          onTap: () {
            onTap();
          },
          title: APPStrings.writeAReview.tr,
          prefixImage: AppImages.icEdit,
        ),
      ],
    );
  }
}
