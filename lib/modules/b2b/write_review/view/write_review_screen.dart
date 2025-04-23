import 'package:kgk/kgk.dart';

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WriteReviewScreenStyle style = AppTheme.of(context).writeReviewScreenStyle;
    final WriteReviewBloc bloc = BlocProvider.of<WriteReviewBloc>(context);
    return BlocBuilder<WriteReviewBloc, WriteReviewState>(
      buildWhen: (previous, current) => current is WriteReviewLoadedState,
      builder: (context, state) {
        return Scaffold(
          appBar: SmartAppBar(title: bloc.isEdit ? APPStrings.editReview.tr : APPStrings.writeAReview.tr),
          bottomNavigationBar: _buildBottomNavigationBar(context, bloc),
          body: SafeArea(
            child: SmartSingleChildScrollView(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  ...buildStarsView(style, bloc),
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
        );
      },
    );
  }

  List<Widget> buildStarsView(WriteReviewScreenStyle style, WriteReviewBloc bloc) {
    return [
      SmartText(APPStrings.rateUs.tr, style: style.labelStyle),
      SizedBox(height: 8.h),
      SmartRatingBar(
        initialRating: bloc.selectedRating.toDouble(),
        itemSize: 32.w,
        onRatingUpdate: (value) {
          bloc.selectedRating = value.toInt();
        },
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
        SmartText(APPStrings.images.tr, style: style.labelStyle),
        SizedBox(height: 8.h),
        BlocBuilder<WriteReviewBloc, WriteReviewState>(
          buildWhen:
              (previous, current) => current is PickImageState || current is RemoveSelectedImageState || current is WriteReviewInitial,
          builder: (context, state) {
            List<Widget> imageWidgets = [
              if (bloc.availablePickImageLength > 0)
                InkWell(
                  onTap: () {
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
                    child: SizedBox(height: 96.w, width: 96.w, child: const Center(child: SmartImage(path: AppImages.icPlus))),
                  ),
                ),
            ];

            if (bloc.imageFileList.isNotEmpty) {
              imageWidgets.addAll(
                List.generate(bloc.imageFileList.length, (index) {
                  return _buildImageItem(bloc.imageFileList[index], bloc, index, style);
                }),
              );
            }

            return Wrap(spacing: 17.w, runSpacing: 17.w, crossAxisAlignment: WrapCrossAlignment.start, children: imageWidgets);
          },
        ),
      ],
    );
  }

  Widget _buildImageItem(XFile imageFile, WriteReviewBloc bloc, int index, WriteReviewScreenStyle style) {
    return SizedBox(
      height: 96.w,
      width: 96.w,
      child: Stack(
        children: [
          SmartImage(path: imageFile.path, fit: BoxFit.cover, height: 96.w, width: 96.w, imageBorderRadius: BorderRadius.circular(4.r)),
          PositionedDirectional(
            top: 8.w,
            end: 8.w,
            child: GestureDetector(
              onTap: () {
                bloc.add(RemoveSelectedImageEvent(selectedImage: index));
              },
              child: Container(
                decoration: BoxDecoration(color: style.whiteColor, borderRadius: BorderRadius.circular(12.r)),
                height: 24.w,
                width: 24.w,
                alignment: AlignmentDirectional.center,
                child: const SmartImage(path: AppImages.icCancel),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showImagePickDialog(BuildContext context, WriteReviewBloc bloc) async {
    await Utils.showSmartModalBottomSheet(
      context: context,
      builder: (context) {
        return SmartImagePickDialogSheet(
          onTapSource: (ImageSource imageSource) {
            bloc.add(PickImageEvent(imageSource: imageSource));
          },
        );
      },
    ).then((value) {
      bloc.reviewFocusNode.unfocus();
      bloc.titleFocusNode.unfocus();
    });
  }

  Widget _buildBottomNavigationBar(BuildContext context, WriteReviewBloc bloc) {
    return SafeArea(
      child: SmartButton(
        margin: EdgeInsetsDirectional.all(17.w),
        onTap: () {
          bloc.add(WriteReviewSubmitEvent(context));
        },
        title: APPStrings.submit.tr,
      ),
    );
  }
}
