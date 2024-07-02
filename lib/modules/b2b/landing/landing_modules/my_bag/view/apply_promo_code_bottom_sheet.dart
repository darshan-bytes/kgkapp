import 'package:kgk/kgk.dart';

class ApplyPromoCodeBottomSheet extends StatelessWidget {
  const ApplyPromoCodeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final EditWatchlistStyle style = AppTheme.of(context).editWatchlistStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SmartSingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SmartText(APPStrings.addPromoCode.tr, style: style.titleStyle),
                    SizedBox(height: 16.h),
                    SmartTextField(
                      hintText: APPStrings.hintPromoCode.tr,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 16.h),
                    SmartButton(
                      title: APPStrings.apply.tr,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16.w,
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
