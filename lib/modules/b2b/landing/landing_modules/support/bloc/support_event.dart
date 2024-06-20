part of 'support_bloc.dart';

sealed class SupportEvent extends Equatable {
  const SupportEvent();
}

final class SupportInitialEvent extends SupportEvent {
  final BuildContext context;

  const SupportInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}
