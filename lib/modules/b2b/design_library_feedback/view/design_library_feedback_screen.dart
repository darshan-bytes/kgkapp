import 'package:kgk/kgk.dart';

class DesignLibraryFeedbackScreen extends StatelessWidget {
  const DesignLibraryFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DesignLibraryFeedbackStyle style = AppTheme.of(context).designLibraryFeedbackStyle;
    DesignLibraryFeedbackBloc bloc = BlocProvider.of<DesignLibraryFeedbackBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: bloc.appBarTitle),
      body: SmartSingleChildScrollView(padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w), child: _buildBody(context, style, bloc)),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BlocBuilder<DesignLibraryFeedbackBloc, DesignLibraryFeedbackState>(
          buildWhen: (previous, current) => current is DesignLibraryShowAddCommentState,
          builder: (context, state) {
            return bloc.showAddComment
                ? SafeArea(
                  bottom: bloc.showAddComment,
                  child: Container(
                    color: style.whiteColor,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 16.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            SmartTextField(
                              labelText: APPStrings.addAComment.tr,
                              controller: bloc.feedbackController,
                              focusNode: bloc.feedbackFocusNode,
                              maxLines: 3,
                              textInputAction: TextInputAction.newline,
                            ),
                            PositionedDirectional(
                              end: 14.w,
                              top: 86.w,
                              child: SmartImage(height: 24.w, width: 24.w, path: AppImages.icSendComment),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DesignLibraryFeedbackStyle style, DesignLibraryFeedbackBloc bloc) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => bloc.add(const DesignLibraryShowAddCommentEvent()),
          child: SmartImage(path: "https://i.ibb.co/j4gYHfk/Image.png", height: 356.w, width: 356.w),
        ),
        SizedBox(height: 24.h),
        Container(
          color: style.listBackgroundColor,
          child: BlocBuilder<DesignLibraryFeedbackBloc, DesignLibraryFeedbackState>(
            builder: (context, state) {
              return ListView.separated(
                itemCount: bloc.feedbackList.length,
                shrinkWrap: true,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => _buildListItem(context, style, bloc.feedbackList[index]),
                separatorBuilder: (context, index) => Divider(height: 32.h),
              );
            },
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildListItem(BuildContext context, DesignLibraryFeedbackStyle style, DesignLibraryFeedbackModel feedbackList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartImage(path: feedbackList.designerImageUrl ?? '', height: 32.w, width: 32.w),
        SizedBox(height: 11.h),
        Row(
          children: [
            SmartText(feedbackList.designerName, style: style.designNameStyle),
            SizedBox(width: 8.w),
            SmartText(feedbackList.daysAgo, style: style.daysAgoStyle),
          ],
        ),
        SizedBox(height: 5.h),
        SmartText(feedbackList.feedbackMessage, style: style.designMessageStyle),
      ],
    );
  }
}
