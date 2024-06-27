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
