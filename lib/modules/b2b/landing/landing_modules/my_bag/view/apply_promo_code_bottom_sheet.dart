import 'package:kgk/kgk.dart';

class ApplyPromoCodeBottomSheet extends StatelessWidget {
  final Function(String) onApplyPromoCode;

  ApplyPromoCodeBottomSheet({super.key, required this.onApplyPromoCode});

  final TextEditingController promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final EditWatchlistStyle style = AppTheme.of(context).editWatchlistStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartSingleChildScrollView(
          padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SmartText(APPStrings.addPromoCode.tr, style: style.titleStyle),
                    SizedBox(height: 16.h),
                    SmartTextField(
                      controller: promoCodeController,
                      hintText: APPStrings.hintPromoCode.tr,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 16.h),
                    SmartButton(
                      title: APPStrings.apply.tr,
                      onTap: () async {
                        await onApplyPromoCode(promoCodeController.text);
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                end: 16.w,
                top: 16.w,
                child: SmartImage(path: AppImages.icCross, width: 24.w, height: 24.h, onTap: () => context.pop()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
