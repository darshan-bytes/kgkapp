import 'package:kgk/kgk.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final double? height;
  final double? rightPosition;
  final double? topPosition;
  final String onDeniedText;
  final String onApprovedText;
  final VoidCallback? onDenied;
  final VoidCallback onApproved;

  const ConfirmationDialog({
    super.key,
    this.title,
    this.message,
    this.height,
    this.rightPosition,
    this.topPosition,
    required this.onDeniedText,
    required this.onApprovedText,
    this.onDenied,
    required this.onApproved,
  });

  @override
  Widget build(BuildContext context) {
    final EditWatchlistStyle style = AppTheme.of(context).editWatchlistStyle;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsetsDirectional.all(16.w),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmartText(title, style: style.titleStyle),
                  SizedBox(height: 6.h),
                  SmartText(message, style: style.subTitleStyle),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      if (onDenied != null) ...[
                        Expanded(child: SmartButton.white(onTap: onDenied!, title: onDeniedText)),
                        SizedBox(width: 16.w),
                      ],
                      Expanded(child: SmartButton(onTap: onApproved, title: onApprovedText)),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
