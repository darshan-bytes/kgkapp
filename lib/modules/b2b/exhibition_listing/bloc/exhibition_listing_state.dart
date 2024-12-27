part of 'exhibition_listing_bloc.dart';

sealed class ExhibitionListingState extends Equatable {
  @override
  List<Object?> get props => [];

  const ExhibitionListingState();
}

final class ExhibitionListingInitialState extends ExhibitionListingState {
  @override
  List<Object?> get props => [];
}

final class ExhibitionListingReloadState extends ExhibitionListingState {
  @override
  List<Object?> get props => [];
}

final class ExhibitionListingLoadedState extends ExhibitionListingState {
  @override
  List<Object?> get props => [];
}

final class ExhibitionListLoadingMoreState extends ExhibitionListingState {
  const ExhibitionListLoadingMoreState();

  @override
  List<Object> get props => [];
}

final class ExhibitionListingLoadingState extends ExhibitionListingState {
  const ExhibitionListingLoadingState();

  @override
  List<Object> get props => [];
}

final class ExhibitionListLoadMoreState extends ExhibitionListingState {
  final int currentPage;

  const ExhibitionListLoadMoreState({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

final class ExhibitionFilterListLoadedState extends ExhibitionListingState {
  @override
  List<Object?> get props => [];
}

final class ChangeExhibitionTabsState extends ExhibitionListingState {
  const ChangeExhibitionTabsState();

  @override
  List<Object> get props => [];
}
