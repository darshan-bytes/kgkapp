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
          moreStyle: style.readMoreStyle,
          lessStyle: style.readMoreStyle,
        ),
        if (reviewDataModel.images != null && reviewDataModel.images!.isNotEmpty) ...[
          SizedBox(height: 12.h),
          SizedBox(
            height: 50.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: reviewDataModel.images?.length ?? 0,
              itemBuilder: (context, index) => SmartImage(
                path: reviewDataModel.images![index],
                width: 50.w,
                height: 50.w,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          clipBehavior: Clip.antiAlias,
                          children: [
                            SmartImage(
                              path: reviewDataModel.images![index],
                              fit: BoxFit.contain,
                            ),
                            PositionedDirectional(
                              top: 24.h,
                              end: 24.w,
                              child: Container(
                                color: AppTheme.of(context).colors.white,
                                child: SmartImage(
                                  path: AppImages.icCross,
                                  width: 24.w,
                                  height: 24.w,
                                  color: AppTheme.of(context).colors.black,
                                  onTap: () => context.pop(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
            ),
          ),
        ],
      ],
    );
  }
}
