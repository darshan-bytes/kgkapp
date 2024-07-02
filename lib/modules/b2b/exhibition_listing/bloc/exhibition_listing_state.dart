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

final class ExhibitionListingLoadedState extends ExhibitionListingState {
  @override
  List<Object?> get props => [];
}
