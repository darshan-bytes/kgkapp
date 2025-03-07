part of 'support_bloc.dart';

sealed class SupportState extends Equatable {
  const SupportState();
}

final class SupportInitial extends SupportState {
  @override
  List<Object> get props => [];
}

final class SupportLoadedState extends SupportState {
  @override
  List<Object> get props => [];
}

final class SupportLoadingState extends SupportState {
  @override
  List<Object> get props => [];
}
