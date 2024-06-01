import 'package:kgk/kgk.dart';

class ProductCustomerReviewWidget extends StatelessWidget {
  const ProductCustomerReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ReviewDetailsStyle style = AppTheme.of(context).reviewDetailsStyle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SmartText('Esther Howard', style: style.userNameStyle),
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
            SmartText('01/05/23', style: style.createdDateStyle),
          ],
        ),
        const SizedBox(height: 4),
        SmartRatingBar(
          initialRating: 3,
          itemSize: 16,
          onRatingUpdate: (value) {},
          ignoreGestures: true,
        ),
        const SizedBox(height: 12),
        SmartText('Gorgeous and more gorgeous', style: style.titleStyle),
        const SizedBox(height: 2),
        ReadMoreText(
          'I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone. I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone. I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone.',
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimCollapsedText: APPStrings.readMore.tr,
          trimExpandedText: APPStrings.readLess.tr,
          style: style.createdDateStyle,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) => const SmartImage(path: '', width: 50, height: 50),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        ),
      ],
    );
  }
}
