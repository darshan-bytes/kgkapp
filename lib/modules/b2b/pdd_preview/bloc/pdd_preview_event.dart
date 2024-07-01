part of 'pdd_preview_bloc.dart';

sealed class PddPreviewEvent extends Equatable {
  const PddPreviewEvent();
}

final class InitialPddPreviewEvent extends PddPreviewEvent {
  final BuildContext context;

  const InitialPddPreviewEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class NavigateToPddVersionHistoryEvent extends PddPreviewEvent {
  final BuildContext context;

  const NavigateToPddVersionHistoryEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class SharePddPreviewEvent extends PddPreviewEvent {
  final BuildContext context;
  final String url;

  const SharePddPreviewEvent({required this.context, required this.url});

  @override
  List<Object> get props => [context, url];
}

final class VersionHistoryChangeEvent extends PddPreviewEvent {
  final PddVersionHistoryModel pddVersionHistoryModel;
  const VersionHistoryChangeEvent({required this.pddVersionHistoryModel});

  @override
  List<Object> get props => [pddVersionHistoryModel];
}
