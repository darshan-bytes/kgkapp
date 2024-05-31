import 'package:kgk/kgk.dart';

class AddressSelectionWidget extends StatelessWidget {
  final AddressDetails address;
  final AddressDetails? groupValue;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;

  const AddressSelectionWidget({
    super.key,
    required this.address,
    this.groupValue,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final AddressSelectionStyle style = AppTheme.of(context).addressSelectionStyle;
    Widget child = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onTap != null) ...[
          SmartRadioButton<AddressDetails>(
            padding: EdgeInsets.zero,
            groupValue: groupValue,
            value: address,
            onChanged: (value) {
              onTap?.call();
            },
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SmartText(address.fullName, style: style.addressNameStyle),
              const SizedBox(height: 4),
              SmartText(address.fullAddress, style: style.fullAddressStyle),
              const SizedBox(height: 12),
              SmartText(address.contactNumber, style: style.contactNumberStyle),
            ],
          ),
        ),
        if (onEdit != null) ...[
          const SizedBox(width: 8),
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onEdit,
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(4),
              child: const SmartImage(path: AppImages.icEditPrimary),
            ),
          ),
        ],
        if (onDelete != null) ...[
          const SizedBox(width: 8),
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onDelete,
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(4),
              child: const SmartImage(path: AppImages.icCross),
            ),
          ),
        ],
      ],
    );
    return onTap != null
        ? InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: child,
          )
        : child;
  }
}
