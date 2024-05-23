part of 'diamond_listing_bloc.dart';

abstract class DiamondListingEvent extends Equatable {
  const DiamondListingEvent();

  @override
  List<Object?> get props => [];
}

class GetDiamondProductListEvent extends DiamondListingEvent{
  const GetDiamondProductListEvent();

  @override
  List<Object?> get props => [];
}

class DiamondChangeTypeEvent extends DiamondListingEvent {
  final bool isIndividual;

  const DiamondChangeTypeEvent(this.isIndividual);

  @override
  List<Object?> get props => [isIndividual];
}

class ChangeListingTypeEvent extends DiamondListingEvent {
  final bool isGrid;

  const ChangeListingTypeEvent(this.isGrid);

  @override
  List<Object?> get props => [isGrid];
}

class ProductChangePageNumberEvent extends DiamondListingEvent {
  final String pageNumber;

  const ProductChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
