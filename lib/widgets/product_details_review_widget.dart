import 'package:kgk/kgk.dart';

class ProductReviewsDetails extends StatelessWidget {
  const ProductReviewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartText(APPStrings.customerReviews.tr, style: style.customerReviewTitleStyle),
        const SizedBox(height: 16),
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
                padding: const EdgeInsets.fromLTRB(0, 42, 24, 42),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmartText('4.0', style: style.averageRatingStyle),
                        const SizedBox(width: 4),
                        const SmartImage(path: AppImages.icFullStar, height: 20, width: 20),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SmartText(
                      APPStrings.reviews.tr.interpolate([120]),
                      style: style.productCodeStyle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        SmartText('5'.tr),
                        const SizedBox(width: 18),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.8,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SmartText('4'.tr),
                        const SizedBox(width: 18),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.5,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SmartText('3'.tr),
                        const SizedBox(width: 18),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.0,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SmartText('2'.tr),
                        const SizedBox(width: 18),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.1,
                            color: style.ratingGlowColor,
                            backgroundColor: style.ratingGlowColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SmartText('1'.tr),
                        const SizedBox(width: 18),
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
        const SizedBox(height: 16),
        SmartButton(
          onTap: () {},
          title: APPStrings.writeAReview.tr,
          prefixImage: AppImages.icEdit,
        ),
      ],
    );
  }
}
