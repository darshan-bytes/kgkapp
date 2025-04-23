import 'package:kgk/kgk.dart';

class FilterBottomActionBar extends StatelessWidget {
  final VoidCallback? onFilterTap;
  final VoidCallback? onSortTap;
  final ScrollController? controller;

  const FilterBottomActionBar({super.key, this.onFilterTap, this.onSortTap, this.controller});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;

    Widget child = SafeArea(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: style.borderColor)),
        child: Row(
          children: [
            if (onFilterTap != null)
              Expanded(
                child: SelectionButton(
                  isSelected: false,
                  image: AppImages.icFilter,
                  title: APPStrings.filter.tr,
                  iconBetweenSpace: 6.w,
                  borderRadius: const BorderRadius.all(Radius.zero),
                  unselectedButtonBorderColor: style.transparentColor,
                  onTap: onFilterTap!,
                ),
              ),
            if (onFilterTap != null && onSortTap != null) Container(height: 24.h, width: 1.w, color: style.dividerColor),
            if (onSortTap != null)
              Expanded(
                child: SelectionButton(
                  isSelected: false,
                  image: AppImages.icSort,
                  title: APPStrings.sort.tr,
                  iconBetweenSpace: 6.w,
                  borderRadius: const BorderRadius.all(Radius.zero),
                  unselectedButtonBorderColor: style.transparentColor,
                  onTap: onSortTap!,
                ),
              ),
          ],
        ),
      ),
    );
    return controller != null ? ScrollToHideWidget(controller: controller!, child: child) : child;
  }
}
