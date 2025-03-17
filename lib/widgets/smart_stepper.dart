import 'package:kgk/kgk.dart';

class SmartStep {
  final String title;
  final Widget content;
  final TextStyle? titleStyle;

  SmartStep({required this.title, required this.content, this.titleStyle});
}

class SmartTileLineStepper extends StatefulWidget {
  final int currentStep;
  final List<SmartStep> steps;
  final Color? activeColor;
  final Color? completedColor;
  final Color? upcomingColor;

  const SmartTileLineStepper({
    super.key,
    required this.currentStep,
    required this.steps,
    this.activeColor,
    this.completedColor,
    this.upcomingColor,
  });

  @override
  State<SmartTileLineStepper> createState() => _SmartTileLineStepperState();
}

class _SmartTileLineStepperState extends State<SmartTileLineStepper> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _visibleSteps = [];

  @override
  void initState() {
    super.initState();
    _animateSteps();
  }

  Future<void> _animateSteps() async {
    for (int i = 0; i < widget.steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      _visibleSteps.add(i);
      _listKey.currentState?.insertItem(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SmartTileLineStepperStyle style = AppTheme.of(context).smartTileLineStepperStyle;
    return AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      initialItemCount: _visibleSteps.length,
      itemBuilder: (context, index, animation) {
        final SmartStep step = widget.steps[index];
        final currentStep = widget.currentStep;
        final bool isCompleted = index < currentStep;
        final bool isActive = index == currentStep;
        final bool isUpcoming = index > currentStep;

        return SizeTransition(
          sizeFactor: animation,
          child: _buildSmartStep(
              style: style,
              title: step.title,
              content: step.content,
              isActive: isActive,
              isCompleted: isCompleted,
              isUpcoming: isUpcoming,
              activeColor: widget.activeColor,
              completedColor: widget.completedColor,
              upcomingColor: widget.upcomingColor,
              index: index,
              showDivider: index < (widget.steps.length - 1),
              stepItem: step),
        );
      },
    );
  }

  Widget _buildSmartStep({
    required bool isActive,
    required bool isCompleted,
    required bool isUpcoming,
    required String title,
    required Widget content,
    required bool showDivider,
    required int index,
    required SmartTileLineStepperStyle style,
    required SmartStep stepItem,
    Color? activeColor,
    Color? completedColor,
    Color? upcomingColor,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIcon(isActive, isCompleted, isUpcoming, style,
                  activeColor: activeColor, completedColor: completedColor, upcomingColor: upcomingColor),
              if (showDivider) _buildDivider(style),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: stepItem.titleStyle ?? style.titleStyle),
                SizedBox(height: 4.h),
                content,
                if (showDivider) SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(bool isActive, bool isCompleted, bool isUpcoming, SmartTileLineStepperStyle style,
      {Color? activeColor, Color? completedColor, Color? upcomingColor}) {
    Color getColor() {
      if (isCompleted) return completedColor ?? style.completedIndicatorColor;
      if (isActive) return activeColor ?? style.completedIndicatorColor;
      if (isUpcoming) return upcomingColor ?? style.upcomingIndicatorColor;
      return style.completedIndicatorColor;
    }

    Widget getIcon() {
      if (isUpcoming) {
        return Container(
          height: 20.w,
          width: 20.w,
          margin: EdgeInsetsDirectional.all(2.w),
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: getColor(), width: 1.w)),
          alignment: AlignmentDirectional.center,
          child: Container(
            height: 12.w,
            width: 12.w,
            decoration: BoxDecoration(shape: BoxShape.circle, color: getColor()),
          ),
        );
      }
      return Container(
        height: 24.w,
        width: 24.w,
        alignment: AlignmentDirectional.center,
        child: Container(
          height: 12.w,
          width: 12.w,
          decoration: BoxDecoration(
            color: getColor(),
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    return getIcon();
  }

  Widget _buildDivider(SmartTileLineStepperStyle style) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 6.h),
        child: CustomPaint(
          painter: DashedLinePainter(color: style.completedIndicatorColor),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 1.w;

    var max = size.height;
    var dashWidth = 4.w;
    var dashSpace = 4.w;
    double startY = 0.w;
    while (startY < max) {
      canvas.drawLine(Offset(0.w, startY), Offset(0.w, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
