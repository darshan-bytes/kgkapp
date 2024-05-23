import 'package:kgk/app/app_const.dart';
import 'package:kgk/kgk.dart';

class DiamondListingScreen extends StatelessWidget {
  const DiamondListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondListingStyle;
    final DiamondListingBloc diamondListingBloc = BlocProvider.of<DiamondListingBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppConst.appBarHeight),
        child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
          builder: (context, state) {
            return SmartAppBar(
              title: diamondListingBloc.diamondListingAppbarTitle,
              onFilter: () {},
              onFavorite: () {},
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  height: 64,
                  color: Colors.grey,
                  width: double.infinity,
                ),
                const SizedBox(height: 24),
                _buildSelectionDiamond(diamondListingBloc),
                const SizedBox(height: 24),
                _buildProductFilterCount(style, diamondListingBloc),
                const SizedBox(height: 24),
                _buildProductList(style, diamondListingBloc),
              ],
            ),
          ));
        },
      )),
    );
  }

  Widget _buildSelectionDiamond(DiamondListingBloc diamondListingBloc) {
    return Row(
      children: [
        Expanded(
          child: SelectionButton(
            isSelected: diamondListingBloc.isIndividual,
            title: APPStrings.naturalDiamond.tr,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
            onTap: () {
              diamondListingBloc.add(const DiamondChangeTypeEvent(true));
            },
          ),
        ),
        Expanded(
          child: SelectionButton(
            isSelected: !diamondListingBloc.isIndividual,
            title: APPStrings.looseDiamond.tr,
            image: AppImages.icCompany,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
            onTap: () {
              diamondListingBloc.add(const DiamondChangeTypeEvent(false));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductFilterCount(DiamondListingStyle style, DiamondListingBloc diamondListingBloc) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText('Showing 1-24 of 100', style: style.filterProductCountTextStyle),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SelectionButton(
                  width: 48,
                  isSelected: diamondListingBloc.isGrid,
                  image: AppImages.icGrid,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                  onTap: () {
                    diamondListingBloc.add(const ChangeListingTypeEvent(true));
                  },
                ),
                SelectionButton(
                  width: 48,
                  isSelected: !diamondListingBloc.isGrid,
                  image: AppImages.icList,
                  selectedButtonColor: style.gridBackgroundColor,
                  selectedButtonBorderColor: style.gridBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  unselectedButtonIconColor: style.listIconColor,
                  unselectedButtonColor: style.listBackgroundColor,
                  unselectedButtonBorderColor: style.listBorderColor,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                  onTap: () {
                    diamondListingBloc.add(const ChangeListingTypeEvent(false));
                  },
                ),
                const SizedBox(width: 16),
                SelectionButton(
                  width: 48,
                  isSelected: true,
                  selectedButtonColor: style.menuBackgroundColor,
                  selectedButtonBorderColor: style.menuBorderColor,
                  selectedButtonIconColor: style.gridIconColor,
                  image: AppImages.icMenu,
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductList(DiamondListingStyle style, DiamondListingBloc diamondListingBloc) {
    return BlocBuilder<DiamondListingBloc, DiamondListingState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (diamondListingBloc.productList.isEmpty) {
          return const Center(child: SmartText('No product found'));
        } else {
          if (diamondListingBloc.isGrid) {
            // return LayoutBuilder(
            //     builder: (context, constraints) => ConstrainedBox(
            //           constraints: BoxConstraints(minHeight: constraints.minHeight),
            //           child: IntrinsicHeight(
            //             child: ProductGridItem(productDetails: diamondListingBloc.productList[0]),
            //           ),
            //         ));
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return LayoutBuilder(
                  builder: (context, constraints) => ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(child: ProductGridItem(productDetails: diamondListingBloc.productList[index]))),
                );
              },
              itemCount: diamondListingBloc.productList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => ProductListviewItem(productDetails: diamondListingBloc.productList[index]),
              itemCount: diamondListingBloc.productList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            );
          }
        }
      },
    );
  }
}
