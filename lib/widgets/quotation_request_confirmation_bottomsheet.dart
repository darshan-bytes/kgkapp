import 'package:kgk/kgk.dart';

class QuotationRequestConfirmation extends StatelessWidget {
  final VoidCallback onContinueShopping;

  const QuotationRequestConfirmation({
    super.key,
    required this.onContinueShopping,
  });

  @override
  Widget build(BuildContext context) {
    final QuotationRequestConfirmationStyle style = AppTheme.of(context).quotationRequestConfirmationStyle;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SmartText(
                      APPStrings.requestSubmitted.tr,
                      style: style.titleStyle,
                    ),
                    SizedBox(height: 16.h),
                    SmartText(
                      APPStrings.requestSubmittedDesc.tr,
                      style: style.detailsTextStyle,
                    ),
                    SizedBox(height: 24.h),
                    SmartButton(
                      onTap: () {
                        onContinueShopping();
                      },
                      title: APPStrings.continueShopping.tr,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 16.w,
                right: 16.w,
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: SmartImage(
                    path: AppImages.icCross,
                    height: 24.w,
                    width: 24.w,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
