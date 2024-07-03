part of 'manufacturer_order_listing_bloc.dart';

sealed class ManufacturerOrderListingState extends Equatable {
  const ManufacturerOrderListingState();
}

final class ManufacturerOrderListingInitial extends ManufacturerOrderListingState {
  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListingLoadedState extends ManufacturerOrderListingState {
  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListLoadingMoreState extends ManufacturerOrderListingState {
  const ManufacturerOrderListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class ManufacturerOrderListLoadedMoreState extends ManufacturerOrderListingState {
  final int currentPage;

  const ManufacturerOrderListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
