import 'package:kgk/kgk.dart';
import 'dart:developer' as kgk_logger;

class SmartImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? imageBorderRadius;
  final Color? color;
  final Color? bgColor;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? inkwellBorderRadius;
  final BoxBorder? border;
  final bool isMemCacheEnabled;
  final bool matchTextDirection;

  const SmartImage({
    super.key,
    required this.path,
    this.height,
    this.fit = BoxFit.cover,
    this.width,
    this.imageBorderRadius,
    this.color,
    this.bgColor,
    this.onTap,
    this.padding,
    this.margin,
    this.inkwellBorderRadius,
    this.border,
    this.isMemCacheEnabled = true,
    this.matchTextDirection = false,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isError = ValueNotifier<bool>(false);
    // get placeholder image from box
    String? placeholderImage = StorageManager().getPlaceHolderImage();
    Widget? child;
    if (path.isNullOrEmpty || !path.contains('/')) {
      child = Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: imageBorderRadius, border: border),
        child: Image.asset(
          AppImages.icPlaceholder,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          matchTextDirection: matchTextDirection,
          color: color,
        ),
      );
    }
    if (child == null) {
      switch (path.imageType) {
        case ImageType.svg:
          child = Container(
            height: height,
            width: width,
            padding: padding,
            margin: margin,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: imageBorderRadius, border: border, color: bgColor),
            child: SvgPicture.asset(
              path,
              width: width,
              height: height,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
              matchTextDirection: matchTextDirection,
            ),
          );
          break;
        case ImageType.asset:
          child = Container(
            height: height,
            width: width,
            padding: padding,
            margin: margin,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: imageBorderRadius, border: border, color: bgColor),
            child: Image.asset(path, height: height, width: width, fit: fit ?? BoxFit.cover, matchTextDirection: matchTextDirection),
          );
          break;
        case ImageType.file:
          child = Container(
            height: height,
            width: width,
            padding: padding,
            margin: margin,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: imageBorderRadius, border: border, color: bgColor),
            child: Image.file(File(path), height: height, width: width, fit: fit ?? BoxFit.cover, matchTextDirection: matchTextDirection),
          );
          break;
        case ImageType.network:
          child = Container(
            height: height,
            width: width,
            padding: padding,
            margin: margin,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: imageBorderRadius, border: border, color: bgColor),
            child:
                path.isSvgUrl
                    ? SvgPicture.network(path, width: width, height: height)
                    : ValueListenableBuilder(
                      valueListenable: isError,
                      builder: (context, value, child) {
                        if (value) {
                          return placeholderImage.isNotNullNorEmpty
                              ? Image.file(
                                File(placeholderImage),
                                height: height,
                                width: width,
                                fit: fit ?? BoxFit.contain,
                                matchTextDirection: matchTextDirection,
                              )
                              : Image.asset(
                                AppImages.icPlaceholder,
                                height: height,
                                width: width,
                                fit: fit ?? BoxFit.contain,
                                matchTextDirection: matchTextDirection,
                              );
                        } else {
                          return CachedNetworkImage(
                            matchTextDirection: matchTextDirection,
                            memCacheWidth:
                                isMemCacheEnabled
                                    ? height?.isFinite == true
                                        ? height!.toInt()
                                        : null
                                    : null,
                            memCacheHeight:
                                isMemCacheEnabled
                                    ? width?.isFinite == true
                                        ? width!.toInt()
                                        : null
                                    : null,
                            height: height,
                            width: width,
                            fit: fit,
                            errorListener: (error) {
                              isError.value = true;
                              if (kDebugMode) {
                                kgk_logger.log("❌ Error in CachedNetworkImage: $path", error: error, name: "SmartImage");
                              }
                            },
                            errorWidget:
                                (context, url, error) =>
                                    placeholderImage.isNotNullNorEmpty
                                        ? Image.file(
                                          File(placeholderImage),
                                          height: height,
                                          width: width,
                                          fit: fit ?? BoxFit.contain,
                                          matchTextDirection: matchTextDirection,
                                        )
                                        : Image.asset(
                                          AppImages.icPlaceholder,
                                          height: height,
                                          width: width,
                                          fit: fit ?? BoxFit.contain,
                                          matchTextDirection: matchTextDirection,
                                        ),
                            placeholder:
                                (context, url) => Center(
                                  child: SizedBox(
                                    height: height ?? 50.w,
                                    width: height ?? 50.w,
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: AlignmentDirectional.center,
                                      child: SizedBox(
                                        height: 20.w,
                                        width: 20.w,
                                        child: CircularProgressIndicator(strokeWidth: 3.w, color: AppTheme.of(context).colors.primary),
                                      ),
                                    ),
                                  ),
                                ),
                            imageUrl: path,
                          );
                        }
                      },
                    ),
          );
          break;
      }
    }

    return onTap != null ? InkWell(onTap: onTap, borderRadius: inkwellBorderRadius, child: child) : child;
  }
}
