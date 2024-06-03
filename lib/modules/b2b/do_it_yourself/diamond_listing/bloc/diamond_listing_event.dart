part of 'diamond_listing_bloc.dart';

sealed class DiamondListingEvent extends Equatable {
  const DiamondListingEvent();
  
  @override
  List<Object> get props => [];
}

class GetDiamondProductListEvent extends DiamondListingEvent {
  final BuildContext context;

  const GetDiamondProductListEvent(this.context);

  @override
  List<Object> get props => [context];
}

class DiamondChangeTypeEvent extends DiamondListingEvent {
  final bool isIndividual;

  const DiamondChangeTypeEvent(this.isIndividual);

  @override
  List<Object> get props => [isIndividual];
}

class ChangeListingTypeEvent extends DiamondListingEvent {
  final bool isGrid;

  const ChangeListingTypeEvent(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

class DiamondProductChangePageNumberEvent extends DiamondListingEvent {
  final String pageNumber;

  const DiamondProductChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
