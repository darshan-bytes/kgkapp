import 'package:kgk/kgk.dart';

class DotIndicator extends StatelessWidget {
  final Color dotColor;

  const DotIndicator({super.key, required this.dotColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 2.h,
            width: 5.w,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(1.r)),
            ),
          ),
          Container(
            height: 2.h,
            width: 10.w,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(1.r), start: Radius.circular(1.r)),
            ),
          ),
          Container(
            height: 2.h,
            width: 10.w,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(1.r), start: Radius.circular(1.r)),
            ),
          ),
          Container(
            height: 2.h,
            width: 5.w,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(1.r)),
            ),
          ),
        ],
      ),
    );
  }
}
