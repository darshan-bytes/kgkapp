part of 'product_menu_bottomsheet_bloc.dart';

sealed class ProductMenuBottomSheetState extends Equatable {
  const ProductMenuBottomSheetState();

  @override
  List<Object> get props => [];
}

final class ProductMenuBottomsheetInitial extends ProductMenuBottomSheetState {}

final class ChangeMoreDetailsState extends ProductMenuBottomSheetState {}

final class ProductMenuBottomSheetReloadState extends ProductMenuBottomSheetState {}
