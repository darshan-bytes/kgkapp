part of 'design_listing_bloc.dart';

sealed class DesignListingEvent extends Equatable {
  const DesignListingEvent();
}

final class InitialDesignListingEvent extends DesignListingEvent {
  final BuildContext context;

  const InitialDesignListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class DesignChangeListingTypeEvent extends DesignListingEvent {
  final bool isGrid;

  const DesignChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class DesignListLoadMoreEvent extends DesignListingEvent {
  final int currentPage;

  const DesignListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class DesignListPullToRefreshEvent extends DesignListingEvent {
  const DesignListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
