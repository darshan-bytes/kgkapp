import 'package:kgk/kgk.dart';

class MessageDetailScreen extends StatelessWidget {
  const MessageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MessagesStyle style = AppTheme.of(context).messagesStyle;
    final MessageDetailBloc bloc = BlocProvider.of<MessageDetailBloc>(context);
    return Scaffold(
      appBar: SmartAppBar(title: APPStrings.messages.tr),
      body: SmartSingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.0.w, vertical: 24.h),
        child: BlocBuilder<MessageDetailBloc, MessageDetailState>(
          buildWhen: (previous, current) => current is MessageDetailLoadedState,
          builder: (context, state) {
            return Column(
              children: [
                SmartText(bloc.messagesModel?.message, style: style.messageDetailTitleStyle),
                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SmartImage(
                      path: bloc.messagesModel?.userImageUrl ?? "",
                      height: 40.w,
                      width: 40.w,
                      imageBorderRadius: BorderRadius.circular(50.r),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SmartText(bloc.messagesModel?.userName ?? "", style: style.messageDetailFullMessageStyle),
                              SizedBox(width: 8.w),
                              SmartText(bloc.messagesModel?.timeAgo ?? "", style: style.timeAgoStyle),
                            ],
                          ),
                          Row(
                            children: [
                              SmartText(APPStrings.toX.tr.interpolate([APPStrings.me.tr]), style: style.messageDetailToUserNameStyle),
                              Icon(Icons.keyboard_arrow_down, size: 22.w),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                SmartText(bloc.messagesModel?.fullMessage ?? "", style: style.messageDetailFullMessageStyle),
                SizedBox(height: 32.h),
                if (bloc.messagesModel?.details != null || bloc.messagesModel?.details?.isEmpty != true) const Divider(),
                ListView.separated(
                  itemCount: bloc.messagesModel?.details?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, msgIndex) {
                    MessagesDetailsModel detailsModel = bloc.messagesModel!.details![msgIndex];
                    return BlocBuilder<MessageDetailBloc, MessageDetailState>(
                      buildWhen:
                          (previous, current) =>
                              current is MessageShowFullMessageState && (current.oldIndex == msgIndex || current.index == msgIndex),
                      builder: (context, state) {
                        return SmartExpansionTile(
                          key: detailsModel.messageDetailsKey,
                          onExpansionChanged: (value) {
                            bloc.add(MessageShowFullMessageEvent(index: msgIndex, isExpanded: value));
                          },
                          title: Padding(
                            padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SmartImage(
                                  path: detailsModel.userImageUrl ?? "",
                                  height: 40.w,
                                  width: 40.w,
                                  imageBorderRadius: BorderRadius.circular(50.r),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SmartText(detailsModel.userName ?? "", style: style.messageDetailFullMessageStyle),
                                          SizedBox(width: 8.w),
                                          SmartText(detailsModel.timeAgo ?? "", style: style.timeAgoStyle),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SmartText(
                                            detailsModel.toMe
                                                ? APPStrings.toX.tr.interpolate([APPStrings.me.tr])
                                                : APPStrings.toX.tr.interpolate([detailsModel.toUserName ?? ""]),
                                            style: style.messageDetailToUserNameStyle,
                                          ),
                                          Icon(Icons.keyboard_arrow_down, size: 22.w),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          children: [
                            SizedBox(height: 12.h),
                            SmartText(detailsModel.fullMessage ?? "", style: style.messageDetailFullMessageStyle),
                            SizedBox(height: 24.h),
                          ],
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
