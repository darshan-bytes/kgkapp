part of 'stone_detail_bloc.dart';

sealed class StoneDetailState extends Equatable {
  const StoneDetailState();
}

final class StoneDetailInitial extends StoneDetailState {
  @override
  List<Object> get props => [];
}

final class StoneDetailLoadedState extends StoneDetailState {
  const StoneDetailLoadedState();

  @override
  List<Object> get props => [];
}

final class StoneDetailReloadState extends StoneDetailState {
  @override
  List<Object> get props => [];
}
