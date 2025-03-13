import 'package:kgk/kgk.dart';

class ManufacturerOrderListingScreen extends StatelessWidget {
  const ManufacturerOrderListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ManufacturerOrderListingBloc bloc = BlocProvider.of<ManufacturerOrderListingBloc>(context);

    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.orderManagement.tr.toUpperCamelCase,
        onFavorite: () => context.pushNamed(AppRoutes.wishListPage),
        onNotification: () => context.pushNamed(AppRoutes.notificationPage),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      floatingActionButton: BlocBuilder<ManufacturerOrderListingBloc, ManufacturerOrderListingState>(
        buildWhen: (previous, current) => current is ManufacturerOrderListingLoadedState,
        builder: (context, state) {
          return ScrollToTopFAB(
            canScrollToTop: bloc.paginationScrollController.canScrollToTop,
            onTap: bloc.paginationScrollController.scrollToTop,
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0.w),
          child: BlocBuilder<ManufacturerOrderListingBloc, ManufacturerOrderListingState>(
            buildWhen: (previous, current) => current is ManufacturerOrderListingLoadedState,
            builder: (context, state) {
              if (state is ManufacturerOrderListingLoadedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSearchTextField(bloc, context),
                    Expanded(child: _buildManufacturerOrderList(bloc)),
                  ],
                );
              } else {
                return const SmartCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField(ManufacturerOrderListingBloc bloc, BuildContext context) {
    final style = AppTheme.of(context).filterBottomActionBarStyle;
    final BorderRadius borderRadius = BorderRadius.only(topLeft: Radius.circular(4.r), bottomLeft: Radius.circular(4.r));
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: style.dividerColor),
      borderRadius: borderRadius,
    );
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SmartTextField.search(
                  height: 48.w,
                  prefixIconSize: 12.w,
                  padding: EdgeInsetsDirectional.symmetric(vertical: 24.w),
                  hintText: APPStrings.searchOrder.tr,
                  controller: bloc.manufacturerOrderSearchController,
                  borderRadius: borderRadius,
                  customFocusedBorder: outlineInputBorder,
                  customDisabledBorder: outlineInputBorder,
                  customErrorBorder: outlineInputBorder,
                  customFocusedErrorBorder: outlineInputBorder,
                ),
              ),
              _buildOrderDropDownField(bloc, style),
            ],
          ),
        ),
        SizedBox(width: 16.0.w),
        SelectionButton(
          width: 48.w,
          imageHeight: 24.5.w,
          imageWidth: 24.5.w,
          isSelected: false,
          image: AppImages.icMenu,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildManufacturerOrderList(ManufacturerOrderListingBloc bloc) {
    return BlocBuilder<ManufacturerOrderListingBloc, ManufacturerOrderListingState>(
      buildWhen: (previous, current) => current is ManufacturerOrderListLoadedMoreState || current is ManufacturerOrderListLoadingMoreState,
      builder: (context, state) {
        if (bloc.manufacturerOrderList.isEmpty) {
          return NoDataFoundWidget(text: APPStrings.noDataFound.tr);
        }
        return SmartRefreshIndicator(
          onRefresh: () async {
            await bloc.pullToRefresh();
          },
          child: ListView.builder(
              shrinkWrap: true,
              controller: bloc.paginationScrollController.scrollController,
              itemCount: bloc.manufacturerOrderList.length,
              itemBuilder: (context, index) {
                B2BCustomListingDataModel orderItem = bloc.manufacturerOrderList[index];
                return BlocBuilder<ManufacturerOrderListingBloc, ManufacturerOrderListingState>(
                  buildWhen: (previous, current) =>
                      current is ManufacturerOrderListLoadedMoreState || current is ManufacturerOrderListLoadingMoreState,
                  builder: (context, state) {
                    return Column(
                      children: [
                        B2BListingItem(
                          margin: EdgeInsetsDirectional.only(bottom: 16.0.h),
                          type: B2BListingType.manufacturerOrderListingType,
                          listingItemModel: orderItem,
                          onTapMenuButton: () {},
                          onTap: () {
                            context.pushNamed(AppRoutes.manufacturerOrderDetailsPage,
                                arguments: {RoutesData.isPageFor: ScreenIdentifier.cancelOrderForManufacturer});
                          },
                        ),
                        if (index == bloc.manufacturerOrderList.length - 1 && state is ManufacturerOrderListLoadingMoreState)
                          const SmartCircularProgressIndicator(),
                      ],
                    );
                  },
                );
              }),
        );
      },
    );
  }

  Widget _buildOrderDropDownField(ManufacturerOrderListingBloc bloc, FilterBottomActionBarStyle style) {
    return BlocBuilder<ManufacturerOrderListingBloc, ManufacturerOrderListingState>(
      buildWhen: (previous, current) => current is ManufacturerChangeOrdersTypeState,
      builder: (context, state) {
        return SizedBox(
          width: 120.w,
          child: SmartDropDown<ManufacturerOrderModel>(
            border: BorderDirectional(
                end: BorderSide(color: style.dividerColor),
                top: BorderSide(color: style.dividerColor),
                bottom: BorderSide(color: style.dividerColor)),
            borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(4.r), bottomEnd: Radius.circular(4.r)),
            items: bloc.orderTypeList.map((ManufacturerOrderModel type) {
              return SmartDropDownItem<ManufacturerOrderModel>(
                value: type,
                title: type.name,
              );
            }).toList(),
            onChanged: (type) {
              if (type != null) {
                bloc.add(ManufacturerChangeOrdersTypeEvent(type));
              }
            },
            selectedItem: bloc.selectedOrderType,
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(ManufacturerOrderListingBloc bloc, BuildContext context) {
    return BlocBuilder<ManufacturerOrderListingBloc, ManufacturerOrderListingState>(
      buildWhen: (previous, current) => current is ManufacturerOrderListingLoadedState,
      builder: (context, state) {
        if (state is ManufacturerOrderListingLoadedState) {
          return SafeArea(
              child: FilterBottomActionBar(
            controller: bloc.paginationScrollController.controller,
            onFilterTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (context) => FilterScreen(
                  onApply: () {},
                ),
              );
            },
          ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
