import 'package:kgk/kgk.dart';

class AddWatchlistScreen extends StatelessWidget {
  final ProductDetails? productDetails;

  const AddWatchlistScreen({super.key, this.productDetails});

  @override
  Widget build(BuildContext context) {
    final WatchListItemStyle style = AppTheme.of(context).watchListItemStyle;
    final ProductListBloc bloc = BlocProvider.of<ProductListBloc>(context);
    return SmartSingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  _buildAppBar(style, context),
                  SizedBox(
                    height: 8.h,
                  ),
                  SmartText(
                    APPStrings.selectTheWatchlistYouWouldLikeProductToBeAdded.tr,
                    maxLines: 2,
                    style: style.subTextStyle,
                  ),
                  SizedBox(height: 16.h),
                  _productWatchDetails(style, bloc),
                  SizedBox(height: 16.h),
                  _buildWatchlistNameField(bloc),
                  SizedBox(height: 10.h),
                  _buildCreateWatchlistButton(context),
                  SizedBox(height: 16.h),
                  _buildCheckboxList(
                    context,
                    bloc,
                    style,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            const Divider(),
            SizedBox(height: 24.h),
            _bottomNavigationBar(context),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(WatchListItemStyle style, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(
          APPStrings.addToWatchList.tr,
          style: style.titleStyle,
        ),
        SmartImage(
          path: AppImages.icCross,
          height: 24.w,
          width: 24.w,
          color: style.primaryColor,
          onTap: () {
            context.pop();
          },
        ),
      ],
    );
  }

  Widget _productWatchDetails(WatchListItemStyle style, ProductListBloc bloc) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: style.disableBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (productDetails?.isOutOfStock ?? false) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: style.outOfStockBgColor,
              ),
              child: SmartText(
                APPStrings.outOfStock.tr,
                style: style.labelTextStyle,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
          Row(
            children: [
              SmartImage(
                path: productDetails?.imageUrl ?? '',
                width: 48.w,
                height: 48.h,
                imageBorderRadius: BorderRadius.circular(6.r),
              ),
              SizedBox(width: 12.w), // Space between icons and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmartText(
                      productDetails?.name ?? '',
                      maxLines: 2,
                      style: style.subTitleStyle,
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        SmartText(
                          'Martin Flyer',
                          style: style.subTextStyle,
                        ),
                        SmartText(
                          ' | ',
                          style: style.subTextStyle,
                        ),
                        SmartText(
                          'DERS01XXSRR',
                          style: style.subTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistNameField(ProductListBloc bloc) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      buildWhen: (previous, current) => current is WatchlistChangeNameState,
      builder: (context, state) {
        return SmartDropDown<WatchlistSelectionModel>(
          hintText: APPStrings.hintWatchlistName.tr,
          labelText: APPStrings.watchlist.tr,
          items: bloc.arrWatchlist.map((WatchlistSelectionModel watchlist) {
            return SmartDropDownItem<WatchlistSelectionModel>(
              value: watchlist,
              title: watchlist.name,
            );
          }).toList(),
          onChanged: (watchlist) {
            if (watchlist != null) {
              bloc.add(WatchlistChangeNameEvent(watchlist));
            }
          },
          selectedItem: bloc.selectedWatchlistName,
        );
      },
    );
  }

  Widget _buildCreateWatchlistButton(BuildContext context) {
    return SmartButton(
      onTap: () async {
        BlocProvider.of<EditWatchlistBloc>(context).add(const EditWatchlistInitialEvent(isEdit: false));
        context.pop();
        await Utils.showSmartModalBottomSheet(
          context: getNavigatorKeyContext,
          enableDrag: false,
          builder: (context) {
            return const EditWatchlistScreen();
          },
        ).then((value) {
          Utils.showSmartModalBottomSheet(
            context: getNavigatorKeyContext,
            enableDrag: false,
            builder: (context) {
              return AddWatchlistScreen(
                productDetails: productDetails,
              );
            },
          );
        });
      },
      title: APPStrings.createWatchlist.tr,
    );
  }

  Widget _buildCheckboxList(BuildContext context, ProductListBloc bloc, WatchListItemStyle style) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      buildWhen: (previous, current) => current is WatchlistSelectedState,
      builder: (context, state) {
        printWrapped(bloc.arrSelectedWatchlist.length.toString());
        if (bloc.arrSelectedWatchlist.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noWatchlistFound.tr); // Adjust text based on the selected tab if necessary
        }
        return ListView.builder(
          itemCount: bloc.arrSelectedWatchlist.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    bloc.add(WatchlistCheckEvent(checkWatchlist: bloc.arrSelectedWatchlist[index]));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      children: [
                        SmartCheckbox(
                          value: bloc.arrSelectedWatchlist[index].isSelected,
                          onChanged: (value) {
                            bloc.add(WatchlistCheckEvent(checkWatchlist: bloc.arrSelectedWatchlist[index]));
                          },
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        SmartText(
                          bloc.arrSelectedWatchlist[index].name,
                          style: style.listTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 17.w,
      ),
      child: Row(
        children: [
          Expanded(
            child: SmartButton.white(
              onTap: () {
                context.pop();
              },
              title: APPStrings.cancel.tr,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(child: SmartButton(onTap: () {}, title: APPStrings.add.tr)),
        ],
      ),
    );
  }
}
