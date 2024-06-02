part of 'product_menu_bottomsheet_bloc.dart';

sealed class ProductMenuBottomSheetEvent extends Equatable {
  const ProductMenuBottomSheetEvent();

  @override
  List<Object> get props => [];
}

final class ChangeMoreDetailsEvent extends ProductMenuBottomSheetEvent {
  const ChangeMoreDetailsEvent();

  @override
  List<Object> get props => [];
}
