import 'package:kgk/kgk.dart';

class AddWatchlistScreen extends StatelessWidget {
  const AddWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WatchListItemStyle style = AppTheme.of(context).watchListItemStyle;
    final AddToWatchlistBloc bloc = BlocProvider.of<AddToWatchlistBloc>(context);
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
                      _buildCreateWatchlistButton(context),
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: style.disableBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (bloc.productDetails?.isOutOfStock ?? false) ...[
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
                    SmartText(
                      bloc.productDetails?.name ?? '',
                      maxLines: 2,
                      style: style.subTitleStyle,
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        SmartText(
                          bloc.productDetails?.company,
                          style: style.subTextStyle,
                        ),
                        SmartText(
                          ' | ',
                          style: style.subTextStyle,
                        ),
                        SmartText(
                          bloc.productDetails?.productSku,
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

  Widget _buildWatchlistNameField(AddToWatchlistBloc bloc) {
    return BlocBuilder<AddToWatchlistBloc, AddToWatchlistState>(
      buildWhen: (previous, current) => current is WatchlistChangeNameState,
      builder: (context, state) {
        return SmartDropDown<WatchlistDetailsModel>(
          hintText: APPStrings.hintWatchlistName.tr,
          labelText: APPStrings.watchlist.tr,
          items: bloc.arrWatchlist.map((WatchlistDetailsModel watchlist) {
            return SmartDropDownItem<WatchlistDetailsModel>(
              value: watchlist,
              title: watchlist.name ?? '',
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
                      padding: EdgeInsets.symmetric(vertical: 8.h),
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
                            bloc.arrSelectedWatchlist[index].name,
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
        padding: EdgeInsets.symmetric(horizontal: 17.w),
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
                  context.pop();
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
