import 'package:kgk/kgk.dart';

class SavedAddressWidget extends StatelessWidget {
  final bool isShippingAddress;
  final AddressDetails addressDetails;

  final VoidCallback onChange;
  final VoidCallback onAddNew;

  final Function(bool?)? onShippingAddressChange;

  final bool isSameAsShippingAddress;

  const SavedAddressWidget({
    super.key,
    this.isShippingAddress = false,
    required this.addressDetails,
    required this.onChange,
    required this.onAddNew,
    this.onShippingAddressChange,
    this.isSameAsShippingAddress = false,
  });

  @override
  Widget build(BuildContext context) {
    final SavedAddressStyle style = AppTheme.of(context).savedAddressStyle;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: style.borderColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SmartText(
                        isShippingAddress ? APPStrings.shippingAddress.tr : APPStrings.billingAddress.tr,
                        style: style.titleStyle,
                      ),
                    ),
                    if (!isShippingAddress)
                      Flexible(
                        child: SmartCheckbox(
                          value: isSameAsShippingAddress,
                          onChanged: onShippingAddressChange ?? (value) {},
                          label: APPStrings.sameAsShipping.tr,
                        ),
                      )
                  ],
                ),
                SizedBox(height: 16.h),
                SmartText(addressDetails.fullName, style: style.addressNameStyle),
                SizedBox(height: 8.h),
                SmartText(addressDetails.fullAddress, style: style.addressLineStyle),
                SizedBox(height: 4.h),
                SmartText(addressDetails.contactNumber, style: style.addressLineStyle),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Divider(color: style.borderColor),
          Row(
            children: [
              Expanded(
                child: SmartButton(
                  onTap: onChange,
                  title: APPStrings.change.tr,
                  prefixImage: AppImages.icEditPrimary,
                  imageSize: 24.w,
                  activeBackgroundColor: style.whiteColor,
                  titleStyle: style.addressNameStyle,
                  activeImageColor: style.primaryColor,
                ),
              ),
              Container(height: 48.w, width: 1.w, color: style.borderColor),
              Expanded(
                child: SmartButton(
                  onTap: onAddNew,
                  title: APPStrings.addNew.tr,
                  prefixImage: AppImages.icPlus,
                  imageSize: 24.w,
                  activeBackgroundColor: style.whiteColor,
                  titleStyle: style.addressNameStyle,
                  activeImageColor: style.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
