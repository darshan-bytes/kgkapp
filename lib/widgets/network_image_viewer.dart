import 'package:kgk/kgk.dart';

class SmartNetworkImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final double borderRadius;
  final BoxFit? fit;
  final BorderRadiusGeometry? imageBorderRadius;

  const SmartNetworkImage({
    super.key,
    required this.url,
    this.height,
    this.fit = BoxFit.cover,
    this.width,
    this.borderRadius = 0,
    this.imageBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isNullOrEmpty) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: imageBorderRadius ?? BorderRadius.circular(borderRadius)),
        child: Image.asset(
          AppImages.icPlaceholder,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        ),
      );
    }
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: imageBorderRadius ?? BorderRadius.circular(borderRadius)),
      child: url.isSvgUrl
          ? SvgPicture.network(url, width: width, height: height)
          : CachedNetworkImage(
              height: height,
              width: width,
              fit: fit,
              errorWidget: (context, url, error) => Image.asset(
                    AppImages.icPlaceholder,
                    height: height,
                    width: width,
                    fit: fit ?? BoxFit.cover,
                  ),
              placeholder: (context, url) => SizedBox(
                    height: height ?? 50,
                    width: height ?? 50,
                    child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 3, color: AppTheme.of(context).colors.primary),
                        )),
                  ),
              imageUrl: url),
    );
  }
}
