import 'package:kgk/kgk.dart';

class OrderCancelBottomSheet extends StatelessWidget {
  const OrderCancelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    OrderCancelPopupStyle style = AppTheme.of(context).orderCancelPopupStyle;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: 553.h,
                child: Column(
                  children: [],
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
                    color: style.primaryColor,
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
