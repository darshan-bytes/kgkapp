import 'package:kgk/kgk.dart';

class AddressSelectionWidget extends StatelessWidget {
  final AddressDetails address;
  final AddressDetails? groupValue;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;
  final bool isDefault;

  const AddressSelectionWidget({
    super.key,
    required this.address,
    this.groupValue,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.isDefault = false,
  });

  @override
  Widget build(BuildContext context) {
    final AddressSelectionStyle style = AppTheme.of(context).addressSelectionStyle;
    Widget child = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onTap != null) ...[
          SmartRadioButton<AddressDetails>(
            padding: EdgeInsetsDirectional.zero,
            groupValue: groupValue,
            value: address,
            onChanged: (value) {
              onTap?.call();
            },
          ),
          SizedBox(width: 8.w),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmartText(address.fullName, style: style.addressNameStyle),
              SizedBox(height: 4.h),
              SmartText(address.fullAddress, style: style.fullAddressStyle),
              SizedBox(height: 12.h),
              SmartText(address.contactNumber, style: style.contactNumberStyle),
              if (isDefault) ...[
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(color: style.defaultTagColor, borderRadius: BorderRadius.circular(12.r)),
                  child: SmartText(APPStrings.txtDefault.tr, style: style.defaultTagStyle),
                ),
              ],
            ],
          ),
        ),
        if (onEdit != null) ...[
          SizedBox(width: 8.w),
          SmartImage(
            path: AppImages.icEditPrimary,
            height: 30.w,
            width: 30.w,
            padding: EdgeInsetsDirectional.all(4.w),
            inkwellBorderRadius: BorderRadius.circular(24.r),
            onTap: onEdit,
          ),
        ],
        if (onDelete != null) ...[
          SizedBox(width: 8.w),
          SmartImage(
            path: AppImages.icCross,
            height: 30.w,
            width: 30.w,
            padding: EdgeInsetsDirectional.all(4.w),
            inkwellBorderRadius: BorderRadius.circular(24.r),
            onTap: onDelete,
          ),
        ],
      ],
    );
    return onTap != null ? InkWell(borderRadius: BorderRadius.circular(8.r), onTap: onTap, child: child) : child;
  }
}
