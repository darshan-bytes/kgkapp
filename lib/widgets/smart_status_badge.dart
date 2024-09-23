import 'package:kgk/kgk.dart';

class SmartStatusBadge extends StatelessWidget {
  final ProjectStatus currentStatus;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  const SmartStatusBadge({
    super.key,
    this.currentStatus = ProjectStatus.blueInProgress,
    this.height,
    this.borderRadius,
    this.padding,
    this.fontSize,
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
        padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
        ),
        child: Center(
          child: SmartText(
            statusText.tr,
            style: style.statusTextStyle.copyWith(color: textColor, fontSize: fontSize ?? 12.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String _getStatusText(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.orangeInProgress:
        return ProjectStatus.orangeInProgress.value;
      case ProjectStatus.active:
        return ProjectStatus.active.value;
      case ProjectStatus.winner:
        return ProjectStatus.winner.value;
      case ProjectStatus.lost:
        return ProjectStatus.lost.value;
      case ProjectStatus.onGoing:
        return ProjectStatus.onGoing.value;
      case ProjectStatus.blueInProgress:
        return ProjectStatus.blueInProgress.value;
      case ProjectStatus.approved:
        return ProjectStatus.approved.value;
      case ProjectStatus.released:
        return ProjectStatus.released.value;
      case ProjectStatus.approval:
        return ProjectStatus.approval.value;
      case ProjectStatus.styleCreated:
        return ProjectStatus.styleCreated.value;
      case ProjectStatus.onTime:
        return ProjectStatus.onTime.value;
      case ProjectStatus.created:
        return ProjectStatus.created.value;
      case ProjectStatus.inActive:
        return ProjectStatus.inActive.value;
      case ProjectStatus.onHold:
        return ProjectStatus.onHold.value;
      case ProjectStatus.wip:
        return ProjectStatus.wip.value;
    }
  }

  Color _getBackgroundColor(ProjectStatus status, StatusBadgeStyle style) {
    switch (status) {
      case ProjectStatus.orangeInProgress:
        return style.orangeInProgressBackgroundColor;
      case ProjectStatus.active:
        return style.activeBackgroundColor;
      case ProjectStatus.onGoing:
        return style.orangeInProgressBackgroundColor;
      case ProjectStatus.winner:
        return style.activeBackgroundColor;
      case ProjectStatus.lost:
        return style.lostBackgroundColor;
      case ProjectStatus.blueInProgress:
        return style.blueInProgressBackgroundColor;
      case ProjectStatus.approved:
        return style.activeBackgroundColor;
      case ProjectStatus.released:
        return style.activeBackgroundColor;
      case ProjectStatus.approval:
        return style.activeBackgroundColor;
      case ProjectStatus.styleCreated:
        return style.activeBackgroundColor;
      case ProjectStatus.onTime:
        return style.blueInProgressBackgroundColor;
      case ProjectStatus.created:
        return style.activeBackgroundColor;
      case ProjectStatus.inActive:
        return style.lostBackgroundColor;
      case ProjectStatus.onHold:
        return style.yellowBgColor;
      case ProjectStatus.wip:
        return style.blueInProgressBackgroundColor;
    }
  }

  Color _getTextColor(ProjectStatus status, StatusBadgeStyle style) {
    switch (status) {
      case ProjectStatus.orangeInProgress:
        return style.orangeInProgressTextColor;
      case ProjectStatus.active:
        return style.activeTextColor;
      case ProjectStatus.onGoing:
        return style.orangeInProgressTextColor;
      case ProjectStatus.winner:
        return style.activeTextColor;
      case ProjectStatus.lost:
        return style.lostTextColor;
      case ProjectStatus.blueInProgress:
        return style.blueInProgressTextColor;
      case ProjectStatus.approved:
        return style.activeTextColor;
      case ProjectStatus.released:
        return style.activeTextColor;
      case ProjectStatus.approval:
        return style.activeTextColor;
      case ProjectStatus.styleCreated:
        return style.activeTextColor;
      case ProjectStatus.onTime:
        return style.blueInProgressTextColor;
      case ProjectStatus.created:
        return style.activeTextColor;
      case ProjectStatus.inActive:
        return style.lostTextColor;
      case ProjectStatus.onHold:
        return style.yellowTextColor;
      case ProjectStatus.wip:
        return style.blueInProgressTextColor;
    }
  }
}
