import 'package:kgk/kgk.dart';

class DiamondListingScreen extends StatelessWidget {
  const DiamondListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).diamondListingStyle;
    final DiamondListingBloc diamondListingBloc = BlocProvider.of<DiamondListingBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppConst.appBarHeight,
        child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
          builder: (context, state) {
            return SmartAppBar(
              title: diamondListingBloc.diamondListingAppbarTitle,
              onFilter: () {},
              onFavorite: () {
                context.pushNamed(AppRoutes.wishListPage);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<DiamondListingBloc, DiamondListingState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<DiamondListingBloc, DiamondListingState>(builder: (context, state) {
              return SmartPagination(
                pageNumbers: diamondListingBloc.pageNumbers,
                currentPage: diamondListingBloc.selectedPageNumber,
                onPageChanged: (int index, String newValue) {
                  diamondListingBloc.add(DiamondProductChangePageNumberEvent(newValue));
                },
              );
            }),
            FilterBottomActionBar(
              onFilterTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => FilterScreen(
                    onApply: () {},
                  ),
                );
              },
              onSortTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => const SortScreen(),
                );
              },
            ),
          ],
        );
      }),
      body: SingleChildScrollView(child: BlocBuilder<DiamondListingBloc, DiamondListingState>(
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              children: [
                if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondListingForDIY) SizedBox(height: 16.h),
                if (diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondListingForDIY)
                  const DiyProgressWidget(padding: EdgeInsets.zero, selectedStep: 1),
                SizedBox(height: 24.h),
                _buildSelectionDiamond(diamondListingBloc),
                SizedBox(height: 24.h),
                _buildProductFilterCount(style, diamondListingBloc),
                SizedBox(height: 24.h),
                _buildProductList(style, diamondListingBloc),
                SizedBox(height: 7.h),
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
            borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
            onTap: () {
              diamondListingBloc.add(const DiamondChangeTypeEvent(true));
            },
          ),
        ),
        Expanded(
          child: SelectionButton(
            isSelected: !diamondListingBloc.isIndividual,
            title: APPStrings.looseDiamond.tr,
            borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
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
      height: 48.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(APPStrings.showingListLengthX.tr.interpolate(["1", "24"]), style: style.filterProductCountTextStyle),
          Row(
            children: [
              SelectionButton(
                width: 48.w,
                isSelected: diamondListingBloc.isGrid,
                image: AppImages.icGrid,
                imageHeight: 24.5.w,
                imageWidth: 24.5.w,
                selectedButtonColor: style.gridBackgroundColor,
                selectedButtonBorderColor: style.gridBorderColor,
                selectedButtonIconColor: style.gridIconColor,
                unselectedButtonIconColor: style.listIconColor,
                unselectedButtonColor: style.listBackgroundColor,
                unselectedButtonBorderColor: style.listBorderColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r)),
                onTap: () {
                  diamondListingBloc.add(const ChangeListingTypeEvent(true));
                },
              ),
              SelectionButton(
                width: 48.w,
                isSelected: !diamondListingBloc.isGrid,
                image: AppImages.icList,
                imageHeight: 18.h,
                selectedButtonColor: style.gridBackgroundColor,
                selectedButtonBorderColor: style.gridBorderColor,
                selectedButtonIconColor: style.gridIconColor,
                unselectedButtonIconColor: style.listIconColor,
                unselectedButtonColor: style.listBackgroundColor,
                unselectedButtonBorderColor: style.listBorderColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(4.r), bottomRight: Radius.circular(4.r)),
                onTap: () {
                  diamondListingBloc.add(const ChangeListingTypeEvent(false));
                },
              ),
              SizedBox(width: 16.w),
              SelectionButton(
                width: 48.w,
                imageHeight: 24.5.w,
                imageWidth: 24.5.w,
                isSelected: true,
                selectedButtonColor: style.menuBackgroundColor,
                selectedButtonBorderColor: style.menuBorderColor,
                selectedButtonIconColor: style.gridIconColor,
                image: AppImages.icMenu,
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList(DiamondListingStyle style, DiamondListingBloc diamondListingBloc) {
    return BlocBuilder<DiamondListingBloc, DiamondListingState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (diamondListingBloc.productList.isEmpty) {
          return const Center(child: SmartText(APPStrings.add));
        } else {
          if (diamondListingBloc.isGrid) {
            return Column(
              children: [
                SmartGridView(
                    items: diamondListingBloc.productList.map((ProductDetails productDetails) {
                  return ProductGridItem(
                    productDetails: productDetails,
                    isStoneWithPrice: true,
                    onTap: () {
                      context.pushNamed(AppRoutes.diamondDetailPage);
                    },
                    onEyeTap: () {},
                    onFavTap: () {},
                  );
                }).toList()),
                SizedBox(
                  height: 17.h,
                )
              ],
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => diamondListingBloc.screenIdentifier == ScreenIdentifier.diamondDetailForDIY
                  ? ProductListItem(
                      margin: EdgeInsets.only(bottom: 17.h),
                      onEyeTap: () {},
                      onFavTap: () {},
                      onAddToBagTap: () {},
                      productDetails: diamondListingBloc.productList[index],
                    )
                  : Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: ProductInfoItem(
                          onTap360View: () => printWrapped("onTap360View"),
                          onTapDNA: () => printWrapped("onTapDNA"),
                          onTapCertificate: () => printWrapped("onTapCertificate"),
                          onTapImageViewer: () => printWrapped("onTapImageViewer"),
                          onTapUSA: () => printWrapped("onTapUSA"),
                          onTapMenuButton: () => printWrapped("onTapMenuButton"),
                          isSelectedBackground: (index % 2 != 0),
                          productDetails: ProductDetails(
                            productInfoClarityChat: ProductInfoClarityChat(
                              productId: "1",
                              productName: "1.00 Cts Round Diamond",
                              ct: "10.04",
                              shape: "Marquise",
                              colour: "H",
                              clarity: "VVS1",
                              lotNumber: "MBFG716306",
                              certificateNumber: "230000066395",
                              measurements: "10.18 x 8.34 x 6.14",
                              lab: "GIA",
                              cut: "Excellent",
                              polish: "Excellent",
                              symmetry: "Excellent",
                              flourish: "O",
                              tablePercentage: "50",
                              depthPercentage: "50",
                              rap: "\$35,500.00",
                              discount: "-30.00",
                              perCts: "\$24,850.00",
                              amount: "\$1,24,995.50",
                            ),
                            productId: "1",
                            diamond: "1.5 gram",
                            gram: "1.5 gram",
                            imageUrl: "https://i.ibb.co/swb5gVs/Round.png",
                          )),
                    ),
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
