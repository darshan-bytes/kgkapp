import 'package:kgk/kgk.dart';

class ShareOptionSheet extends StatelessWidget {
  final String title;
  final VoidCallback? onTapQrCode;
  final VoidCallback? onTapShare;
  final VoidCallback? onTapEmail;
  final VoidCallback? onTapCopy;
  final VoidCallback? onTapWhatsapp;
  final VoidCallback? onTapOther;
  final VoidCallback? onTapFacebook;

  const ShareOptionSheet({
    super.key,
    required this.title,
    this.onTapQrCode,
    this.onTapShare,
    this.onTapEmail,
    this.onTapCopy,
    this.onTapWhatsapp,
    this.onTapOther,
    this.onTapFacebook,
  });

  @override
  Widget build(BuildContext context) {
    final SharePresentationStyle style = AppTheme.of(context).sharePresentationStyle;
    return Container(
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(6.r), topRight: Radius.circular(6.r)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 24.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title.isNotEmpty)
                  SmartText(
                    title,
                    style: style.titleStyle,
                  ),
                SizedBox(height: 24.h),
                _buildShareButtonsRow(style),
                SizedBox(height: 32.h),
                _buildBottomNavbar(style, context),
                SizedBox(height: 24.h),
              ],
            ),
          ),
          Positioned(
            top: 16.h,
            right: 16.w,
            child: SmartImage(
              path: AppImages.icCross,
              height: 24.w,
              width: 24.w,
              color: style.closeIconColor,
              onTap: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButtonsRow(SharePresentationStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icQrCode, APPStrings.qrCode.tr, () {
          onTapQrCode?.call();
        }),
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icWhatsapp, APPStrings.whatsapp.tr, () {
          onTapWhatsapp?.call();
        }),
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icFaceBook, APPStrings.facebook.tr, () {
          onTapFacebook?.call();
        }),
        _buildShareButtons(style.iconButtonTextStyle, AppImages.icCopy, APPStrings.copyLink.tr, () {
          onTapCopy?.call();
        }),
      ],
    );
  }

  Widget _buildShareButtons(TextStyle iconButtonTextStyle, String imagePath, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SmartImage(path: imagePath, height: 56.w, width: 56.w),
          SizedBox(height: 8.h),
          SmartText(text, style: iconButtonTextStyle),
        ],
      ),
    );
  }

  Widget _buildBottomNavbar(SharePresentationStyle style, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SmartButton(
            title: APPStrings.cancel.tr,
            onTap: () {
              context.pop();
            },
            activeBackgroundColor: style.backgroundColor,
            titleStyle: style.userListTitleStyle,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SmartButton(
            title: APPStrings.share.tr,
            onTap: () {
              onTapShare?.call();
            },
          ),
        ),
      ],
    );
  }
}
