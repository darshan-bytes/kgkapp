import 'package:kgk/kgk.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          buildWhen: (_, current) => current is CategoriesSelected,
          builder: (context, state) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: ListView.builder(
                itemCount: (categoriesBloc.categories.length / 3).ceil(), // Calculate the number of rows needed
                itemBuilder: (context, index) {
                  final startIndex = index * 3;
                  final endIndex = startIndex + 3;
                  final sublist = categoriesBloc.categories
                      .sublist(startIndex, endIndex > categoriesBloc.categories.length ? categoriesBloc.categories.length : endIndex);
                  return Column(
                    children: [
                      CategoryRow(
                        categories: sublist,
                        rowIndex: index,
                        selectedIndex: (categoriesBloc.selectedRowIndex ?? -1) == index ? (categoriesBloc.selectedItemIndex ?? -1) : -1,
                        onCategorySelected: (itemIndex) {
                          categoriesBloc.add(CategoriesSelectedEvent(index, itemIndex));
                        },
                      ),
                      if (categoriesBloc.selectedRowIndex == index)
                        SelectedCategoryDetails(
                          arrowPosition: categoriesBloc.arrowPosition,
                          productsDetailsList: categoriesBloc.productsDetailsList,
                        ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
