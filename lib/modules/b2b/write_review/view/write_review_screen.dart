import 'package:kgk/kgk.dart';

const String diamondImage =
    "https://s3-alpha-sig.figma.com/img/9ebd/9517/705a51c9fc5153f1dfac36afd60d16c9?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CEg00oBHot6FBC0S~Jgw7iEpQ8mNWZVdQNorFxVAef310QMk5wmJYsAJm6gNWbd9YG-WSLNPc6Q9MAPEeXz2BgYTWjrTnkQWPWCgxqJswcHGQHgnZxMZmXM96HnkylNG17Pg~WURYovysiTsZS8p7H35ha09xWKBhxQvFf8Y6I5pyO2QTiPF-xHyabnzy~6lzTJXnXrEbKli7InPVL0hXMn1EDrTSMr4BAh1y0oZYzz-VQWRuFRn7mmyBpOhrkUrBMucWnlfpB9F3rz72aAqE898LfJTKfdSILEP41fI-fVdASU9sAMhm6b9XPwXvt-VjcU0PqEdDuUh8sAgW2fDGw__";

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WriteReviewScreenStyle style = AppTheme.of(context).writeReviewScreenStyle;
    WriteReviewBloc bloc = BlocProvider.of<WriteReviewBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SmartAppBar(
        title: APPStrings.writeAReview.tr,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(17.h),
        child: SmartButton(
          onTap: () {},
          title: APPStrings.submit.tr,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      _buildStarsView(style),
                      SizedBox(height: 24.h),
                      _buildTitleField(bloc),
                      SizedBox(height: 24.h),
                      _buildReviewField(bloc, style),
                      SizedBox(height: 24.h),
                      _buildPickImageSection()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarsView(WriteReviewScreenStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(APPStrings.stars.tr, style: style.labelStyle),
        SizedBox(height: 8.h),
        SmartRatingBar(
          initialRating: 0,
          itemSize: 32.w,
          onRatingUpdate: (value) {},
        ),
      ],
    );
  }

  Widget _buildTitleField(WriteReviewBloc bloc) {
    return SmartTextField(
      labelText: APPStrings.title.tr,
      hintText: APPStrings.title.tr,
      controller: bloc.titleController,
      focusNode: bloc.titleFocusNode,
      nextFocus: bloc.reviewFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildReviewField(WriteReviewBloc bloc, WriteReviewScreenStyle style) {
    return SmartTextField(
      labelText: APPStrings.review.tr,
      hintText: APPStrings.review.tr,
      controller: bloc.reviewController,
      focusNode: bloc.reviewFocusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.done,
      maxLines: 9,
      height: 192.h,
      expand: false,
    );
  }

  Widget _buildPickImageSection() {
    return InkWell(
      onTap: () {},
      child: DottedBorder(
          dashPattern: const [8, 4],
          radius: Radius.circular(4.r),
          borderType: BorderType.RRect,
          strokeWidth: 1.5,
          color: Color(0xFFD3DAE0),
          child: SizedBox(
            height: 96.h,
            width: 96.h,
            child: Center(child: SmartImage(path: AppImages.icPlus)),
          )),
    );
    // return ImagesHorizontalListWithCustomTitle(
    //   title: APPStrings.images.tr,
    //   images: [diamondImage, diamondImage, diamondImage, diamondImage, diamondImage, diamondImage],
    //   onShowAll: () {},
    // );
  }
}

class ImagesHorizontalListWithCustomTitle extends StatelessWidget {
  final List<String?>? images;
  final Function(int index)? onTap;
  final Function()? onShowAll;
  final Function()? viewAll;
  final String? title;
  final EdgeInsets? padding;
  final double? titleImageBetweenSpacing;
  final EdgeInsets? titlePadding;
  final double? imageSize;

  const ImagesHorizontalListWithCustomTitle({
    super.key,
    this.onTap,
    this.onShowAll,
    this.title,
    this.images,
    this.padding,
    this.imageSize,
    this.titlePadding,
    this.titleImageBetweenSpacing,
    this.viewAll,
  });

  @override
  Widget build(BuildContext context) {
    final int displayImageCount = min(images?.length ?? 0, 5);
    final double itemWidth = imageSize ?? (context.width - 64) / 5;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title.isNotNullNorEmpty) ...[
            Padding(
                padding: titlePadding ?? const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    Expanded(child: SmartText(title!)),
                    onShowAll != null
                        ? InkWell(
                            onTap: onShowAll,
                            child: SmartText(
                              'see_all'.tr,
                            ),
                          )
                        : const SizedBox(),
                  ],
                )),
          ],
          if (images.isNotNullNorEmpty)
            SizedBox(
              height: 65,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: displayImageCount,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (onTap != null) {
                            onTap!(index);
                          }
                        },
                        child: SmartImage(
                          path: images![index] ?? '',
                          imageBorderRadius: BorderRadius.circular(8),
                          height: imageSize ?? 65,
                          width: itemWidth,
                        ),
                      ),
                      if (index == displayImageCount - 1 && (images?.length ?? 1) > 5)
                        Positioned(
                          bottom: 0,
                          child: GestureDetector(
                            onTap: viewAll,
                            child: Container(
                              width: itemWidth,
                              height: 65,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: SmartText(
                                'view_all'.tr,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
