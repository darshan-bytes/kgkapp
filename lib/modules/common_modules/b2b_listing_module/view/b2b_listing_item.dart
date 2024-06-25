import 'package:kgk/kgk.dart';

/// [B2BItemField] -  Here we are defining the PDD item field model.
/// /// Represents a field in a PDD item with optional label, value, status, and image.
/// Used to encapsulate data for displaying and managing item details in a structured format.

class B2BItemField {
  final String? label;
  final String? value;
  final OrderStatus? orderStatus;
  final String? imageUrl;
  final double? imageSize;
  final bool isCircleImage;
  final bool isCircleWithValue;
  final bool isOnlyImageView;

  B2BItemField({
    this.label,
    this.value,
    this.orderStatus,
    this.imageUrl,
    this.imageSize,
    this.isCircleImage = true,
    this.isCircleWithValue = false,
    this.isOnlyImageView = false,
  });
}

/// Represents an item in a PDD listing view with customizable display options.
/// Used to render structured item details in a grid or list format based on provided parameters.

class B2BListingItem extends StatelessWidget {
  final B2BCustomListingDataModel listingItemModel;
  final B2BListingType type;
  final Function()? onTap;
  final Function()? onTapMenuButton;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? gridSpacing;
  final double? gridRunSpacing;
  final int columns;
  final bool isListingView;

  const B2BListingItem({
    super.key,
    required this.listingItemModel,
    required this.type,
    this.onTap,
    this.onTapMenuButton,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.gridSpacing,
    this.gridRunSpacing,
    this.columns = 2,
    this.isListingView = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).pddListingItemStyle;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: padding ?? EdgeInsets.all(16.0.w),
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0.r),
              border: Border.all(color: style.borderColor),
            ),
            child: SmartGridView(
              items: B2BListingFieldFactory.getListingFields(type: type, model: listingItemModel)
                  .map((field) => _buildDetailItem(field, context, style))
                  .toList(),
              columns: columns,
              spacing: 0.0.w,
              runSpacing: gridRunSpacing ?? 16.0.h,
            ),
          ),
          if (onTapMenuButton != null)
            Positioned(
              top: 14.h,
              right: 14.w,
              child: SmartImage(
                path: AppImages.icMoreHorizontal,
                onTap: onTapMenuButton,
                padding: EdgeInsets.all(4.w),
                inkwellBorderRadius: BorderRadius.circular(4.0.r),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(B2BItemField field, BuildContext context, PddListingItemStyle style) {
    return isListingView && columns == 1 ? _buildRowDetailItem(field, context, style) : _buildColumnDetailItem(field, context, style);
  }

  Widget _buildRowDetailItem(B2BItemField field, BuildContext context, PddListingItemStyle style) {
    final auctionListItemStyle = AppTheme.of(context).auctionListItemStyle;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (field.label.isNotNullNorEmpty)
          Expanded(
            child: SmartText(
              field.label!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: auctionListItemStyle.titleStyle,
            ),
          ),
        SizedBox(width: 8.w),
        Expanded(
          child: field.orderStatus != null
              ? StatusBadge(
                  height: 22.h,
                  currentStatus: field.orderStatus!,
                )
              : _buildValue(field, auctionListItemStyle, style),
        ),
      ],
    );
  }

  Widget _buildColumnDetailItem(B2BItemField field, BuildContext context, PddListingItemStyle style) {
    final auctionListItemStyle = AppTheme.of(context).auctionListItemStyle;

    return Container(
      margin: EdgeInsets.only(right: gridSpacing ?? 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (field.label.isNotNullNorEmpty) ...[
            SmartText(
              field.label!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: auctionListItemStyle.titleStyle,
            ),
            SizedBox(height: 4.h),
          ],
          if (field.isOnlyImageView && field.imageUrl != null)
            SmartImage(
              path: field.imageUrl!,
              height: 56.w,
              width: 56.w,
              fit: BoxFit.cover,
              imageBorderRadius: BorderRadius.circular(4.r),
            )
          else if (field.orderStatus != null)
            StatusBadge(
              currentStatus: OrderStatus.values.firstWhere((element) => element == field.orderStatus),
            )
          else
            _buildValue(field, auctionListItemStyle, style),
        ],
      ),
    );
  }

  Widget _buildValue(B2BItemField field, AuctionListItemStyle auctionListItemStyle, PddListingItemStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (field.imageUrl != null)
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: SmartImage(
              path: field.imageUrl!,
              height: field.imageSize ?? 24.w,
              width: field.imageSize ?? 24.w,
              fit: BoxFit.contain,
              imageBorderRadius: field.isCircleImage ? BorderRadius.circular(((field.imageSize ?? 24.w) / 2).r) : null,
            ),
          ),
        Flexible(
          child: field.isCircleWithValue
              ? _buildCircleWithValue(field, auctionListItemStyle, style)
              : _buildTextValue(field, auctionListItemStyle),
        ),
      ],
    );
  }

  Widget _buildCircleWithValue(B2BItemField field, AuctionListItemStyle auctionListItemStyle, PddListingItemStyle style) {
    return Container(
      width: 24.w,
      height: 24.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: style.borderColor, width: 1.5.w),
        shape: BoxShape.circle,
      ),
      child: SmartText(
        field.value.isNotNullNorEmpty ? field.value! : APPStrings.dash.tr,
        style: auctionListItemStyle.valueStyle.copyWith(fontSize: 12.0.sp),
      ),
    );
  }

  Widget _buildTextValue(B2BItemField field, AuctionListItemStyle auctionListItemStyle) {
    return SmartText(
      field.value.isNotNullNorEmpty ? field.value! : APPStrings.dash.tr,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: auctionListItemStyle.valueStyle,
    );
  }
}
