import 'package:kgk/kgk.dart';

class FilterBottomActionBar extends StatelessWidget {
  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;

  const FilterBottomActionBar({
    super.key,
    required this.onFilterTap,
    required this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: style.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
              child: SelectionButton(
                  isSelected: false,
                  image: AppImages.icFilter,
                  title: APPStrings.filter.tr,
                  iconBetweenSpace: 6,
                  borderRadius: const BorderRadius.all(Radius.zero),
                  unselectedButtonBorderColor: style.transparentColor,
                  onTap: onFilterTap)),
          Container(height: 24, width: 1, color: style.dividerColor),
          Expanded(
              child: SelectionButton(
                  isSelected: false,
                  image: AppImages.icSort,
                  title: APPStrings.sort.tr,
                  iconBetweenSpace: 6,
                  borderRadius: const BorderRadius.all(Radius.zero),
                  unselectedButtonBorderColor: style.transparentColor,
                  onTap: onSortTap)),
        ],
      ),
    );
  }
}
