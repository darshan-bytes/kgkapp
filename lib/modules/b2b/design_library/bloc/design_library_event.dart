part of 'design_library_bloc.dart';

sealed class DesignLibraryEvent extends Equatable {
  const DesignLibraryEvent();
}

final class DesignLibraryInitialEvent extends DesignLibraryEvent {
  final BuildContext context;

  const DesignLibraryInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class DesignLibraryChangeListingTypeEvent extends DesignLibraryEvent {
  final bool isGrid;

  const DesignLibraryChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class DesignLibraryLoadMoreEvent extends DesignLibraryEvent {
  final BuildContext context;
  final int currentPage;

  const DesignLibraryLoadMoreEvent({required this.context, required this.currentPage});

  @override
  List<Object> get props => [context, currentPage];
}

final class DesignLibraryPullToRefreshEvent extends DesignLibraryEvent {
  final BuildContext context;

  const DesignLibraryPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class DesignLibrarySortEvent extends DesignLibraryEvent {
  final BuildContext context;
  final SortOptions sortData;

  const DesignLibrarySortEvent({required this.context, required this.sortData});

  @override
  List<Object> get props => [context, sortData];
}

final class DesignLibraryFilterEvent extends DesignLibraryEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const DesignLibraryFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}
