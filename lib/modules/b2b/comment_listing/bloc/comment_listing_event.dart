part of 'comment_listing_bloc.dart';

sealed class CommentListingEvent extends Equatable {
  const CommentListingEvent();

  @override
  List<Object> get props => [];
}

final class InitialCommentListingEvent extends CommentListingEvent {
  final BuildContext context;
  const InitialCommentListingEvent({required this.context});
}

final class CommentAddedApiCallEvent extends CommentListingEvent {
  final BuildContext context;
  const CommentAddedApiCallEvent({required this.context});

  @override
  List<Object> get props => [context];
}
