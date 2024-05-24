part of 'setting_listing_bloc.dart';

abstract class SettingListingState extends Equatable {
  const SettingListingState();
}

final class SettingListingInitial extends SettingListingState {
  const SettingListingInitial();

  @override
  List<Object> get props => [];
}

final class SettingLoadingState extends SettingListingState {
  const SettingLoadingState();

  @override
  List<Object> get props => [];
}

class SettingChangeListingTypeState extends SettingListingState {
  final bool isGrid;

  const SettingChangeListingTypeState(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

final class SettingProductChangePageNumberState extends SettingListingState {
  @override
  List<Object> get props => [];
}

final class SettingProductReloadState extends SettingListingState {
  const SettingProductReloadState();

  @override
  List<Object> get props => [];
}
