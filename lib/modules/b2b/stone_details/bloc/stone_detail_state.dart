part of 'stone_detail_bloc.dart';

sealed class StoneDetailState extends Equatable {
  const StoneDetailState();
}

final class StoneDetailInitial extends StoneDetailState {
  @override
  List<Object> get props => [];
}

final class StoneDetailReloadedState extends StoneDetailState {
  @override
  List<Object> get props => [];
}

final class StoneDetailsToggleState extends StoneDetailState {
  final bool isDiamondDetailsOpen;

  const StoneDetailsToggleState(this.isDiamondDetailsOpen);

  @override
  List<Object> get props => [isDiamondDetailsOpen];
}

final class StoneDetailReloadState extends StoneDetailState {
  @override
  List<Object> get props => [];
}
