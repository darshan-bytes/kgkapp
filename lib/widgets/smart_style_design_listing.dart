import 'package:kgk/kgk.dart';

class SmartStyleDesignListing extends StatelessWidget {
  final StyleDesignModel listingItemModel;

  const SmartStyleDesignListing({super.key, required this.listingItemModel});

  @override
  Widget build(BuildContext context) {
    StyleDesignListStyle style = AppTheme.of(context).styleDesignListStyle;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsetsDirectional.only(bottom: 16.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0.r), border: Border.all(width: 1.w, color: style.borderColor)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmartImage(path: AppImages.icBadge, height: 24.w, width: 24.w, color: style.primaryColor, fit: BoxFit.fill),
              SizedBox(width: 8.w),
              SmartImage(path: AppImages.icLock, height: 24.w, width: 24.w, color: style.primaryColor, fit: BoxFit.fill),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SmartImage(path: listingItemModel.productImageUrl ?? '', height: 64.w, width: 64.w, fit: BoxFit.fill),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartText(listingItemModel.designId, style: style.titleStyle),
                  SizedBox(height: 16.h),
                  SmartText(listingItemModel.styleId, style: style.titleStyle),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmartText(listingItemModel.productName, style: style.titleStyle),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      SmartImage(
                        path: listingItemModel.userImageUrl ?? '',
                        imageBorderRadius: BorderRadius.circular(50.r),
                        height: 24.w,
                        width: 24.w,
                      ),
                      SizedBox(width: 8.w),
                      SmartText(listingItemModel.userName, style: style.titleStyle),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmartText(listingItemModel.numberOfProduct ?? '', style: style.titleStyle),
                  SizedBox(height: 16.h),
                  SmartText("", style: style.titleStyle),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmartText(listingItemModel.diamondType ?? '', style: style.titleStyle),
                  SizedBox(height: 16.h),
                  SmartText(listingItemModel.firstType ?? '', style: style.subTitleStyle),
                  SizedBox(height: 8.h),
                  SmartText(listingItemModel.firstGram ?? '', style: style.titleStyle),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmartText(listingItemModel.diamondShape, style: style.titleStyle),
                  SizedBox(height: 16.h),
                  SmartText(listingItemModel.secondType ?? '', style: style.subTitleStyle),
                  SizedBox(height: 8.h),
                  SmartText(listingItemModel.secondGram ?? '', style: style.titleStyle),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmartStatusBadge(currentStatus: listingItemModel.status ?? ProjectStatus.onHold),
                  SizedBox(height: 16.h),
                  SmartText(listingItemModel.thirdType ?? '', style: style.subTitleStyle),
                  SizedBox(height: 8.h),
                  SmartText(listingItemModel.thirdGram ?? '', style: style.titleStyle),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
