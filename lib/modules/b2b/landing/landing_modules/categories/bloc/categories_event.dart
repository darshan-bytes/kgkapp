part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class CategoriesInitialEvent extends CategoriesEvent {
  final BuildContext context;

  const CategoriesInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class CategoriesSelectedEvent extends CategoriesEvent {
  final int index;
  final int itemIndex;
  final List<CategoriesModel> subList;

  const CategoriesSelectedEvent(this.index, this.itemIndex, this.subList);

  @override
  List<Object> get props => [index, itemIndex, subList];
}
