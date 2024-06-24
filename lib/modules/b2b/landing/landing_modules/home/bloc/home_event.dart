part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeInitialEvent extends HomeEvent {
  final BuildContext context;

  const HomeInitialEvent({required this.context});

  @override
  List<Object> get props => [];
}

class HomeJewelleryImagePageChangeEvent extends HomeEvent {
  final int index;

  const HomeJewelleryImagePageChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}

final class ChangeHomeTabsEvent extends HomeEvent {
  const ChangeHomeTabsEvent();

  @override
  List<Object> get props => [];
}

final class ChangeHomeStep1StoneTypeEvent extends HomeEvent {
  final OrderStoneTypeModel selectedStep1StoneType;

  const ChangeHomeStep1StoneTypeEvent({required this.selectedStep1StoneType});

  @override
  List<Object> get props => [selectedStep1StoneType];
}

final class ChangeHomeStep2StoneTypeEvent extends HomeEvent {
  final OrderStoneTypeModel selectedStep2RingType;

  const ChangeHomeStep2StoneTypeEvent({required this.selectedStep2RingType});

  @override
  List<Object> get props => [selectedStep2RingType];
}
