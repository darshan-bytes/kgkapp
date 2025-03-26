part of 'presentation_bloc.dart';

sealed class PresentationEvent extends Equatable {
  const PresentationEvent();
}

final class InitialPresentationEvent extends PresentationEvent {
  final BuildContext context;

  const InitialPresentationEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class PresentationLoadMoreEvent extends PresentationEvent {
  final int currentPage;

  const PresentationLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class PresentationPullToRefreshEvent extends PresentationEvent {
  const PresentationPullToRefreshEvent();

  @override
  List<Object> get props => [];
}

final class PresentationReviewStateEvent extends PresentationEvent {
  final bool isApproved;
  final String presentationNumber;
  final BuildContext context;

  const PresentationReviewStateEvent({required this.context, required this.isApproved, required this.presentationNumber});

  @override
  List<Object> get props => [context, isApproved, presentationNumber];
}
