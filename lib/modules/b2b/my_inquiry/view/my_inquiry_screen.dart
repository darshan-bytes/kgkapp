import 'package:kgk/kgk.dart';

class MyInquiryScreen extends StatelessWidget {
  const MyInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MyInquiryBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.myInquiries.tr,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(bloc, context),
      body: BlocBuilder<MyInquiryBloc, MyInquiryState>(
        buildWhen: (previous, current) => current is MyInquiryLoadedState,
        builder: (context, state) {
          return ListView.builder(
              padding: EdgeInsetsDirectional.all(17.w),
              itemCount: bloc.myInquiryList.length,
              itemBuilder: (listContext, index) {
                return B2BListingItem(
                  margin: EdgeInsetsDirectional.only(bottom: 24.h),
                  onTapMenuButton: () {
                    handleMenuButtonTap(context, index, bloc, bloc.myInquiryList[index].strInquiryId ?? '');
                  },
                  type: B2BListingType.myInquiryType,
                  listingItemModel: bloc.myInquiryList[index],
                  onTap: () {},
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.makeInquiryPage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void handleMenuButtonTap(BuildContext mainContext, int index, MyInquiryBloc bloc, String strInquiryId) {
    Utils.showSmartModalBottomSheet(
      context: mainContext,
      builder: (BuildContext context) {
        return buildDiamondMenuPopUp(context, index, bloc, mainContext);
      },
    );
  }

  Widget buildDiamondMenuPopUp(BuildContext context, int index, MyInquiryBloc bloc, BuildContext mainContext) {
    final MyBagDiamondItemStyle style = AppTheme.of(context).myBagDiamondItemStyle;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildRowButton(
            style,
            () async {
              context.pop();
              await mainContext.pushNamed(
                AppRoutes.makeInquiryPage,
                arguments: {
                  RoutesData.inquiryData: bloc.myInquiryList[index],
                },
              ).then((onValue) {
                if (onValue != null) {
                  if (onValue[RoutesData.isInquiryUpdated]!) {
                    bloc.add(MyInquiryUpdateEvent(mainContext));
                  }
                }
                return;
              });
            },
            APPStrings.editInquiry.tr,
            AppImages.icEditPrimary,
          ),
          Divider(indent: 16.w, endIndent: 16.w),
          buildRowButton(
            style,
            () {
              context.pop();
              bloc.add(MyInquiryRemoveEvent(index, mainContext));
            },
            APPStrings.removeInquiry.tr,
            AppImages.icRemove,
          ),
        ],
      ),
    );
  }

  Widget buildRowButton(MyBagDiamondItemStyle style, GestureTapCallback? onTap, String title, String iconPath) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 16.w, horizontal: 16.w),
        child: Row(
          children: [
            SmartImage(path: iconPath, height: 24.w, width: 24.w),
            SizedBox(width: 8.w),
            SmartText(title, style: style.subTitleStyle),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(MyInquiryBloc myInquiryBloc, BuildContext context) {
    return BlocBuilder<MyInquiryBloc, MyInquiryState>(
      buildWhen: (previous, current) => current is MyInquiryLoadedState,
      builder: (context, state) {
        if (state is MyInquiryLoadedState) {
          return FilterBottomActionBar(
            controller: myInquiryBloc.smartPaginationScrollController.controller,
            onFilterTap: () {
              Utils.showSmartModalBottomSheet(
                context: context,
                builder: (_) => AdvanceFilterScreen(
                  onApply: (value) {
                    if (value != null && value is List<FilterData>) {
                      myInquiryBloc.add(FilterMyInquiryEvent(context, value));
                    }
                  },
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
