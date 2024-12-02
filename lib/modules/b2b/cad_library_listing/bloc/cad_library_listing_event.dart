part of 'cad_library_listing_bloc.dart';

sealed class CadLibraryListingEvent extends Equatable {
  const CadLibraryListingEvent();
}

final class InitialCadListingEvent extends CadLibraryListingEvent {
  final BuildContext context;

  const InitialCadListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class CadChangeListingTypeEvent extends CadLibraryListingEvent {
  final bool isGrid;

  const CadChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class CadListLoadMoreEvent extends CadLibraryListingEvent {
  final BuildContext context;

  final int currentPage;

  const CadListLoadMoreEvent(this.context, this.currentPage);

  @override
  List<Object> get props => [context, currentPage];
}

final class CadListPullToRefreshEvent extends CadLibraryListingEvent {
  final BuildContext context;

  const CadListPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class CadSortEvent extends CadLibraryListingEvent {
  final BuildContext context;
  final SortOptions sortData;

  const CadSortEvent({required this.context, required this.sortData});

  @override
  List<Object> get props => [context, sortData];
}
