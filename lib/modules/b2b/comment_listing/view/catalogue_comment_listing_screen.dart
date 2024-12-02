import 'package:kgk/kgk.dart';

class CatalogueCommentListingScreen extends StatelessWidget {
  const CatalogueCommentListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CommentListingBloc bloc = BlocProvider.of<CommentListingBloc>(context);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        bloc.reset();
      },
      child: Scaffold(
        appBar: SmartAppBar(
          title: APPStrings.comment.tr,
          onBack: () {
            bloc.reset();
            context.pop();
          },
        ),
        bottomNavigationBar: _bottomNavigationBar(context, bloc),
        body: SafeArea(
          child: BlocBuilder<CommentListingBloc, CommentListingState>(
            buildWhen: (previous, current) => current is CommentListingLoadedState,
            builder: (context, state) {
              if (state is CommentListingLoadedState) {
                if ((bloc.commentsAddedResponseModel?.comments).isNullOrEmpty && AppBloc().isLoading) {
                  return NoDataFoundWidget();
                }
                return ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16.w),
                  itemCount: (bloc.commentsAddedResponseModel?.comments ?? []).length,
                  itemBuilder: (context, index) {
                    Comments commentModel = (bloc.commentsAddedResponseModel?.comments?[index] ?? Comments());
                    return ListTile(
                      tileColor: AppTheme.of(context).previewCatalogueStyle.stepBorderColor,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      title: SmartText(commentModel.message),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8.h),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context, CommentListingBloc bloc) {
    return Container(
      color: AppTheme.of(context).previewCatalogueStyle.whiteColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(17.0.w),
          child: SmartButton(
            title: APPStrings.addAComment.tr,
            onTap: () {
              _onTapAddComment(bloc, context);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onTapAddComment(CommentListingBloc bloc, BuildContext context) async {
    bloc.commentFocusNode.requestFocus();
    await Utils.showSmartModalBottomSheet(
      context: context,
      builder: (context) {
        return _buildCommentBottomNavBar(bloc);
      },
    );
  }

  Widget _buildCommentBottomNavBar(CommentListingBloc bloc) {
    return BlocBuilder<CommentListingBloc, CommentListingState>(
      buildWhen: (previous, current) => current is CatalogueCommentState || current is CommentListingLoadedState,
      builder: (context, state) {
        PreviewCatalogueStyle style = AppTheme.of(context).previewCatalogueStyle;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: style.whiteColor,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: style.whiteColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
                    boxShadow: [style.boxShadow],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                  child: Stack(
                    children: [
                      SmartTextField(
                        autofocus: false,
                        labelText: APPStrings.addAComment.tr,
                        controller: bloc.commentController,
                        focusNode: bloc.commentFocusNode,
                        maxLines: 3,
                        textInputAction: TextInputAction.newline,
                        onTapOutside: (value) => FocusManager.instance.primaryFocus?.unfocus(),
                      ),
                      Positioned(
                        right: 14.w,
                        top: 86.w,
                        child: SmartImage(
                          onTap: () {
                            if (bloc.commentController.text.isNotEmpty) {
                              bloc.add(CommentAddedApiCallEvent(context: context));
                            }
                          },
                          height: 24.w,
                          width: 24.w,
                          path: AppImages.icSendComment,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
