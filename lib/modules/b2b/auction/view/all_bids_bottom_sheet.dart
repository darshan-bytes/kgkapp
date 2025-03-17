import 'package:kgk/kgk.dart';

class AllBidsBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> recentBidList;

  const AllBidsBottomSheet({
    super.key,
    required this.recentBidList,
  });

  @override
  Widget build(BuildContext context) {
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
            _buildAppBar(style, context),
            SizedBox(height: 10.h),
            Flexible(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView.separated(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _buildResetBidsItem(
                      labelText: recentBidList[index][AppConst.dateTimeKey],
                      value: recentBidList[index][AppConst.priceKey],
                      isMyBid: recentBidList[index][AppConst.isMyBidKey],
                      style: style,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: recentBidList.length,
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(AuctionScreenStyle style, BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(
            APPStrings.allBids.tr,
            style: style.allBidsTitleStyle,
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
      ),
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
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
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
