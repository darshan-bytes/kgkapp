part of 'presentation_bloc.dart';

sealed class PresentationState extends Equatable {
  const PresentationState();
}

final class PresentationInitial extends PresentationState {
  @override
  List<Object> get props => [];
}

final class PresentationListReloadState extends PresentationState {
  @override
  List<Object> get props => [];
}

final class PresentationLoadedState extends PresentationState {
  @override
  List<Object> get props => [];
}

final class PaginationControllerLoadedState extends PresentationState {
  @override
  List<Object> get props => [];
}
