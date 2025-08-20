part of 'share_presentation_bloc.dart';

sealed class SharePresentationEvent extends Equatable {
  const SharePresentationEvent();
}

final class SharePresentationInitialEvent extends SharePresentationEvent {
  ///[isPresentation] is a boolean variable that is used to determine whether the screen is for sharing a presentation or a catalogue.
  final bool isPresentation;
  final String? webUrl;
  final BuildContext context;

  const SharePresentationInitialEvent(this.context, {this.isPresentation = true, this.webUrl});

  @override
  List<Object> get props => [isPresentation, context, webUrl ?? ''];
}

final class ChangeUserAccessTypeEvent extends SharePresentationEvent {
  final UserAccessType selectedUserAccessType;
  final PresentationSharedUserData user;

  const ChangeUserAccessTypeEvent(this.selectedUserAccessType, this.user);

  @override
  List<Object> get props => [selectedUserAccessType, user];
}

final class ChangeGeneralAccessTypeEvent extends SharePresentationEvent {
  final UserAccessType selectedGeneralAccessType;

  const ChangeGeneralAccessTypeEvent(this.selectedGeneralAccessType);

  @override
  List<Object> get props => [selectedGeneralAccessType];
}
