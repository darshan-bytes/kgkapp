import 'package:kgk/kgk.dart';

class AllBidsBottomSheet extends StatelessWidget {
  const AllBidsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AuctionBloc bloc = BlocProvider.of<AuctionBloc>(context);
    final AuctionScreenStyle style = AppTheme.of(context).auctionScreenStyle;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 608.h),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: style.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24.h),
            _buildAppBar(style),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                itemBuilder: (context, index) {
                  return _buildResetBidsItem(
                      labelText: bloc.recentBidList[index]['date_time'],
                      value: bloc.recentBidList[index]['price'],
                      style: style,
                      isMyBid: index == 2);
                },
                separatorBuilder: (context, index) => Divider(height: 1.h),
                itemCount: bloc.recentBidList.length,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(AuctionScreenStyle style) {
    return SmartAppBar(
      isBack: false,
      appBarHeight: AppConst.defaultAppBarHeight,
      isBorder: false,
      backgroundColor: style.whiteColor,
      title: APPStrings.allBids.tr,
    );
  }

  Widget _buildResetBidsItem({required String labelText, required String value, required AuctionScreenStyle style, bool isMyBid = false}) {
    return SizedBox(
      height: 56.h,
      child: Row(
        children: [
          const SmartImage(path: AppImages.icCalendar),
          SizedBox(width: 8.w),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  SmartText(
                    labelText,
                    style: style.auctionTimerStyle,
                  ),
                  SizedBox(width: 5.w),
                  if (isMyBid)
                    Container(
                        decoration: BoxDecoration(color: style.myBidBackgroundColor, borderRadius: BorderRadius.circular(23.r)),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        child: SmartText(
                          APPStrings.myBid.tr,
                          style: style.myBidTextStyle,
                        ))
                ],
              )),
          SizedBox(width: 8.w),
          SmartText(
            value,
            style: style.recentBidValueStyle,
          ),
        ],
      ),
    );
  }
}
