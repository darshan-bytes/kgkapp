part of 'user_master_listing_bloc.dart';

sealed class UserMasterListingEvent extends Equatable {
  const UserMasterListingEvent();
}

class InitialUserMasterListingEvent extends UserMasterListingEvent {
  final BuildContext context;
  const InitialUserMasterListingEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class UserMasterListLoadMoreEvent extends UserMasterListingEvent {
  final int currentPage;
  final BuildContext context;

  const UserMasterListLoadMoreEvent({required this.context, required this.currentPage});

  @override
  List<Object> get props => [currentPage, context];
}

class UserMasterChangeLocationTypeEvent extends UserMasterListingEvent {
  final UserLocationModel selectedUserLocationType;

  const UserMasterChangeLocationTypeEvent(this.selectedUserLocationType);

  @override
  List<Object> get props => [selectedUserLocationType];
}

final class UserMasterListingPullToRefreshEvent extends UserMasterListingEvent {
  final BuildContext context;
  const UserMasterListingPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class UserMasterListingSearchEvent extends UserMasterListingEvent {
  final BuildContext context;

  const UserMasterListingSearchEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class UserMasterListingApplyFilterEvent extends UserMasterListingEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const UserMasterListingApplyFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}
