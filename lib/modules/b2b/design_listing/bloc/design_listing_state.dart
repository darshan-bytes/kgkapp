part of 'design_listing_bloc.dart';

sealed class DesignListingState extends Equatable {
  const DesignListingState();
}

final class DesignListingInitial extends DesignListingState {
  const DesignListingInitial();

  @override
  List<Object> get props => [];
}

final class DesignListingLoadingState extends DesignListingState {
  const DesignListingLoadingState();

  @override
  List<Object> get props => [];
}

final class DesignListingLoadedState extends DesignListingState {
  const DesignListingLoadedState();

  @override
  List<Object> get props => [];
}

final class DesignListLoadingMoreState extends DesignListingState {
  const DesignListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class DesignListingReloadState extends DesignListingState {
  @override
  List<Object> get props => [];
}

final class DesignChangeListingTypeState extends DesignListingState {
  const DesignChangeListingTypeState();

  @override
  List<Object> get props => [];
}

final class DesignListLoadedMoreState extends DesignListingState {
  final int currentPage;

  const DesignListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
