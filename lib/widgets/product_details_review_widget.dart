import 'package:kgk/kgk.dart';

class ProductReviewsDetails extends StatelessWidget {
  final double averageRating;
  final int reviewCount;
  final VoidCallback onTap;
  final List<int> ratings;
  final bool isShowWriteReviewButton;

  const ProductReviewsDetails({
    super.key,
    required this.onTap,
    required this.averageRating,
    required this.reviewCount,
    required this.ratings,
    this.isShowWriteReviewButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final ProductDetailsStyle style = AppTheme.of(context).productDetailsStyle;

    /// Using this function to calculate the count of each rating and set in a map
    final Map<int, int> ratingCounts = calculateRatingCounts(ratings);

    /// To get the max count
    final int maxCount = ratingCounts.values.isEmpty ? 1 : ratingCounts.values.reduce((a, b) => a > b ? a : b);
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
                        SmartText(averageRating.toString(), style: style.averageRatingStyle),
                        SizedBox(width: 4.w),
                        SmartImage(path: AppImages.icFullStar, height: 20.h, width: 20.w),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    SmartText(
                      APPStrings.reviewsX.tr.interpolate([reviewCount]),
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
                  children: ratingCounts.entries.map((entry) {
                    final rating = entry.key;
                    final count = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        children: [
                          SmartText('$rating'.tr),
                          SizedBox(width: 18.w),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: maxCount > 0 ? count / maxCount : 0.0,
                              color: style.ratingGlowColor,
                              backgroundColor: style.ratingGlowColor.withValues(alpha: 0.2),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        // Write a Review Button
        if (isShowWriteReviewButton) ...[
          SizedBox(height: 16.h),
          SmartButton(
            onTap: () {
              onTap();
            },
            title: APPStrings.writeAReview.tr,
            prefixImage: AppImages.icEdit,
          ),
        ],
      ],
    );
  }

  /// Using this function to calculate the count of each rating
  Map<int, int> calculateRatingCounts(List<int> ratings) {
    Map<int, int> ratingCounts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var rating in ratings) {
      if (ratingCounts.containsKey(rating)) {
        ratingCounts[rating] = ratingCounts[rating]! + 1;
      }
    }
    return ratingCounts;
  }
}
