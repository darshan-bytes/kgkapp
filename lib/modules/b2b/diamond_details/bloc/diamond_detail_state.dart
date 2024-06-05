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

final class DiamondDetailReloadedState extends DiamondDetailState {
  @override
  List<Object> get props => [];
}
