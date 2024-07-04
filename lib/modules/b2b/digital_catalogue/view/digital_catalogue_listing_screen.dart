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
      bottomNavigationBar: FilterBottomActionBar(
        onFilterTap: () {
          Utils.showSmartModalBottomSheet(
            context: context,
            builder: (context) => FilterScreen(
              onApply: () {},
            ),
          );
        },
      ),
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
                    _digitalCatalogueList(digitalCatalogueBloc, context),
                  ],
                );
              })),
    );
  }

  Widget _digitalCatalogueList(DigitalCatalogueBloc digitalCatalogueBloc, BuildContext context) {
    final DigitalCatalogueStyle style = AppTheme.of(context).digitalCatalogueStyle;
    return Expanded(
      child: ListView.separated(
        itemCount: digitalCatalogueBloc.digitalCatalogueList.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 24.h,
          );
        },
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        itemBuilder: (context, index) {
          final DigitalCatalogueListingModel item = digitalCatalogueBloc.digitalCatalogueList[index];
          return InkWell(
            onTap: () {
              context.pushNamed(AppRoutes.previewCataloguePage, arguments: {RoutesData.catalogueData: item});
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: style.borderColor, width: 1.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      SmartImage(
                        path: item.image ?? "",
                        height: 200.h,
                        width: context.width,
                      ),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        alignment: Alignment.topRight,
                        child: SmartImage(
                          path: AppImages.icMoreVertical,
                          imageBorderRadius: BorderRadius.circular(4.0.r),
                          width: 32.w,
                          height: 32.w,
                          onTap: () {},
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
                              APPStrings.xProducts.tr.interpolate([item.productCount]),
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
            ),
          );
        },
      ),
    );
  }
}
