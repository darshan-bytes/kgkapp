import 'package:kgk/kgk.dart';

class ProductListGridScreen extends StatelessWidget {
  const ProductListGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductListGridBloc bloc = BlocProvider.of<ProductListGridBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.ring.tr,
        onFavorite: () {},
        onFilter: () {},
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: BlocBuilder<ProductListGridBloc, ProductListGridState>(
            buildWhen: (previous, current) => current is ChangePageNumberState,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    GridView.builder(
                        itemCount: 30,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 10.0, // Spacing between columns
                          mainAxisSpacing: 10.0,
                          childAspectRatio: MediaQuery.of(context).size.width / 730,
                        ),
                        itemBuilder: (context, index) {
                          return ProductGridItem(
                            productDetails: ProductDetails(
                              imageUrl:
                                  'https://s3-alpha-sig.figma.com/img/b565/a299/4cad8feb0dc565fcb23a5df4b8a8aa9f?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bngvfjokcYR5qP3qicAkkvvY9SxFgBLXhBlaL~4lqLjlUOko6k2LOmg5LT5GSAikSbdf4TJh64kIfhs59GcliNFg9UQU9Zstps6QkpWjHsgc~kInzl3rKyBeeFTQDGMFwLzBsLdjlnQiYh7uN3Y8xPpFeW7xewz~z9TST5RzBgFkAd2d-jyJiyrnlOc5ubcYsSlBG3DpKp7--GzK4OzkespCMjGgFO608x3N-~~CVZd5QeNBYTLTJODLe9DABhX~DDeTDyun-3Ihcp7jvxl7y9UbR9zLQDR6H67fYYxXN3WhLZshgLz8RVAT~RG-UDqKv2zTyMd-f8xi9E4CAy7sng__',
                              name: "Diamond Vine Ring in 18k Rose Gold",
                              originalPrice: '\$5,000.00',
                              discountPercentage: "You have saved 10%",
                              offerPrice: '\$3,000.00',
                            ),
                            onEyeTap: () {},
                            onFavTap: () {},
                            onAddToBagTap: () {},
                          );
                        }),
                    const SizedBox(
                      height: 14,
                    ),
                    SmartPagination(
                      pageNumbers: bloc.pageNumbers,
                      currentPage: bloc.selectedPageNumber,
                      onPageChanged: (int index, String newValue) {
                        bloc.add(ChangePageNumberEvent(newValue));
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
