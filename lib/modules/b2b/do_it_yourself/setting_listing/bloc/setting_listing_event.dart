part of 'setting_listing_bloc.dart';

sealed class SettingListingEvent extends Equatable {
  const SettingListingEvent();

  @override
  List<Object> get props => [];
}

final class SettingListingInitialEvent extends SettingListingEvent {
  final BuildContext context;

  const SettingListingInitialEvent(this.context);

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
  final BuildContext context;

  const LoadMoreSettingProductListEvent({required this.context, required this.currentPage});

  @override
  List<Object> get props => [context, currentPage];
}

final class SettingListPullToRefreshEvent extends SettingListingEvent {
  final BuildContext context;

  const SettingListPullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class SettingListingOnTapEvent extends SettingListingEvent {
  final BuildContext context;
  final int index;

  const SettingListingOnTapEvent({required this.context, required this.index});

  @override
  List<Object> get props => [context, index];
}
