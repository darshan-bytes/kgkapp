part of 'setting_listing_bloc.dart';

abstract class SettingListingEvent extends Equatable {
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
  final bool isGrid;

  const SettingChangeListingTypeEvent(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}

class SettingProductChangePageNumberEvent extends SettingListingEvent {
  final String pageNumber;

  const SettingProductChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
