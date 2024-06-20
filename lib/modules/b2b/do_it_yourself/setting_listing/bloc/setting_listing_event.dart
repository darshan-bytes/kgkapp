part of 'setting_listing_bloc.dart';

sealed class SettingListingEvent extends Equatable {
  const SettingListingEvent();

  @override
  List<Object> get props => [];
}

class GetSettingProductListEvent extends SettingListingEvent {
  const GetSettingProductListEvent();

  @override
  List<Object> get props => [];
}

class SettingChangeListingTypeEvent extends SettingListingEvent {
  const SettingChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

class SettingProductChangePageNumberEvent extends SettingListingEvent {
  final String pageNumber;

  const SettingProductChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
