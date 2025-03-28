part of 'user_master_listing_bloc.dart';

sealed class UserMasterListingState extends Equatable {
  const UserMasterListingState();

  @override
  List<Object> get props => [];
}

class UserMasterListingInitial extends UserMasterListingState {
  @override
  List<Object> get props => [];
}

class UserMasterListReloadState extends UserMasterListingState {
  @override
  List<Object> get props => [];
}

class UserMasterListingLoadedState extends UserMasterListingState {
  @override
  List<Object> get props => [];
}

class UserMasterListLoadingMoreState extends UserMasterListingState {
  const UserMasterListLoadingMoreState();

  @override
  List<Object> get props => [];
}

class UserMasterListLoadedMoreState extends UserMasterListingState {
  final int currentPage;

  const UserMasterListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class UserMasterChangeLocationTypeState extends UserMasterListingState {
  final UserLocationModel selectedUserLocationType;

  const UserMasterChangeLocationTypeState(this.selectedUserLocationType);

  @override
  List<Object> get props => [selectedUserLocationType];
}

final class UserMasterLoadingState extends UserMasterListingState {
  const UserMasterLoadingState();

  @override
  List<Object> get props => [];
}
