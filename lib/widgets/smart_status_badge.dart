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

    return FittedBox(
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(height != null ? (height! / 2) : 12.r),
        ),
        child: Center(
          child: SmartText(
            statusText.tr,
            style: style.statusTextStyle.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.inProgress:
        return OrderStatus.inProgress.value;
      case OrderStatus.active:
        return OrderStatus.active.value;
      case OrderStatus.winner:
        return OrderStatus.winner.value;
      case OrderStatus.lost:
        return OrderStatus.lost.value;
      case OrderStatus.onGoing:
        return OrderStatus.onGoing.value;
    }
  }

  Color _getBackgroundColor(OrderStatus status, StatusBadgeStyle style) {
    switch (status) {
      case OrderStatus.inProgress:
        return style.inProgressBackgroundColor;
      case OrderStatus.active:
        return style.activeBackgroundColor;
      case OrderStatus.onGoing:
        return style.inProgressBackgroundColor;
      case OrderStatus.winner:
        return style.activeBackgroundColor;
      case OrderStatus.lost:
        return style.lostBackgroundColor;
    }
  }

  Color _getTextColor(OrderStatus status, StatusBadgeStyle style) {
    switch (status) {
      case OrderStatus.inProgress:
        return style.inProgressTextColor;
      case OrderStatus.active:
        return style.activeTextColor;
      case OrderStatus.onGoing:
        return style.inProgressTextColor;
      case OrderStatus.winner:
        return style.activeTextColor;
      case OrderStatus.lost:
        return style.lostTextColor;
    }
  }
}
