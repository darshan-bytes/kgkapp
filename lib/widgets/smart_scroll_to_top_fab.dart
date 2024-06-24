import 'package:kgk/kgk.dart';

class ScrollToTopFAB extends StatelessWidget {
  final ValueNotifier<bool> canScrollToTop;
  final VoidCallback onTap;

  const ScrollToTopFAB({
    super.key,
    required this.canScrollToTop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: ValueListenableBuilder(
          valueListenable: canScrollToTop,
          builder: (context, value, child) {
            if (!value) {
              return const SizedBox.shrink();
            }
            return FloatingActionButton(
              onPressed: () {
                onTap();
              },
              child: const Icon(Icons.arrow_upward),
            );
          }),
    );
  }
}
