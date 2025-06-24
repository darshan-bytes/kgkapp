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

final class PresentationReviewStateEvent extends PresentationEvent {
  final bool isApproved;
  final int index;
  final BuildContext context;

  const PresentationReviewStateEvent({required this.context, required this.isApproved, required this.index});

  @override
  List<Object> get props => [context, isApproved, index];
}
