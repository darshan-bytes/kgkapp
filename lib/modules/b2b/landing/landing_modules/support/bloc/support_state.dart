part of 'support_bloc.dart';

sealed class SupportState extends Equatable {
  const SupportState();
}

final class SupportInitial extends SupportState {
  @override
  List<Object> get props => [];
}

final class SupportReloadState extends SupportState {
  @override
  List<Object> get props => [];
}
