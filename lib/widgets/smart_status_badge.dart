import 'package:kgk/kgk.dart';

class StatusBadge extends StatelessWidget {
  final OrderStatus currentStatus;
  final double? height;

  const StatusBadge({
    super.key,
    this.currentStatus = OrderStatus.inProgress,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).statusBadgeStyle;
    final statusText = _getStatusText(currentStatus);
    final backgroundColor = _getBackgroundColor(currentStatus, style);
    final textColor = _getTextColor(currentStatus, style);

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: SmartText(
        statusText.tr,
        style: style.statusTextStyle.copyWith(color: textColor),
      ),
    );
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.inProgress:
        return OrderStatus.inProgress.value;
      case OrderStatus.active:
        return OrderStatus.active.value;
    }
  }

  Color _getBackgroundColor(OrderStatus status, StatusBadgeStyle style) {
    switch (status) {
      case OrderStatus.inProgress:
        return style.inProgressBackgroundColor;
      case OrderStatus.active:
        return style.activeBackgroundColor;
    }
  }

  Color _getTextColor(OrderStatus status, StatusBadgeStyle style) {
    switch (status) {
      case OrderStatus.inProgress:
        return style.inProgressTextColor;
      case OrderStatus.active:
        return style.activeTextColor;
    }
  }
}
