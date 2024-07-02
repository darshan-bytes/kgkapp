part of 'exhibition_listing_bloc.dart';

sealed class ExhibitionListingEvent extends Equatable {
  const ExhibitionListingEvent();
}

final class InitialExhibitionListingEvent extends ExhibitionListingEvent {
  final BuildContext context;

  const InitialExhibitionListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}
