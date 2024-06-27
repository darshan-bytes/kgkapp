part of 'share_presentation_bloc.dart';

sealed class SharePresentationState extends Equatable {
  const SharePresentationState();
}

final class SharePresentationInitial extends SharePresentationState {
  @override
  List<Object> get props => [];
}

final class SharePresentationTitleLoadedState extends SharePresentationState {
  final String title;

  const SharePresentationTitleLoadedState(this.title);

  @override
  List<Object> get props => [title];
}

final class SharePresentationLoadingState extends SharePresentationState {
  const SharePresentationLoadingState();

  @override
  List<Object> get props => [];
}

final class SharePresentationLoadedState extends SharePresentationState {
  const SharePresentationLoadedState();

  @override
  List<Object> get props => [];
}
