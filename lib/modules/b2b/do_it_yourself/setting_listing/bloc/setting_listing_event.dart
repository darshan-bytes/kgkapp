part of 'setting_listing_bloc.dart';

sealed class SettingListingEvent extends Equatable {
  const SettingListingEvent();

  @override
  List<Object> get props => [];
}

final class GetSettingProductListEvent extends SettingListingEvent {
  final BuildContext context;

  const GetSettingProductListEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class SettingChangeListingTypeEvent extends SettingListingEvent {
  const SettingChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

final class LoadMoreSettingProductListEvent extends SettingListingEvent {
  final int currentPage;

  const LoadMoreSettingProductListEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class SettingListPullToRefreshEvent extends SettingListingEvent {
  const SettingListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
