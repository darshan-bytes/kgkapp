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
        body: BlocBuilder<CommentListingBloc, CommentListingState>(
          buildWhen: (previous, current) => current is CommentListingLoadedState || current is CommentLoadingState,
          builder: (context, state) {
            if (state is CommentLoadingState) {
              return SmartCircularProgressIndicator();
            } else if (state is CommentListingLoadedState) {
              if ((bloc.commentsAddedResponseModel?.comments).isNullOrEmpty) {
                return NoDataFoundWidget();
              }
              return SmartSingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsetsDirectional.all(16.w),
                  itemCount: (bloc.commentsAddedResponseModel?.comments ?? []).length,
                  itemBuilder: (context, index) {
                    Comments commentModel = (bloc.commentsAddedResponseModel?.comments?[index] ?? Comments());
                    return CommentListItem(
                      id: commentModel.updatedIdDetails?.companyName ?? '',
                      createdAt: commentModel.createdAt?.changeDateFormat(
                              inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ,
                              outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2) ??
                          '',
                      message: commentModel.message ?? '',
                      userImage: commentModel.updatedIdDetails?.profilePic ?? '',
                      onEditPressed: () {
                        _onTapAddComment(bloc, context, commentId: commentModel.sId, initialMessage: commentModel.message);
                      },
                      onRemovePressed: () {
                        bloc.add(CommentDeletedApiCallEvent(commentId: commentModel.sId ?? '', context: context));
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8.h),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context, CommentListingBloc bloc) {
    return Container(
      color: AppTheme.of(context).previewCatalogueStyle.whiteColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.all(17.0.w),
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

  Future<void> _onTapAddComment(CommentListingBloc bloc, BuildContext context, {String? commentId, String? initialMessage}) async {
    bloc.setEditingComment(commentId, initialMessage ?? '');
    await Utils.showSmartModalBottomSheet(
      context: context,
      builder: (context) {
        return _buildCommentBottomNavBar(bloc, context: context);
      },
    );
  }

  Widget _buildCommentBottomNavBar(CommentListingBloc bloc, {required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocBuilder<CommentListingBloc, CommentListingState>(
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
                      borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(24.r), topEnd: Radius.circular(24.r)),
                      boxShadow: [style.boxShadow],
                    ),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 24.h),
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
                        PositionedDirectional(
                          end: 14.w,
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
      ),
    );
  }
}

class CommentListItem extends StatelessWidget {
  final String id;
  final String createdAt;
  final String message;
  final String? userImage;
  final VoidCallback? onEditPressed;
  final VoidCallback? onRemovePressed;

  const CommentListItem({
    super.key,
    required this.id,
    required this.createdAt,
    required this.message,
    this.userImage,
    this.onEditPressed,
    this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context) {
    final CommentListingStyle style = AppTheme.of(context).commentListingStyle;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: style.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.grey.shade200,
            child: SmartImage(path: userImage ?? ""),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmartText(id, style: style.headerStyle),
                SmartText(createdAt, style: style.titleStyle),
                SizedBox(height: 8.h),
                SmartText(message, style: style.subtitleStyle, maxLines: 100, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          PopupMenuButton<CommentListingPopupMenuOption>(
            initialValue: null,
            color: style.whiteColor,
            icon: SmartImage(path: AppImages.icMoreVertical, height: 24.w, width: 24.w),
            position: PopupMenuPosition.under,
            onSelected: (CommentListingPopupMenuOption option) {
              switch (option) {
                case CommentListingPopupMenuOption.edit:
                  onEditPressed?.call();
                  break;
                case CommentListingPopupMenuOption.remove:
                  onRemovePressed?.call();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: CommentListingPopupMenuOption.edit,
                child: SmartText(APPStrings.edit.tr),
              ),
              PopupMenuItem(
                value: CommentListingPopupMenuOption.remove,
                child: SmartText(APPStrings.remove.tr),
              ),
            ],
          )
        ],
      ),
    );
  }
}
