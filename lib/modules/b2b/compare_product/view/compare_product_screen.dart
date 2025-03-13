import 'package:kgk/kgk.dart';

class CompareProductScreen extends StatelessWidget {
  const CompareProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CompareProductStyle style = AppTheme.of(context).compareProductStyle;
    final CompareProductBloc bloc = BlocProvider.of<CompareProductBloc>(context);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        bloc.setInitialized(false);
      },
      child: Scaffold(
          appBar: SmartAppBar(
            title: APPStrings.compareProduct.tr,
            onBack: () {
              bloc.setInitialized(false);
              context.pop();
            },
          ),
          body: BlocBuilder<CompareProductBloc, CompareProductState>(
            buildWhen: (previous, current) => current is CompareProductsLoadedState || current is CompareProductErrorState,
            builder: (context, state) {
              if (state is CompareProductsLoadedState) {
                if (bloc.compareResult.isEmpty) {
                  return SizedBox.shrink();
                }
                return SmartSingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.all(14.w),
                        child: SmartSingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Table(
                                defaultColumnWidth: const IntrinsicColumnWidth(),
                                columnWidths: bloc.generateTableColumnWidths(bloc.productIdList.length, 124.w),
                                children: [_buildTableRow(context, style, bloc)],
                              ),
                              SizedBox(
                                height: 132.h,
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: Container(
                          height: 132.w,
                          padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.5),
                                spreadRadius: 5.r,
                                blurRadius: 7.r,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Table(
                            defaultColumnWidth: const IntrinsicColumnWidth(),
                            columnWidths: bloc.generateTableColumnWidths(5, 124.w),
                            children: [
                              TableRow(
                                  children: List.generate(
                                      bloc.productIdList.length,
                                      (index) => SizedBox(
                                          width: 130.w,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SmartButton(
                                                onTap: () {
                                                  bloc.handleBagButtonClick(context, index);
                                                },
                                                title:
                                                    bloc.productList[index].isAddedToCart ? APPStrings.goToBag.tr : APPStrings.addToBag.tr,
                                                width: 114.w,
                                                height: 48.w,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  bloc.add(CompareProductRemoveProductEvent(
                                                      context: context, productId: bloc.productIdList[index], isFromCompareScreen: true));
                                                },
                                                child: Container(
                                                  height: 48.h,
                                                  width: 114.w,
                                                  alignment: AlignmentDirectional.center,
                                                  child: Icon(
                                                    Icons.delete_forever,
                                                    color: style.primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is CompareProductErrorState) {
                return NoDataFoundWidget(text: state.message);
              } else {
                return SizedBox.shrink();
              }
            },
          )),
    );
  }

  TableRow _buildTableRow(BuildContext context, CompareProductStyle style, CompareProductBloc bloc) {
    return TableRow(children: List.generate(bloc.productIdList.length, (index) => _buildTableCell(context, index, style, bloc)));
  }

  Widget _buildTableCell(BuildContext context, int index, CompareProductStyle style, CompareProductBloc bloc) {
    ProductDetailsModel productDetail = bloc.productList[index];
    return Container(
      width: 130.w,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartImage(
            path: bloc.commodity == Commodity.jewellery
                ? (bloc.compareResult[index]['multiple_finished_view_image'] as List?)?.firstOrNull['IMAGE_URL'] ?? ''
                : (bloc.compareResult[index]['image'] as List?)?.firstOrNull['URL'] ?? '',
            width: 114.w,
            height: 114.w,
            color: style.blackColor,
            onTap: () {
              if (bloc.commodity != null) {
                context.pushNamed(
                  AppRoutes.productDetailsPage,
                  arguments: {
                    RoutesData.productId: productDetail.productId,
                    RoutesData.isPageFor: Utils.getScreenIdentifierFromCommodity(bloc.commodity!),
                  },
                );
              }
            },
          ),
          SizedBox(height: 8.h),
          Container(
            margin: EdgeInsetsDirectional.only(end: 10.w),
            child: SmartText(
              productDetail.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: style.productTitleStyle,
            ),
          ),
          SizedBox(height: 8.h),
          SmartText(
            productDetail.finalPrice ?? productDetail.originalPrice ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.productPriceStyle,
          ),
          SizedBox(height: 28.h),
          ...(List.generate(bloc.filterList.length, (filterIndex) {
            FilterOptionModel filter = bloc.filterList[filterIndex];
            Map<String, dynamic> productDetail = bloc.compareResult[index];
            return _buildProductDetailWidgets(index, filter.name ?? '', productDetail[filter.slug]?.toString() ?? '-', style);
          })),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: index == 0,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: SmartText(
                  APPStrings.reviews.tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: style.productSubTitleStyle,
                ),
              ),
              SizedBox(height: 8.h),
              const Divider(),
              SizedBox(height: 8.h),
              SmartText(
                productDetail.rating?.toString(),
                style: style.productTitleStyle,
              ),
              SizedBox(height: 4.h),
              SmartRatingBar(
                initialRating: productDetail.rating ?? 0,
                itemSize: 14.w,
                ignoreGestures: true,
                onRatingUpdate: (rating) {},
              ),
              SizedBox(height: 6.h),
              SmartText(
                APPStrings.reviewsX.tr.interpolate([productDetail.reviewCount?.toString()]),
                style: style.productReviewStyle,
              ),
              SizedBox(height: 14.h),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductDetailWidgets(int index, String label, String value, CompareProductStyle style,
      {double textHeight = 48, int maxLines = 2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: SmartText(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: style.productSubTitleStyle,
          ),
        ),
        SizedBox(height: 8.h),
        const Divider(),
        SizedBox(height: 8.h),
        Container(
          margin: EdgeInsetsDirectional.only(end: 12.w),
          height: textHeight.h,
          child: SmartText(
            value.isNotNullNorEmpty ? value : '-',
            style: style.productTitleStyle,
            maxLines: maxLines,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
