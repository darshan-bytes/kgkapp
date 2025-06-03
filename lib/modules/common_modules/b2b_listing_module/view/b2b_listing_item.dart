import 'package:kgk/kgk.dart';

/// [B2BItemField] -  Here we are defining the PDD item field model.
/// /// Represents a field in a PDD item with optional label, value, status, and image.
/// Used to encapsulate data for displaying and managing item details in a structured format.

class B2BItemField {
  final String? label;
  String? value;
  final ProjectStatus? orderStatus;
  final String? imageUrl;
  final double? imageSize;
  final bool isCircleImage;
  final bool isCircleWithValue;
  final bool isOnlyImageView;
  final double? gridSpacing;
  final bool isValueNotifier;
  final List<B2BItemField>? subFields;

  B2BItemField({
    this.label,
    this.value,
    this.orderStatus,
    this.imageUrl,
    this.imageSize,
    this.isCircleImage = true,
    this.isCircleWithValue = false,
    this.isOnlyImageView = false,
    this.gridSpacing,
    this.isValueNotifier = false,
    this.subFields,
  });
}

/// Represents an item in a PDD listing view with customizable display options.
/// Used to render structured item details in a grid or list format based on provided parameters.

class B2BListingItem extends StatelessWidget {
  final B2BCustomListingDataModel listingItemModel;
  final B2BListingType type;
  final Function()? onTap;
  final Function()? onTapMenuButton;
  final Function()? onTapCircleWithText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? gridSpacing;
  final double? gridRunSpacing;
  final int columns;
  final bool isListingView;
  final bool isLastFullWidthRequired;

  const B2BListingItem({
    super.key,
    required this.listingItemModel,
    required this.type,
    this.onTap,
    this.onTapMenuButton,
    this.padding,
    this.margin = EdgeInsetsDirectional.zero,
    this.gridSpacing,
    this.gridRunSpacing,
    this.columns = 2,
    this.isListingView = false,
    this.onTapCircleWithText,
    this.isLastFullWidthRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final PddListingItemStyle style = AppTheme.of(context).pddListingItemStyle;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: padding ?? EdgeInsetsDirectional.all(16.0.w),
            margin: margin,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0.r), border: Border.all(color: style.borderColor)),
            child: SmartGridView(
              items:
                  B2BListingFieldFactory.getListingFields(type: type, model: listingItemModel).map((field) {
                    /// if the type is watchlistType, then we are displaying the remaining time of the listing item. that will be decremented by 1 second every second. so changed it to value notifier builder.
                    if (type == B2BListingType.watchlistType && field.label != null && field.isValueNotifier) {
                      return ValueListenableBuilder(
                        valueListenable: listingItemModel.strRemainingTime!,
                        builder: (context, value, child) {
                          field.value = listingItemModel.strRemainingTime?.value;
                          return _buildDetailItem(field, context, style, gridSpacing ?? 16.0.w);
                        },
                      );
                    } else {
                      return _buildDetailItem(field, context, style, gridSpacing ?? 16.0.w);
                    }
                  }).toList(),
              columns: columns,
              spacing: 0.0.w,
              runSpacing: gridRunSpacing ?? 16.0.h,
              isLastFullWidthRequired:
                  type == B2BListingType.conceptListingType || type == B2BListingType.myInquiryType || isLastFullWidthRequired,
            ),
          ),
          if (onTapMenuButton != null)
            PositionedDirectional(
              top: 14.h,
              end: 14.w,
              child: SmartImage(
                path: AppImages.icMoreHorizontal,
                onTap: onTapMenuButton,
                padding: EdgeInsetsDirectional.all(4.w),
                inkwellBorderRadius: BorderRadius.circular(4.0.r),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(B2BItemField field, BuildContext context, PddListingItemStyle style, double gridSpacing) {
    return isListingView && columns == 1
        ? _buildRowDetailItem(field, context, style)
        : B2BColumnDetailItem(field: field, onTapCircleWithText: onTapCircleWithText, gridSpacing: gridSpacing);
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
              isAutoSizeText: true,
            ),
          ),
        SizedBox(width: 8.w),
        Expanded(
          child:
              field.orderStatus != null
                  ? SmartStatusBadge(height: 22.h, currentStatus: field.orderStatus!)
                  : SmartText(
                    field.value.isNotNullNorEmpty ? field.value! : APPStrings.dash.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: auctionListItemStyle.valueStyle,
                    isAutoSizeText: true,
                  ),
        ),
      ],
    );
  }
}

