import 'package:kgk/kgk.dart';

class ProductCustomerReviewWidget extends StatelessWidget {
  final ReviewDataModel reviewDataModel;

  const ProductCustomerReviewWidget({super.key, required this.reviewDataModel});

  @override
  Widget build(BuildContext context) {
    final ReviewDetailsStyle style = AppTheme.of(context).reviewDetailsStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SmartText(reviewDataModel.userName, style: style.userNameStyle),
            SizedBox(width: 8.w),
            Container(
              height: 4.w,
              width: 4.w,
              decoration: BoxDecoration(
                color: style.dotColor,
                border: Border.all(color: style.dotColor),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            SmartText(reviewDataModel.date, style: style.createdDateStyle),
          ],
        ),
        SizedBox(height: 4.h),
        SmartRatingBar(
          initialRating: reviewDataModel.rating?.toDouble() ?? 0,
          itemSize: 16,
          onRatingUpdate: (value) {},
          ignoreGestures: true,
        ),
        SizedBox(height: 12.h),
        SmartText(reviewDataModel.title, style: style.titleStyle),
        SizedBox(height: 2.h),
        ReadMoreText(
          reviewDataModel.review ?? "",
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimCollapsedText: APPStrings.readMore.tr,
          trimExpandedText: APPStrings.readLess.tr,
          style: style.createdDateStyle,
        ),
        if (reviewDataModel.images != null && reviewDataModel.images!.isNotEmpty) ...[
          SizedBox(height: 12.h),
          SizedBox(
            height: 50.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: reviewDataModel.images?.length ?? 0,
              itemBuilder: (context, index) => SmartImage(path: reviewDataModel.images![index], width: 50.w, height: 50.w),
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
            ),
          ),
        ],
      ],
    );
  }
}
