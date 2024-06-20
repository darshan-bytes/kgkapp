part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class CategoriesSelectedEvent extends CategoriesEvent {
  final int index;
  final int itemIndex;

  const CategoriesSelectedEvent(this.index, this.itemIndex);

  @override
  List<Object> get props => [index, itemIndex];
}
