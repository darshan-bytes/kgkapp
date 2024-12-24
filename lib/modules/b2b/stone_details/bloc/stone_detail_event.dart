part of 'stone_detail_bloc.dart';

sealed class StoneDetailEvent extends Equatable {
  const StoneDetailEvent();
}

class StoneDetailInitialEvent extends StoneDetailEvent {
  final BuildContext context;

  const StoneDetailInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class StoneDetailsToggleEvent extends StoneDetailEvent {
  const StoneDetailsToggleEvent();

  @override
  List<Object> get props => [];
}

final class StoneDetailSelectStoneForDIYEvent extends StoneDetailEvent {
  final BuildContext context;

  const StoneDetailSelectStoneForDIYEvent({required this.context});

  @override
  List<Object> get props => [];
}
