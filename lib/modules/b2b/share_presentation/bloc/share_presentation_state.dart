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

final class SharePresentationReloadState extends SharePresentationState {
  const SharePresentationReloadState();

  @override
  List<Object> get props => [];
}

final class ChangeUserAccessTypeState extends SharePresentationState {
  final UserAccessType selectedUserAccessType;

  const ChangeUserAccessTypeState(this.selectedUserAccessType);

  @override
  List<Object> get props => [selectedUserAccessType];
}

final class ChangeGeneralAccessTypeState extends SharePresentationState {
  final UserAccessType selectedGeneralAccessType;

  const ChangeGeneralAccessTypeState(this.selectedGeneralAccessType);

  @override
  List<Object> get props => [selectedGeneralAccessType];
}
