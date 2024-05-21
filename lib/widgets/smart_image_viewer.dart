import 'package:kgk/kgk.dart';

class SmartImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? imageBorderRadius;

  const SmartImage({
    super.key,
    required this.path,
    this.height,
    this.fit = BoxFit.cover,
    this.width,
    this.imageBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (path.isNullOrEmpty) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: imageBorderRadius),
        child: Image.asset(
          AppImages.icPlaceholder,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        ),
      );
    }
    switch (path.imageType) {
      case ImageType.svg:
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: imageBorderRadius),
          child: SvgPicture.asset(
            path,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
          ),
        );
      case ImageType.asset:
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: imageBorderRadius),
          child: Image.asset(
            path,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
        );
      case ImageType.file:
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: imageBorderRadius),
          child: Image.file(
            File(path),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
        );
      case ImageType.network:
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: imageBorderRadius),
          child: path.isSvgUrl
              ? SvgPicture.network(path, width: width, height: height)
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
                  imageUrl: path),
        );
      default:
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: imageBorderRadius),
          child: Image.asset(
            AppImages.icPlaceholder,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          ),
        );
    }
  }
}
