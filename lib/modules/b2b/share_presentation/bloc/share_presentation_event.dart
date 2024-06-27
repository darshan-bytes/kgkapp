part of 'share_presentation_bloc.dart';

sealed class SharePresentationEvent extends Equatable {
  const SharePresentationEvent();
}

final class SharePresentationInitialEvent extends SharePresentationEvent {
  ///[isPresentation] is a boolean variable that is used to determine whether the screen is for sharing a presentation or a catalogue.
  final bool isPresentation;

  const SharePresentationInitialEvent({this.isPresentation = true});

  @override
  List<Object> get props => [isPresentation];
}
