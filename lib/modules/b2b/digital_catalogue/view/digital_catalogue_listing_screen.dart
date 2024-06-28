import 'package:kgk/kgk.dart';

class DigitalCatalogueListingScreen extends StatelessWidget {
  const DigitalCatalogueListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DigitalCatalogueBloc digitalCatalogueBloc = BlocProvider.of<DigitalCatalogueBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.catalogue.tr,
        onSearch: () {
          context.pushNamed(AppRoutes.searchPage);
        },
        onFavorite: () {
          context.pushNamed(AppRoutes.wishListPage);
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(digitalCatalogueBloc),
      body: SafeArea(
          child: BlocBuilder<DigitalCatalogueBloc, DigitalCatalogueState>(
              buildWhen: (previous, current) => current is DigitalCatalogueLoadedState,
              builder: (context, state) {
                return Column(
                  children: [
                    SmartTextField(
                      hintText: APPStrings.searchCatalogue.tr,
                      suffixIcon: SmartImage(path: AppImages.icSearchThin, padding: EdgeInsets.all(16.w)),
                      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
                    ),
                    Expanded(
                      child: _digitalCatalogueList(digitalCatalogueBloc, context),
                    ),
                  ],
                );
              })),
    );
  }
}

Widget _digitalCatalogueList(DigitalCatalogueBloc digitalCatalogueBloc, BuildContext context) {
  final DigitalCatalogueStyle style = AppTheme.of(context).digitalCatalogueStyle;
  return ListView.builder(
    itemCount: digitalCatalogueBloc.digitalCatalogueList.length,
    itemBuilder: (context, index) {
      final DigitalCatalogueListingModel item = digitalCatalogueBloc.digitalCatalogueList[index];
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.w),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: style.borderColor, width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      SmartImage(
                        path: item.image ?? "",
                        height: 200.w,
                        width: context.width,
                      ),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                            color: Colors.white,
                          ),
                          width: 32.w,
                          height: 32.w,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {},
                              child: const SmartImage(path: AppImages.icMoreVertical),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartText(
                          item.name,
                          style: style.titleStyle,
                        ),
                        Row(
                          children: [
                            SmartText(
                              '${item.productCount} Products',
                              style: style.subTitleStyle,
                            ),
                            const Spacer(),
                            SmartText(
                              item.date,
                              style: style.subTitleStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildBottomNavigationBar(DigitalCatalogueBloc digitalCatalogueBloc) {
  return SafeArea(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SelectionButton(
          borderRadius: BorderRadius.zero,
          isSelected: false,
          onTap: () {},
          image: AppImages.icFilter,
          title: APPStrings.filter.tr,
        ),
      ],
    ),
  );
}
