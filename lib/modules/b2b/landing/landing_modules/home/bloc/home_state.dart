part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeReloadState extends HomeState {
  const HomeReloadState();

  @override
  List<Object> get props => [];
}

final class HomeJewelleryImagePageChangeState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeSelectStoneTypeChangeState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeSelectJewelleryTypeChangeState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeKgkCoutureSelectionChangeState extends HomeState {
  final int selectedIndex;
  final int oldIndex;

  const HomeKgkCoutureSelectionChangeState(this.selectedIndex, this.oldIndex);

  @override
  List<Object> get props => [selectedIndex, oldIndex];
}

final class HomeCategoryPageChangeState extends HomeState {
  final int index;

  const HomeCategoryPageChangeState(this.index);

  @override
  List<Object> get props => [index];
}

final class HomeStrapiDataFetchedState extends HomeState {
  const HomeStrapiDataFetchedState();

  @override
  List<Object> get props => [];
}

final class HomeErrorState extends HomeState {
  final String errorMessage;

  const HomeErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
