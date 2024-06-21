part of 'pdd_listing_bloc.dart';

sealed class PddListingEvent extends Equatable {
  const PddListingEvent();
}

final class InitialPddListingEvent extends PddListingEvent {
  final BuildContext context;

  const InitialPddListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class PresentationChangeListingTypeEvent extends PddListingEvent {
  const PresentationChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

final class FilterPresentationEvent extends PddListingEvent {
  const FilterPresentationEvent();

  @override
  List<Object> get props => [];
}
