import 'package:kgk/kgk.dart';

class InquiryDetailScreen extends StatelessWidget {
  const InquiryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<InquiryDetailBloc>(context);
    final OrderDetailScreenStyle style = AppTheme.of(context).orderDetailScreenStyle;
    return Scaffold(resizeToAvoidBottomInset: true, appBar: _buildAppBar(bloc), body: _buildBody(context, style, bloc));
  }

  SmartAppBar _buildAppBar(InquiryDetailBloc bloc) {
    return SmartAppBar(title: APPStrings.inquiryDetail.tr);
  }

  Widget _buildBody(BuildContext context, OrderDetailScreenStyle style, InquiryDetailBloc bloc) {
    return Column(
      children: [_buildInquiryDetailHeader(style, bloc), _buildCommentsList(style, bloc), _buildAddCommentField(context, bloc, style)],
    );
  }

  Widget _buildInquiryDetailHeader(OrderDetailScreenStyle style, InquiryDetailBloc bloc) {
    return BlocBuilder<InquiryDetailBloc, InquiryDetailState>(
      bloc: bloc,
      buildWhen: (previous, current) => current is InquiryDetailLoaded,
      builder: (context, state) {
        if (state is! InquiryDetailLoaded) {
          return const SizedBox.shrink();
        }
        return Container(
          color: style.detailsTileColor,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 17.0.w, vertical: 24.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((bloc.inquiryData?.id).isNotNullNorEmpty) ...[
                      SmartText("#${bloc.inquiryData?.id}", style: style.orderIdStyle),
                      SizedBox(height: 4.h),
                    ],
                    if (bloc.inquiryData?.contextId != null) ...[
                      SmartRichText(
                        spans: [
                          SmartTextSpan(text: bloc.inquiryData?.inquiryType ?? '', style: style.orderDateStyle),
                          SmartTextSpan(text: " : ", style: style.orderDateStyle),
                          SmartTextSpan(text: bloc.inquiryData?.contextId ?? '', style: style.orderDateStyle),
                        ],
                      ),
                      SizedBox(height: 8.h),
                    ],
                    SmartRichText(
                      spans: [
                        SmartTextSpan(text: APPStrings.receivedOn.tr, style: style.orderDateStyle),
                        SmartTextSpan(text: " : ", style: style.orderDateStyle),
                        SmartTextSpan(
                          text:
                              bloc.inquiryData?.createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2) ??
                              '',
                          style: style.orderDateStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentsList(OrderDetailScreenStyle style, InquiryDetailBloc bloc) {
    return Expanded(
      child: ListView.separated(
        controller: bloc.scrollController,
        padding: EdgeInsetsDirectional.symmetric(vertical: 20.h, horizontal: 20.h),
        itemCount: bloc.inquiryData?.commentList.length ?? 0,
        itemBuilder: (context, index) {
          MyInquiryComment comment = bloc.inquiryData!.commentList[index];
          return CommentListItem(
            id: comment.fullName ?? '',
            createdAt: comment.createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2) ?? '',
            message: comment.comments ?? '',
            userImage: comment.profile?.setMediaUrl ?? '',
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
      ),
    );
  }

  Widget _buildAddCommentField(BuildContext context, InquiryDetailBloc bloc, OrderDetailScreenStyle style) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 8.h),
        child: SmartTextField(
          controller: bloc.messageController,
          hintText: APPStrings.typeYourMessage.tr,
          textInputAction: TextInputAction.send,
          suffixIcon: FittedBox(
            child: SmartButton(
              onTap: () {
                bloc.add(AddCommentInquiryDetailEvent(context: context));
              },
              title: APPStrings.send.tr,
              isFullWidth: false,
            ),
          ),
        ),
      ),
    );
  }
}
