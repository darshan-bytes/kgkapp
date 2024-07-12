part of 'presentation_bloc.dart';

sealed class PresentationEvent extends Equatable {
  const PresentationEvent();
}

final class InitialPresentationEvent extends PresentationEvent {
  const InitialPresentationEvent();

  @override
  List<Object> get props => [];
}

final class PresentationLoadMoreEvent extends PresentationEvent {
  final int currentPage;

  const PresentationLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
