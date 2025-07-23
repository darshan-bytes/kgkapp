part of 'inquiry_detail_bloc.dart';

sealed class InquiryDetailEvent extends Equatable {
  const InquiryDetailEvent();
}

final class InitialInquiryDetailEvent extends InquiryDetailEvent {
  final BuildContext context;

  const InitialInquiryDetailEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

final class AddCommentInquiryDetailEvent extends InquiryDetailEvent {
  final BuildContext context;

  const AddCommentInquiryDetailEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
