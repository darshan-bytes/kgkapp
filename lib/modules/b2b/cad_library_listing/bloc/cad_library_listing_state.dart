part of 'cad_library_listing_bloc.dart';

sealed class CadLibraryListingState extends Equatable {
  const CadLibraryListingState();
}

final class CadListingInitial extends CadLibraryListingState {
  @override
  List<Object> get props => [];
}

final class CadListingLoadedState extends CadLibraryListingState {
  @override
  List<Object> get props => [];
}

final class CadListLoadingMoreState extends CadLibraryListingState {
  const CadListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class CadListingReloadState extends CadLibraryListingState {
  @override
  List<Object> get props => [];
}

final class CadChangeListingTypeState extends CadLibraryListingState {
  const CadChangeListingTypeState();

  @override
  List<Object> get props => [];
}

final class CadListLoadedMoreState extends CadLibraryListingState {
  const CadListLoadedMoreState();

  @override
  List<Object> get props => [];
}

final class CadAppBarTitleChangedState extends CadLibraryListingState {
  const CadAppBarTitleChangedState();

  @override
  List<Object> get props => [];
}

final class CadPullToRefreshState extends CadLibraryListingState {
  const CadPullToRefreshState();

  @override
  List<Object> get props => [];
}
