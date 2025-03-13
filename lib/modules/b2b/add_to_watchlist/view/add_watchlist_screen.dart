import 'package:kgk/kgk.dart';

class AddWatchlistScreen extends StatelessWidget {
  const AddWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WatchListItemStyle style = AppTheme.of(context).watchListItemStyle;
    final AddToWatchlistBloc bloc = BlocProvider.of<AddToWatchlistBloc>(context);
    return SmartSingleChildScrollView(
      padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: style.backgroundColor,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(12.r),
            topEnd: Radius.circular(12.r),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  _buildAppBar(style, context, bloc),
                  SizedBox(
                    height: 8.h,
                  ),
                  SmartText(
                    bloc.isEdit
                        ? APPStrings.watchListDesc.tr
                        : (bloc.isRemove ? APPStrings.removeProductDesc.tr : APPStrings.selectTheWatchlistYouWouldLikeProductToBeAdded.tr),
                    maxLines: 2,
                    style: style.subTextStyle,
                  ),
                  SizedBox(height: 16.h),
                  _productWatchDetails(style, bloc),
                  if (!bloc.isRemove) ...[
                    SizedBox(height: 16.h),
                    if (!bloc.isEdit) ...[
                      _buildWatchlistNameField(bloc),
                      SizedBox(height: 10.h),
                      _buildCreateWatchlistButton(context, bloc),
                      SizedBox(height: 16.h),
                    ],
                    _buildCheckboxList(
                      context,
                      bloc,
                      style,
                    ),
                  ],
                ],
              ),
            ),
            if (bloc.isRemove) SizedBox(height: 32.h),
            _bottomNavigationBar(context, bloc),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(WatchListItemStyle style, BuildContext context, AddToWatchlistBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(
          bloc.isEdit ? APPStrings.notificationSettings.tr : (bloc.isRemove ? APPStrings.removeProduct.tr : APPStrings.addToWatchList.tr),
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

  Widget _productWatchDetails(WatchListItemStyle style, AddToWatchlistBloc bloc) {
    return Container(
      padding: EdgeInsetsDirectional.all(16.w),
      decoration: BoxDecoration(
        color: style.disableBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bloc.productDetails?.isOutOfStock ?? false) ...[
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
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
                path: bloc.productDetails?.imageUrl ?? '',
                width: 48.w,
                height: 48.h,
                imageBorderRadius: BorderRadius.circular(6.r),
              ),
              SizedBox(width: 12.w), // Space between icons and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmartText(bloc.productDetails?.name ?? '', maxLines: 2, style: style.subTitleStyle),
                    if (bloc.productDetails?.company != null || bloc.productDetails?.productSku != null) SizedBox(height: 5.h),
                    Row(
                      children: [
                        if (bloc.productDetails?.company != null) SmartText(bloc.productDetails?.company, style: style.subTextStyle),
                        if (bloc.productDetails?.company != null && bloc.productDetails?.productSku != null)
                          SmartText(' | ', style: style.subTextStyle),
                        if (bloc.productDetails?.productSku != null) SmartText(bloc.productDetails?.productSku, style: style.subTextStyle),
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

  Widget _buildWatchlistNameField(AddToWatchlistBloc bloc) {
    return BlocBuilder<AddToWatchlistBloc, AddToWatchlistState>(
      buildWhen: (previous, current) => current is WatchlistChangeNameState,
      builder: (context, state) {
        return SmartDropDown<WatchlistData>(
          hintText: APPStrings.hintWatchlistName.tr,
          labelText: APPStrings.watchlist.tr,
          emptyText: APPStrings.noWatchlistFound.tr,
          items: bloc.arrWatchlist.map((WatchlistData watchlist) {
            return SmartDropDownItem<WatchlistData>(
              value: watchlist,
              title: watchlist.name ?? '',
            );
          }).toList(),
          onChanged: (watchlist) {
            if (watchlist != null) {
              bloc.add(WatchlistChangeNameEvent(watchlist));
            }
          },
          selectedItem: bloc.selectedWatchlist,
        );
      },
    );
  }

  Widget _buildCreateWatchlistButton(BuildContext context, AddToWatchlistBloc bloc) {
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
        ).then((value) async {
          bloc.watchlistBloc.add(WatchListLoadFullListEvent(getNavigatorKeyContext));
          await bloc.watchlistBloc.allWatchlistFull.future;
          if (bloc.productDetails != null) {
            bloc.add(AddToWatchlistInitialEvent.add(bloc.productDetails!, getNavigatorKeyContext));
          }

          Utils.showSmartModalBottomSheet(
            context: getNavigatorKeyContext,
            enableDrag: false,
            builder: (context) {
              return const AddWatchlistScreen();
            },
          );
        });
      },
      title: APPStrings.createWatchlist.tr,
    );
  }

  Widget _buildCheckboxList(BuildContext context, AddToWatchlistBloc bloc, WatchListItemStyle style) {
    return ListView.builder(
      itemCount: bloc.arrSelectedWatchlist.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return BlocBuilder<AddToWatchlistBloc, AddToWatchlistState>(
            buildWhen: (previous, current) => current is WatchlistSelectedState && current.index == index,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      bloc.add(WatchlistCheckEvent(index: index));
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                      child: Row(
                        children: [
                          SmartCheckbox(
                            value: bloc.arrSelectedWatchlist[index].isSelected,
                            spaceBetweenLabelAndCheckbox: 0.w,
                            onChanged: (value) {
                              bloc.add(WatchlistCheckEvent(index: index));
                            },
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          SmartText(
                            bloc.arrSelectedWatchlist[index].name.tr,
                            style: style.listTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }

  Widget _bottomNavigationBar(BuildContext context, AddToWatchlistBloc bloc) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
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
            Expanded(
              child: SmartButton(
                onTap: () {
                  bloc.add(AddToWatchListSaveEvent(context));
                },
                title: bloc.isEdit ? APPStrings.save.tr : (bloc.isRemove ? APPStrings.remove.tr : APPStrings.add.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
