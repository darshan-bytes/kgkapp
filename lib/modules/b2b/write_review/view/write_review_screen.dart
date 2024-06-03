 import 'package:kgk/kgk.dart';

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WriteReviewScreenStyle style = AppTheme.of(context).writeReviewScreenStyle;
    final WriteReviewBloc bloc = BlocProvider.of<WriteReviewBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SmartAppBar(
        title: APPStrings.writeAReview.tr,
      ),
      bottomNavigationBar: SmartButton(
        margin: EdgeInsets.all(17.w),
        onTap: () {
          // Add your submit logic here
        },
        title: APPStrings.submit.tr,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                ...buildStarsView(style),
                SizedBox(height: 24.h),
                _buildTitleField(bloc),
                SizedBox(height: 24.h),
                _buildReviewField(bloc, style, context),
                SizedBox(height: 24.h),
                _buildPickImageSection(bloc, style),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildStarsView(WriteReviewScreenStyle style) {
    return [
      SmartText(APPStrings.stars.tr, style: style.labelStyle),
      SizedBox(height: 8.h),
      SmartRatingBar(
        initialRating: 0,
        itemSize: 32.w,
        onRatingUpdate: (value) {},
      ),
    ];
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

  Widget _buildReviewField(WriteReviewBloc bloc, WriteReviewScreenStyle style, context) {
    return SmartTextField(
      labelText: APPStrings.review.tr,
      hintText: APPStrings.review.tr,
      controller: bloc.reviewController,
      focusNode: bloc.reviewFocusNode,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.done,
      maxLines: 9,
      height: 192.h,
      expand: false,
    );
  }

  Widget _buildPickImageSection(WriteReviewBloc bloc, WriteReviewScreenStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(
          APPStrings.images.tr,
          style: style.labelStyle,
        ),
        SizedBox(height: 8.h),
        BlocBuilder<WriteReviewBloc, WriteReviewState>(
          buildWhen: (previous, current) => current is PickImageState || current is RemoveSelectedImageState,
          builder: (context, state) {
            List<Widget> imageWidgets = [
              if (bloc.availablePickImageLength > 0)
                InkWell(
                  onTap: () {
                    bloc.reviewFocusNode.unfocus();
                    bloc.titleFocusNode.unfocus();
                    FocusScope.of(context).unfocus();
                    bloc.reviewFocusNode.unfocus();
                    _showImagePickDialog(context, bloc);
                  },
                  child: DottedBorder(
                    padding: EdgeInsets.zero,
                    borderPadding: EdgeInsets.zero,
                    dashPattern: const [8, 4],
                    radius: Radius.circular(4.r),
                    borderType: BorderType.RRect,
                    strokeWidth: 1.5.w,
                    color: style.borderColor,
                    child: SizedBox(
                      height: 96.w,
                      width: 96.w,
                      child: const Center(child: SmartImage(path: AppImages.icPlus)),
                    ),
                  ),
                ),
            ];

            if (bloc.selectedImages.isNotEmpty) {
              imageWidgets.addAll(
                List.generate(
                  bloc.selectedImages.length,
                  (index) {
                    return _buildImageThumbnail(bloc.selectedImages[index], bloc, style, index);
                  },
                ),
              );
            }

            return Wrap(
              spacing: 17.w,
              runSpacing: 17.w,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: imageWidgets,
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageThumbnail(XFile imageFile, WriteReviewBloc bloc, WriteReviewScreenStyle style, int index) {
    return SizedBox(
      height: 96.w,
      width: 96.w,
      child: Stack(
        children: [
          SmartImage(
            path: imageFile.path,
            fit: BoxFit.cover,
            height: 96.w,
            width: 96.w,
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                bloc.add(RemoveSelectedImageEvent(selectedImage: index));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 24.w,
                width: 24.w,
                alignment: Alignment.center,
                child: const SmartImage(
                  path: AppImages.icCancel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showImagePickDialog(BuildContext context, WriteReviewBloc bloc) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return ImagePickDialogSheet(
          onTapSource: (ImageSource imageSource) {
            bloc.add(PickImageEvent(imageSource: imageSource));
          },
        );
      },
    ).then(
      (value) {
        bloc.reviewFocusNode.unfocus();
        bloc.titleFocusNode.unfocus();
      },
    );
  }
}