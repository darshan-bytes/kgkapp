part of 'cad_library_listing_bloc.dart';

sealed class CadLibraryListingEvent extends Equatable {
  const CadLibraryListingEvent();
}

final class InitialCadListingEvent extends CadLibraryListingEvent {
  @override
  List<Object> get props => [];
}

final class CadChangeListingTypeEvent extends CadLibraryListingEvent {
  final bool isGrid;

  const CadChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
}

final class CadListLoadMoreEvent extends CadLibraryListingEvent {
  final int currentPage;

  const CadListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
