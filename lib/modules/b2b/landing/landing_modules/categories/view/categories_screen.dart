import 'package:kgk/kgk.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        isBack: false,
        leadingImage: "https://i.ibb.co/cyvpMrR/KGK-Group-Logo-1.png",
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
        onNotification: () {
          context.pushNamed(AppRoutes.notificationPage);
        },
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        buildWhen: (_, current) => current is CategoriesSelected,
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
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
                        scrollController: categoriesBloc.scrollController,
                        onProductSelected: (value) {
                          if (sublist[categoriesBloc.selectedItemIndex ?? 0].name == 'Gemstone') {
                            context.pushNamed(AppRoutes.stoneListingPage,
                                arguments: {RoutesData.isPageFor: ScreenIdentifier.productForGemstones});
                          } else if (sublist[categoriesBloc.selectedItemIndex ?? 0].name == 'Do It \nYourself') {
                            context
                                .pushNamed(AppRoutes.stoneListingPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.diamondForDIY});
                          } else if (sublist[categoriesBloc.selectedItemIndex ?? 0].name == 'PDD') {
                            context.pushNamed(AppRoutes.conceptListPage);
                          }
                        },
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