class B2BColumnDetailItem extends StatelessWidget {
  final B2BItemField field;
  final Function()? onTapCircleWithText;
  final double? gridSpacing;

  const B2BColumnDetailItem({super.key, required this.field, this.onTapCircleWithText, this.gridSpacing});

  @override
  Widget build(BuildContext context) {
    final PddListingItemStyle style = AppTheme.of(context).pddListingItemStyle;
    final auctionListItemStyle = AppTheme.of(context).auctionListItemStyle;
    return Container(
      margin: EdgeInsetsDirectional.only(end: gridSpacing ?? 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (field.label.isNotNullNorEmpty) ...[
            SmartText(
              field.label!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: auctionListItemStyle.titleStyle,
              isAutoSizeText: true,
            ),
            SizedBox(height: 4.h),
          ],
          if (field.isOnlyImageView && field.imageUrl != null)
            SmartImage(path: field.imageUrl!, height: 56.w, width: 56.w, fit: BoxFit.cover, imageBorderRadius: BorderRadius.circular(4.r))
          else if (field.orderStatus != null)
            SmartStatusBadge(currentStatus: ProjectStatus.values.firstWhere((element) => element == field.orderStatus))
          else
            _buildValue(field, auctionListItemStyle, style),
        ],
      ),
    );
  }

  Widget _buildValue(B2BItemField field, AuctionListItemStyle auctionListItemStyle, PddListingItemStyle style) {
    if (field.subFields.isNotNullNorEmpty) {
      return Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children: List.generate(field.subFields!.length, (index) {
          B2BItemField subField = field.subFields![index];
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (subField.imageUrl != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.w),
                  child: SmartImage(
                    path: subField.imageUrl!,
                    height: subField.imageSize ?? 24.w,
                    width: subField.imageSize ?? 24.w,
                    fit: BoxFit.contain,
                    imageBorderRadius: subField.isCircleImage ? BorderRadius.circular(((subField.imageSize ?? 24.w) / 2).r) : null,
                  ),
                ),
              Flexible(
                child:
                    subField.isCircleWithValue
                        ? _buildCircleWithValue(subField, auctionListItemStyle, style)
                        : _buildTextValue(subField, auctionListItemStyle),
              ),
            ],
          );
        }),
      );
      /*return SmartGridView(
        isLastFullWidthRequired: true,
        items: List.generate(field.subFields!.length, (index) {
          B2BItemField subField = field.subFields![index];
          return Row(
            children: [
              if (subField.imageUrl != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.w),
                  child: SmartImage(
                    path: subField.imageUrl!,
                    height: subField.imageSize ?? 24.w,
                    width: subField.imageSize ?? 24.w,
                    fit: BoxFit.contain,
                    imageBorderRadius: subField.isCircleImage ? BorderRadius.circular(((subField.imageSize ?? 24.w) / 2).r) : null,
                  ),
                ),
              Flexible(
                child:
                    subField.isCircleWithValue
                        ? _buildCircleWithValue(subField, auctionListItemStyle, style)
                        : _buildTextValue(subField, auctionListItemStyle),
              ),
            ],
          );
        }),
      );*/
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (field.imageUrl != null)
          Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: SmartImage(
              path: field.imageUrl!,
              height: field.imageSize ?? 24.w,
              width: field.imageSize ?? 24.w,
              fit: BoxFit.contain,
              imageBorderRadius: field.isCircleImage ? BorderRadius.circular(((field.imageSize ?? 24.w) / 2).r) : null,
            ),
          ),
        Flexible(
          child:
              field.isCircleWithValue
                  ? _buildCircleWithValue(field, auctionListItemStyle, style)
                  : _buildTextValue(field, auctionListItemStyle),
        ),
      ],
    );
  }

  Widget _buildCircleWithValue(B2BItemField field, AuctionListItemStyle auctionListItemStyle, PddListingItemStyle style) {
    return GestureDetector(
      onTap: onTapCircleWithText,
      child: Container(
        width: 24.w,
        height: 24.w,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(border: Border.all(color: style.borderColor, width: 1.5.w), shape: BoxShape.circle),
        child: SmartText(
          field.value.isNotNullNorEmpty ? field.value! : APPStrings.dash.tr,
          style: auctionListItemStyle.valueStyle.copyWith(fontSize: 12.0.sp),
          isAutoSizeText: true,
        ),
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
