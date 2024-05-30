import 'package:kgk/kgk.dart';

class DotIndicator extends StatelessWidget {
  final Color dotColor;

  const DotIndicator({super.key, required this.dotColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 2,
            width: 5,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(1)),
            ),
          ),
          Container(
            height: 2,
            width: 10,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(1), left: Radius.circular(1)),
            ),
          ),
          Container(
            height: 2,
            width: 10,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(1), left: Radius.circular(1)),
            ),
          ),
          Container(
            height: 2,
            width: 5,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(1)),
            ),
          ),
        ],
      ),
    );
  }
}
