part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeReloadState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeJewelleryImagePageChangeState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeChangeTabsState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeStep1StoneTypeChangeState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeStep2StoneTypeChangeState extends HomeState {
  @override
  List<Object> get props => [];
}
