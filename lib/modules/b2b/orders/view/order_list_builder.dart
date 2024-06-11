import 'package:kgk/kgk.dart';

class OrderListBuilder extends StatelessWidget {
  final void Function(int)? onTap;
  final void Function(int)? onTapMenuButton;
  final List<MyOrderDetailsModel>? ordersList;

  const OrderListBuilder({
    super.key,
    this.onTap,
    this.onTapMenuButton,
    this.ordersList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: ordersList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return MyOrderItem(
          onTap: () {
            if (onTap != null) {
              onTap!(index);
            }
          },
          onTapMenuButton: () {
            if (onTapMenuButton != null) {
              onTapMenuButton!(index);
            }
          },
          myOrderDetailsModel: ordersList![index],
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
    );
  }
}
