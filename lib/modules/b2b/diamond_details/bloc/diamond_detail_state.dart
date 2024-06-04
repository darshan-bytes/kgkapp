part of 'diamond_detail_bloc.dart';

sealed class DiamondDetailState extends Equatable {
  const DiamondDetailState();
}

final class DiamondDetailInitial extends DiamondDetailState {
  @override
  List<Object> get props => [];
}

final class DiamondImagePageChangeState extends DiamondDetailState {
  @override
  List<Object> get props => [];
}

final class DiamondDetailsToggleState extends DiamondDetailState {
  final bool isDiamondDetailsOpen;

  const DiamondDetailsToggleState(this.isDiamondDetailsOpen);

  @override
  List<Object> get props => [isDiamondDetailsOpen];
}

final class DiamondDetailReloadState extends DiamondDetailState {
  @override
  List<Object> get props => [];
}
