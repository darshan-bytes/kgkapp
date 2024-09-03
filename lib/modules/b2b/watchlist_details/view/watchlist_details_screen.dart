import 'package:kgk/kgk.dart';

class WatchlistDetailsScreen extends StatelessWidget {
  const WatchlistDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WatchlistDetailsBloc bloc = BlocProvider.of<WatchlistDetailsBloc>(context);
    return Scaffold(
      //Here I've used resizeToAvoidBottomInset as false to avoid the keyboard overlapping the content.
      // Also, there is no need to allow the user to scroll the content when the keyboard is open.
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(bloc),
      body: _buildBody(bloc, context),
    );
  }

  PreferredSizeWidget _buildAppBar(WatchlistDetailsBloc bloc) {
    return PreferredSize(
      preferredSize: AppConst.appBarHeight,
      child: BlocBuilder<WatchlistDetailsBloc, WatchlistDetailsState>(
        buildWhen: (previous, current) => current is WatchlistDetailsLoaded,
        builder: (context, state) {
          return SmartAppBar(title: bloc.watchlistName);
        },
      ),
    );
  }

  Widget _buildBody(WatchlistDetailsBloc bloc, BuildContext context) {
    return BlocBuilder<WatchlistDetailsBloc, WatchlistDetailsState>(
      buildWhen: (previous, current) => current is WatchlistDetailsLoaded || current is WatchlistDetailsLoading,
      builder: (context, state) {
        if (state is WatchlistDetailsLoaded) {
          final WatchlistDetailsStyle style = AppTheme.of(context).watchlistDetailsStyle;
          return SmartSingleChildScrollView(
            controller: bloc.paginationScrollController.controller,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                _buildDetailsView(style, bloc),
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
                      ),
                      SizedBox(height: 24.h),
                      _buildProductGrid(bloc)
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SmartCircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildDetailsView(WatchlistDetailsStyle style, WatchlistDetailsBloc bloc) {
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
                currentStatus: bloc.watchlistDetailsModel.status,
              ),
              SizedBox(width: 16.w),
              SmartImage(
                path: AppImages.icMoreVertical,
                width: 24.w,
                height: 24.h,
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              SizedBox(
                width: 152.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailColumn(
                      APPStrings.noOfProducts.tr,
                      '5',
                      style,
                      titleStyle: style.noOfProductsStyle,
                    ),
                    SizedBox(height: 19.h),
                    _buildDetailColumn(
                      APPStrings.from.tr,
                      bloc.watchlistDetailsModel.watchlistFromDate,
                      style,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailColumn(
                      APPStrings.remainingTime.tr,
                      bloc.watchlistDetailsModel.remainingTime,
                      style,
                      valueStyle: style.watchlistNameStyle,
                    ),
                    SizedBox(height: 16.h),
                    _buildDetailColumn(
                      APPStrings.to.tr,
                      bloc.watchlistDetailsModel.watchlistToDate,
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

  Widget _buildProductGrid(WatchlistDetailsBloc bloc) {
    return BlocBuilder<WatchlistDetailsBloc, WatchlistDetailsState>(
      buildWhen: (previous, current) => current is WatchlistProductLoadedMore || current is WatchlistProductLoadingMore,
      builder: (context, state) {
        return SmartGridView(
          items: List.generate(
            bloc.productList.length,
            (index) {
              ProductDetails productDetails = bloc.productList[index];
              return ProductGridItem(
                isOutOfStock: productDetails.isOutOfStock,
                productDetails: productDetails,
                onCancelTap: () {
                  BlocProvider.of<AddToWatchlistBloc>(context).add(AddToWatchlistInitialEvent.remove(productDetails, context));
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    useRootNavigator: true,
                    builder: (context) => const AddWatchlistScreen(),
                  );
                },
                onFavTap: () {},
                isFavourite: true,
                onEyeTap: () {},
                onAddToBagTap: () {
                  BlocProvider.of<AddToWatchlistBloc>(context).add(AddToWatchlistInitialEvent.edit(productDetails, context));
                  Utils.showSmartModalBottomSheet(
                    context: context,
                    enableDrag: false,
                    useRootNavigator: true,
                    builder: (context) => const AddWatchlistScreen(),
                  );
                },
                buttonText: APPStrings.edit.tr,
              );
            },
          ),
          isLoadingMore: state is WatchlistProductLoadingMore,
        );
      },
    );
  }
}
