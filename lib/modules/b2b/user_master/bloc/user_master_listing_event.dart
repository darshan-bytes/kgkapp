part of 'user_master_listing_bloc.dart';

sealed class UserMasterListingEvent extends Equatable {
  const UserMasterListingEvent();
}

class InitialUserMasterListingEvent extends UserMasterListingEvent {
  const InitialUserMasterListingEvent();

  @override
  List<Object> get props => [];
}

class UserMasterListLoadMoreEvent extends UserMasterListingEvent {
  final int currentPage;

  const UserMasterListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class UserMasterChangeLocationTypeEvent extends UserMasterListingEvent {
  final UserLocationModel selectedUserLocationType;

  const UserMasterChangeLocationTypeEvent(this.selectedUserLocationType);

  @override
  List<Object> get props => [selectedUserLocationType];
}

final class UserMasterListingPullToRefreshEvent extends UserMasterListingEvent {
  const UserMasterListingPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
