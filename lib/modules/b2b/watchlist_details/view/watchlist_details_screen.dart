import 'package:kgk/kgk.dart';

class WatchlistDetailsScreen extends StatelessWidget {
  const WatchlistDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WatchlistDetailsBloc bloc = BlocProvider.of<WatchlistDetailsBloc>(context);
    return PopScope(
      canPop: !bloc.isWatchlistUpdated,
      child: Scaffold(
        //Here I've used resizeToAvoidBottomInset as false to avoid the keyboard overlapping the content.
        // Also, there is no need to allow the user to scroll the content when the keyboard is open.
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(bloc, context),
        body: _buildBody(bloc, context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(WatchlistDetailsBloc bloc, BuildContext context) {
    return PreferredSize(
      preferredSize: context.appBarHeight,
      child: BlocBuilder<WatchlistDetailsBloc, WatchlistDetailsState>(
        buildWhen: (previous, current) => current is WatchlistDetailsLoaded,
        builder: (context, state) {
          return SmartAppBar(
            title: bloc.watchlistName,
            onBack: () {
              bloc.handleBack(context, needToPop: true);
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(WatchlistDetailsBloc bloc, BuildContext context) {
    return BlocBuilder<WatchlistDetailsBloc, WatchlistDetailsState>(
      buildWhen: (previous, current) => (current is WatchlistDetailsLoaded && current.isFirst),
      builder: (context, state) {
        if (state is WatchlistDetailsLoaded) {
          final WatchlistDetailsStyle style = AppTheme.of(context).watchlistDetailsStyle;
          return SmartSingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                _buildDetailsView(context, style, bloc),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SmartTextField.search(
                        height: 48.h,
                        controller: bloc.searchController,
                        hintText: APPStrings.searchX.tr.interpolate([APPStrings.watchlist.tr.toLowerCase()]),
                        onTapOutside: (PointerDownEvent p) {},
                        onValueChanges: (String value) {
                          bloc.add(WatchlistDetailsSearchEvent(value));
                        },
                      ),
                      SizedBox(height: 24.h),
                      _buildProductGrid(context, bloc)
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildDetailsView(BuildContext context, WatchlistDetailsStyle style, WatchlistDetailsBloc bloc) {
    return Container(
      color: style.detailsBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SmartText(bloc.watchlistName, style: style.watchlistNameStyle),
              ),
              SizedBox(width: 16.w),
              SmartStatusBadge(
                borderRadius: 22.r,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                currentStatus: bloc.watchlistDetailsModel.displayStatus,
              ),
              SizedBox(width: 16.w),
              SmartImage(
                path: AppImages.icMoreVertical,
                width: 24.w,
                height: 24.h,
                onTap: () {
                  //TODO: Show more options
                  _showWatchlistBottomSheet(context, bloc);
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailColumn(
                      APPStrings.noOfProducts.tr,
                      bloc.productList.length.toString(),
                      style,
                      titleStyle: style.noOfProductsStyle,
                    ),
                    SizedBox(height: 19.h),
                    _buildDetailColumn(
                      APPStrings.from.tr,
                      bloc.watchlistDetailsModel.displayFromDate,
                      style,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<WatchlistDetailsBloc, WatchlistDetailsState>(
                      buildWhen: (previous, current) => current is WatchlistDetailsTimerState,
                      builder: (context, state) {
                        return _buildDetailColumn(
                          APPStrings.remainingTime.tr,
                          bloc.watchlistRemainTime.formattedDurationWithSecondsShort,
                          style,
                          valueStyle: style.watchlistNameStyle,
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    _buildDetailColumn(
                      APPStrings.to.tr,
                      bloc.watchlistDetailsModel.displayToDate,
                      style,
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

  Widget _buildDetailColumn(String title, String? value, WatchlistDetailsStyle style,
      {bool isExpanded = false, TextStyle? titleStyle, TextStyle? valueStyle, int flex = 1}) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SmartText(title, style: titleStyle ?? style.watchlistTitleStyle),
        SizedBox(height: 4.h),
        SmartText(
          value ?? '-',
          style: valueStyle ?? style.watchlistSubTitleStyle,
          maxLines: 1,
        ),
      ],
    );
    return isExpanded ? Expanded(flex: flex, child: child) : child;
  }

  Widget _buildProductGrid(BuildContext context, WatchlistDetailsBloc bloc) {
    return BlocBuilder<WatchlistDetailsBloc, WatchlistDetailsState>(
      buildWhen: (previous, current) => current is WatchlistDetailsLoaded || current is WatchlistDetailsLoading,
      builder: (context, state) {
        if (bloc.productList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noProductsAddedInWatchlist.tr);
        }
        return SmartGridView(
          items: List.generate(
            bloc.productList.length,
            (index) {
              ProductDetailsModel productDetails = bloc.productList[index];
              return ProductGridItem(
                isFromWatchlist: true,
                isOutOfStock: productDetails.isOutOfStock,
                productDetails: productDetails,
                onCancelTap: () {
                  bloc.add(WatchlistDetailsEditProductEvent(index: index, context: context, actionType: WatchlistActionType.remove));
                },
                onFavTap: () {},
                onAddToBagTap: () {
                  bloc.add(WatchlistDetailsEditProductEvent(index: index, context: context));
                },
                buttonText: APPStrings.edit.tr,
              );
            },
          ),
        );
      },
    );
  }

  /// Show watchlist bottom sheet with edit and delete option
  void _showWatchlistBottomSheet(BuildContext screenContext, WatchlistDetailsBloc bloc) {
    OrderPopupStyle orderPopupStyle = AppTheme.of(screenContext).orderPopupStyle;
    Utils.showSmartModalBottomSheet(
        context: screenContext,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
        ),
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
              color: orderPopupStyle.whiteColor,
            ),
            height: 170.h,
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildPopupOption(context, text: APPStrings.editWatchlist.tr, style: orderPopupStyle.optionTextStyle, onTap: () async {
                      context.pop();
                      BlocProvider.of<EditWatchlistBloc>(context)
                          .add(EditWatchlistInitialEvent(isEdit: true, watchlistData: bloc.watchlistDetailsModel));

                      final result = await Utils.showSmartModalBottomSheet(
                        context: context,
                        enableDrag: false,
                        builder: (context) {
                          return const EditWatchlistScreen();
                        },
                      );
                      if (result?[RoutesData.isWatchlistUpdated] == true) {
                        bloc.isWatchlistUpdated = true;
                        bloc.add(WatchlistDetailsInitialEvent(screenContext, isInBackground: false));
                      }
                    }),
                    _buildPopupOption(context, text: APPStrings.removeWatchlist.tr, style: orderPopupStyle.cancelTextStyle, onTap: () {
                      context.pop();
                      WatchlistData watchlistData = WatchlistData.fromJson(bloc.watchlistDetailsModel.toJson());
                      _buildRemoveWatchlistPopup(screenContext, bloc, watchlistData: watchlistData);
                    }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  /// Remove Watchlist Popup
  void _buildRemoveWatchlistPopup(BuildContext screenContext, WatchlistDetailsBloc bloc, {required WatchlistData watchlistData}) {
    Utils.showSmartModalBottomSheet(
      context: screenContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      ),
      builder: (context) => ConfirmationDialog(
        title: APPStrings.removeWatchlistName.tr,
        message: APPStrings.addedXProductsWillBeRemoved.tr.interpolate([watchlistData.products?.length ?? 0]),
        onApproved: () {
          bloc.add(WatchlistDetailsDeleteEvent(context: context, screenContext: screenContext));
        },
        onDenied: () => context.pop(),
        onApprovedText: APPStrings.remove.tr,
        onDeniedText: APPStrings.cancel.tr,
      ),
    );
  }

  /// Build popup option
  Widget _buildPopupOption(
    BuildContext context, {
    required String text,
    required TextStyle style,
    EdgeInsets? padding,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: context.width,
        alignment: Alignment.centerLeft,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
        child: SmartText(text, style: style),
      ),
    );
  }
}
