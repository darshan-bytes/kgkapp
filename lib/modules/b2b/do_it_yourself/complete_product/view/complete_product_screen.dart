import 'package:kgk/kgk.dart';

class CompleteProductScreen extends StatelessWidget {
  const CompleteProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CompleteProductBloc>(context);
    final CompleteProductStyle style = AppTheme.of(context).completeProductStyle;
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductLoadedState,
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(preferredSize: context.appBarHeight, child: SmartAppBar(title: bloc.productName, onFavorite: () {})),
          body: BlocBuilder<CompleteProductBloc, CompleteProductState>(
            buildWhen: (previous, current) => current is CompleteProductLoadedState,
            builder: (context, state) {
              if (state is! CompleteProductLoadedState) {
                return const SizedBox.shrink();
              }
              return SmartSingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DiyProgressWidget(selectedStep: 3, screenIdentifier: bloc.screenIdentifier, diyType: bloc.diyType),
                    SmartCarouselSlider(imgList: bloc.imgList, controller: bloc.controller),
                    SizedBox(height: 40.h),
                    _productDetail(style, bloc, context),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: bottomNavigationBar(style, bloc),
        );
      },
    );
  }

  Widget bottomNavigationBar(CompleteProductStyle style, CompleteProductBloc bloc) {
    return BlocBuilder<CompleteProductBloc, CompleteProductState>(
      buildWhen: (previous, current) => current is CompleteProductLoadedState,
      builder: (context, state) {
        if (state is! CompleteProductLoadedState) {
          return const SizedBox();
        }
        return Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 14.h, horizontal: 17.w),
          decoration: BoxDecoration(
            color: style.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 7.r,
                blurRadius: 7.r,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmartImage(path: bloc.imgList.isNotEmpty ? bloc.imgList.first : '', height: 55.w, width: 55.w),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmartText(APPStrings.approxPrice.tr, style: style.productTypeStyle),
                      SizedBox(height: 4.w),
                      SmartText(bloc.dIYPrice?.totalDiscountPrice?.setCurrency, style: style.priceStyle, maxLines: 1, isAutoSizeText: true),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 5,
                  child: SmartButton(
                    prefixImage: AppImages.icShoppingBag,
                    onTap: () {
                      bloc.add(CompleteProductAddToBagEvent(context));
                    },
                    title: bloc.productDetails?.isAddedToCart == true ? APPStrings.goToBag.tr : APPStrings.addToBag.tr,
                    height: 55.h,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _productDetail(CompleteProductStyle style, CompleteProductBloc bloc, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              if (bloc.productDetails != null && bloc.productDetails!.brandName.isNotNullNorEmpty)
                SmartText(bloc.productDetails?.brandName, style: style.productTypeStyle),
              if (bloc.productDetails != null &&
                  bloc.productDetails!.brandName.isNotNullNorEmpty &&
                  bloc.productDetails!.productSku.isNotNullNorEmpty) ...[
                SizedBox(width: 8.w),
                Container(
                  height: 4.w,
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: colors(context).color8C8C8C,
                    border: Border.all(color: colors(context).color8C8C8C),
                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              if (bloc.productDetails != null && bloc.productDetails!.productSku.isNotNullNorEmpty)
                SmartText(bloc.productDetails?.productSku, style: style.productCodeStyle),
            ],
          ),
          SizedBox(height: 8.h),
          SmartText(bloc.productName, style: style.productNameStyle),
          Divider(height: 40.h),
          if ((bloc.diamondDetails?.name).isNotNullNorEmpty) ...[
            ProductSelectedSettings(
              onTap: () {
                context.popUntilOfContext((route) => route.settings.name == AppRoutes.stoneListingPage);
              },
              selectedSettings: SelectedSettings(
                name: bloc.diamondDetails?.name,
                price: bloc.diamondDetails?.finalPrice,
                specification: bloc.displaySpecification,
                image: AppImages.icBlankDiamond,
                imageColor: style.ratingGlowColor,
              ),
            ),
            SizedBox(height: 24.h),
          ],
          if (bloc.productName.isNotNullNorEmpty) ...[
            ProductSelectedSettings(
              onTap: () => context.popUntilOfContext((route) => route.settings.name == AppRoutes.settingListingPage),
              selectedSettings: SelectedSettings(
                name: bloc.productName,
                price: bloc.productDetails?.finalPrice,
                specification: null,
                image: AppImages.icRing,
              ),
            ),
            SizedBox(height: 16.h),
          ],
          Row(
            children: [
              SmartText(APPStrings.buyingInBulk.tr, style: style.productTypeStyle),
              SizedBox(width: 12.w),
              SmartButton(
                title: APPStrings.askForQuotation.tr,
                width: 170.w,
                height: 40.h,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                onTap: () {
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    builder:
                        (context) => QuotationRequestConfirmation(
                          onContinueShopping: () {
                            context.pop();
                          },
                        ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SmartText(APPStrings.approxPriceNote.tr, style: style.productTypeStyle),
          SizedBox(height: 32.h),
          Row(
            children: [
              SmartImage(path: AppImages.icDiamond, height: 24.w, width: 24.w),
              SizedBox(width: 16.w),
              SmartText(APPStrings.diamondPurityYouCanTrust.tr, style: style.diamondPurityStyle),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const SmartImage(path: AppImages.icTruck),
              SizedBox(width: 16.w),
              SmartText(APPStrings.shippingAcrossAllCountries.tr, style: style.diamondPurityStyle),
            ],
          ),
          SizedBox(height: 32.h),
          Divider(height: 1.h),
          SizedBox(height: 28.h),
          const InquiryWidget(email: 'enquiry.diaind@kgkmail.com', phone: '+91 - 1234567830'),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _settingWidget(String type, String value, BuildContext context) {
    final style = AppTheme.of(context).settingDetailScreenStyle;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [SmartText(type, style: style.settingTypeStyle), SmartText(value, style: style.settingValueStyle)],
    );
  }
}
