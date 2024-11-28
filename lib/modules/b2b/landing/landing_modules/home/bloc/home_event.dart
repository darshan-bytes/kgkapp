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

final class HomeSelectStoneChangeTypeEvent extends HomeEvent {
  final OrderStoneTypeModel selectedStep1StoneType;

  const HomeSelectStoneChangeTypeEvent({required this.selectedStep1StoneType});

  @override
  List<Object> get props => [selectedStep1StoneType];
}

final class HomeSelectJewelleryChangeTypeEvent extends HomeEvent {
  final OrderStoneTypeModel selectedStep2RingType;

  const HomeSelectJewelleryChangeTypeEvent({required this.selectedStep2RingType});

  @override
  List<Object> get props => [selectedStep2RingType];
}

final class HomeKgkCoutureSelectionChangeEvent extends HomeEvent {
  final int index;
  final BuildContext context;

  const HomeKgkCoutureSelectionChangeEvent({
    required this.context,
    required this.index,
  });

  @override
  List<Object> get props => [context, index];
}

final class HomeCategoryPageChangeEvent extends HomeEvent {
  final int index;

  const HomeCategoryPageChangeEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class HomeStrapiDataFetchedEvent extends HomeEvent {
  const HomeStrapiDataFetchedEvent();

  @override
  List<Object> get props => [];
}

final class HomePullToRefreshEvent extends HomeEvent {
  final BuildContext context;

  const HomePullToRefreshEvent({required this.context});

  @override
  List<Object> get props => [context];
}
