import 'package:kgk/kgk.dart';

class CategoryRow extends StatelessWidget {
  final List<CategoriesModel> categories;
  final int rowIndex;
  final int selectedIndex;
  final void Function(int itemIndex) onCategorySelected;

  const CategoryRow({
    super.key,
    required this.categories,
    required this.rowIndex,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the number of dummy containers needed
    final int dummyCount = 3 - categories.length;

    return Row(
      children: [
        ...categories.asMap().entries.map((entry) {
          final category = entry.value;
          final itemIndex = entry.key;
          return Expanded(
            child: GestureDetector(
              onTap: () => onCategorySelected(itemIndex),
              child: CategoryTile(category: category, isSelected: selectedIndex == itemIndex),
            ),
          );
        }),
        // Add dummy containers if needed
        ...List.generate(dummyCount, (index) => const Expanded(child: DummyContainer())),
      ],
    );
  }
}

class DummyContainer extends StatelessWidget {
  const DummyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.all(8.0.w),
      color: Colors.transparent, // Or any other placeholder style
    );
  }
}
