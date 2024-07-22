part of 'orion_bloc.dart';

sealed class OrionEvent extends Equatable {
  const OrionEvent();
}

final class OrionInitialEvent extends OrionEvent {
  const OrionInitialEvent();

  @override
  List<Object> get props => [];
}

final class OrionPriceRangeChangedEvent extends OrionEvent {
  final SfRangeValues values;
  final bool isFromTextField;
  final bool isMin;

  const OrionPriceRangeChangedEvent(this.values, {this.isFromTextField = false, this.isMin = true});

  @override
  List<Object> get props => [values, isFromTextField, isMin];
}

final class OrionDiamondShapeChangedEvent extends OrionEvent {
  final int index;

  const OrionDiamondShapeChangedEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class OrionDiamondPropertiesChangedEvent extends OrionEvent {
  final int diamondPropertiesIndex;
  final int propertiesIndex;

  const OrionDiamondPropertiesChangedEvent(this.diamondPropertiesIndex, this.propertiesIndex);

  @override
  List<Object> get props => [diamondPropertiesIndex, propertiesIndex];
}

final class OrionPriceRangeEditEvent extends OrionEvent {
  final bool isMin;

  const OrionPriceRangeEditEvent({this.isMin = true});

  @override
  List<Object> get props => [isMin];
}

final class OrionDiamondCalculateDotPositionsEvent extends OrionEvent {
  const OrionDiamondCalculateDotPositionsEvent();

  @override
  List<Object> get props => [];
}

final class OrionDiamondChangePointIndexEvent extends OrionEvent {
  final int index;

  const OrionDiamondChangePointIndexEvent({required this.index});

  @override
  List<Object> get props => [index];
}

final class OrionDiamondChartTouchInteractionUpEvent extends OrionEvent {
  final ChartTouchInteractionArgs tapArgs;

  const OrionDiamondChartTouchInteractionUpEvent({required this.tapArgs});

  @override
  List<Object> get props => [tapArgs];
}

final class OrionDiamondChartTouchInteractionDownEvent extends OrionEvent {
  final ChartTouchInteractionArgs tapArgs;

  const OrionDiamondChartTouchInteractionDownEvent({required this.tapArgs});

  @override
  List<Object> get props => [tapArgs];
}

final class OrionDiamondChartTouchInteractionMoveEvent extends OrionEvent {
  final ChartTouchInteractionArgs tapArgs;

  const OrionDiamondChartTouchInteractionMoveEvent({required this.tapArgs});

  @override
  List<Object> get props => [tapArgs];
}

final class OrionDiamondUpdatePinPositionEvent extends OrionEvent {
  final DragUpdateDetails dragUpdateDetails;

  const OrionDiamondUpdatePinPositionEvent({required this.dragUpdateDetails});

  @override
  List<Object> get props => [dragUpdateDetails];
}

final class OrionDiamondSnapNearestPoint extends OrionEvent {
  const OrionDiamondSnapNearestPoint();

  @override
  List<Object> get props => [];
}
