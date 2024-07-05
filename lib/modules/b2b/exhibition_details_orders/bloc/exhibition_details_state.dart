part of 'exhibition_details_bloc.dart';

sealed class ExhibitionDetailsState extends Equatable {
  const ExhibitionDetailsState();
}

final class ExhibitionDetailsInitialsState extends ExhibitionDetailsState {
  const ExhibitionDetailsInitialsState();

  @override
  List<Object?> get props => [];
}

final class ExhibitionDetailsReloadState extends ExhibitionDetailsState {
  const ExhibitionDetailsReloadState();

  @override
  List<Object?> get props => [];
}

final class ExhibitionDetailsLoadedState extends ExhibitionDetailsState {
  const ExhibitionDetailsLoadedState();

  @override
  List<Object> get props => [];
}

final class ChangeExhibitionTabsState extends ExhibitionDetailsState {
  const ChangeExhibitionTabsState();

  @override
  List<Object> get props => [];
}

final class ExhibitionListingLoadingMoreState extends ExhibitionDetailsState {
  const ExhibitionListingLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class ExhibitionChangeListingTypeState extends ExhibitionDetailsState {
  const ExhibitionChangeListingTypeState();

  @override
  List<Object> get props => [];
}

final class ExhibitionListingLoadedMoreState extends ExhibitionDetailsState {
  final int currentPage;

  const ExhibitionListingLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
