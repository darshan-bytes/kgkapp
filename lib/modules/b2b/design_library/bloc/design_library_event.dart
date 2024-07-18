part of 'design_library_bloc.dart';

sealed class DesignLibraryEvent extends Equatable {
  const DesignLibraryEvent();
}

final class DesignLibraryInitialEvent extends DesignLibraryEvent {
  const DesignLibraryInitialEvent();

  @override
  List<Object> get props => [];
}

final class DesignLibraryChangeListingTypeEvent extends DesignLibraryEvent {
  final bool isGrid;

  const DesignLibraryChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class DesignLibraryLoadMoreEvent extends DesignLibraryEvent {
  final int currentPage;

  const DesignLibraryLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class DesignLibraryPullToRefreshEvent extends DesignLibraryEvent {
  const DesignLibraryPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
