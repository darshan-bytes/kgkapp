import 'package:kgk/kgk.dart';

class TrackOrderBottomSheet extends StatelessWidget {
  const TrackOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailBloc orderDetailBloc = BlocProvider.of<OrderDetailBloc>(context);
    final TrackOrderBottomSheetStyle style = AppTheme.of(context).trackOrderBottomSheetStyle;

    return Container(
      color: style.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),
                _buildAppBar(context, style),
                SizedBox(height: 24.h),
                _buildOrderDetailsInfoCard(style),
                CustomStepper()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, TrackOrderBottomSheetStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(APPStrings.trackProduct.tr, style: style.titleStyle),
        SizedBox(width: 8.w),
        InkWell(
          onTap: () {
            context.pop();
          },
          child: const SmartImage(
            path: AppImages.icCross,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailsInfoCard(TrackOrderBottomSheetStyle style) {
    return Container(
      color: style.orderInfoBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            "Order #14567",
            style: style.orderIdStyle,
          ),
          SizedBox(height: 8.h),
          Material(
            child: ListTile(
                contentPadding: EdgeInsets.zero,
                isThreeLine: true,
                leading: SmartImage(
                  path: "https://i.ibb.co/8xM4BxQ/image-7.png",
                  height: 48.w,
                  width: 48.w,
                ),
                dense: true,
                horizontalTitleGap: 12.w,
                title: SmartText(
                  "Diamond Vine Ring in 18k Gold",
                  style: style.imageTitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    Flexible(
                      child: SmartText(
                        'Martin Flyer',
                        style: style.imageSubTitleStyle,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Flexible(
                      child: SmartText(
                        'DERS01XXSRR',
                        style: style.imageSubTitleStyle,
                      ),
                    ),
                  ],
                ),
                trailing: SmartText("x15", style: style.quantityStyle)),
          ),
        ],
      ),
    );
  }
}

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStep(
          index: 0,
          title: 'Step 1 title',
          content: 'Content for Step 1',
        ),
        // _buildStep(
        //   index: 1,
        //   title: 'Step 2 title',
        //   content: 'Content for Step 2',
        // ),
        // _buildStep(
        //   index: 2,
        //   title: 'Step 3 title',
        //   content: 'Content for Step 3',
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     TextButton(
        //       onPressed: _currentStep > 0 ? () => setState(() => _currentStep--) : null,
        //       child: const Text('Previous'),
        //     ),
        //     TextButton(
        //       onPressed: _currentStep < 2 ? () => setState(() => _currentStep++) : null,
        //       child: const Text('Next'),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildStep({required int index, required String title, required String content}) {
    bool isCompleted = index < _currentStep;
    bool isActive = index == _currentStep;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                _buildStepIndicator(isActive, isCompleted),
                if (index < 2) _buildStepConnector(isCompleted),
              ],
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(content),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildStepIndicator(bool isActive, bool isCompleted) {
    if (isCompleted) {
      return Container(
        height: 12,
        width: 12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
      );
    } else if (isActive) {
      return Container(
        height: 12,
        width: 12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
      );
    } else {
      return Container(
        height: 12,
        width: 12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      );
    }
  }

  Widget _buildStepConnector(bool isCompleted) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: CustomPaint(
        size: Size(1, 60.h), // Adjust the height as needed
        painter: DottedLinePainter(color: isCompleted ? Colors.green : Colors.grey),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5.0, dashSpace = 5.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
