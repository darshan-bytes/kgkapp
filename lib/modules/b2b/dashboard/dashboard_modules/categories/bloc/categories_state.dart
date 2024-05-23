part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();
}

final class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

final class CategoriesSelected extends CategoriesState {
  @override
  List<Object> get props => [];
}

final class CategoriesReloaded extends CategoriesState {
  @override
  List<Object> get props => [];
}
