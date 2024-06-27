part of 'pdd_preview_bloc.dart';

sealed class PddPreviewState extends Equatable {
  const PddPreviewState();
}

final class InitialPddPreviewState extends PddPreviewState {
  @override
  List<Object> get props => [];
}

final class PddPreviewReloadState extends PddPreviewState {
  final bool reload = true;
  @override
  List<Object> get props => [];
}

final class PddPreviewLoadedState extends PddPreviewState {
  @override
  List<Object> get props => [];
}
