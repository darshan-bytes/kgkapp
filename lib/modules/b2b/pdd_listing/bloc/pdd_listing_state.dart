part of 'pdd_listing_bloc.dart';

sealed class PddListingState extends Equatable {
  const PddListingState();
}

final class PddListingInitial extends PddListingState {
  @override
  List<Object> get props => [];
}
