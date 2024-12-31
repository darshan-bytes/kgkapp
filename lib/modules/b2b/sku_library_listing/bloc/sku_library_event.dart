
part of 'sku_library_bloc.dart';

sealed class SkuLibraryEvent extends Equatable {
  const SkuLibraryEvent();
}

final class SkuLibraryInitialEvent extends SkuLibraryEvent {
  final BuildContext context;

  const SkuLibraryInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class SkuLibraryChangeListingTypeEvent extends SkuLibraryEvent {
  final bool isGrid;

  const SkuLibraryChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class SkuLibraryLoadMoreEvent extends SkuLibraryEvent {
  final BuildContext context;
  final int currentPage;

  const SkuLibraryLoadMoreEvent({required this.context, required this.currentPage});

  @override
  List<Object> get props => [context, currentPage];
}

final class SkuLibraryPullToRefreshEvent extends SkuLibraryEvent {
  final BuildContext context;

  const SkuLibraryPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class SkuLibrarySortEvent extends SkuLibraryEvent {
  final BuildContext context;
  final SortOptions sortData;

  const SkuLibrarySortEvent({required this.context, required this.sortData});

  @override
  List<Object> get props => [context, sortData];
}

final class SkuLibraryFilterEvent extends SkuLibraryEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const SkuLibraryFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}