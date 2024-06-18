part of 'support_bloc.dart';

sealed class SupportEvent extends Equatable {
  const SupportEvent();
}

final class SupportInitialEvent extends SupportEvent {
  @override
  List<Object> get props => [];
}
