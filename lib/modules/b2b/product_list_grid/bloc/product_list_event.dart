part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();
}

final class InitialProductListEvent extends ProductListEvent {
  final BuildContext context;

  const InitialProductListEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ProductChangeListingTypeEvent extends ProductListEvent {
  const ProductChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

final class ProductListLoadMoreEvent extends ProductListEvent {
  final int currentPage;

  const ProductListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class WatchlistChangeNameEvent extends ProductListEvent {
  final WatchlistSelectionModel selectedWatchlist;

  const WatchlistChangeNameEvent(this.selectedWatchlist);

  @override
  List<Object> get props => [selectedWatchlist];
}

class WatchlistCheckEvent extends ProductListEvent {
  final WatchlistSelectionModel checkWatchlist;

  const WatchlistCheckEvent({required this.checkWatchlist});

  @override
  List<Object> get props => [checkWatchlist];
}
