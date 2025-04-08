part of 'orion_bloc.dart';

sealed class OrionEvent extends Equatable {
  const OrionEvent();
}

final class OrionInitialEvent extends OrionEvent {
  final BuildContext context;

  const OrionInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class OrionPriceRangeChangedEvent extends OrionEvent {
  final SfRangeValues values;
  final bool isFromTextField;
  final bool isMin;
  final BuildContext context;

  const OrionPriceRangeChangedEvent(this.values, this.context, {this.isFromTextField = false, this.isMin = true});

  @override
  List<Object> get props => [values, isFromTextField, isMin, context];
}

final class OrionPriceRangeReleaseEvent extends OrionEvent {
  final SfRangeValues values;
  final bool isFromTextField;
  final bool isMin;
  final BuildContext context;

  const OrionPriceRangeReleaseEvent(this.values, this.context, {this.isFromTextField = false, this.isMin = true});

  @override
  List<Object> get props => [values, isFromTextField, isMin, context];
}

final class OrionDiamondShapeChangedEvent extends OrionEvent {
  final BuildContext context;
  final int index;

  const OrionDiamondShapeChangedEvent(this.context, this.index);

  @override
  List<Object> get props => [context, index];
}

final class OrionDiamondPropertiesChangedEvent extends OrionEvent {
  final BuildContext context;
  final int diamondPropertiesIndex;
  final int propertiesIndex;

  const OrionDiamondPropertiesChangedEvent(this.context,this.diamondPropertiesIndex, this.propertiesIndex);

  @override
  List<Object> get props => [context,diamondPropertiesIndex, propertiesIndex];
}

final class OrionPriceRangeEditEvent extends OrionEvent {
  final BuildContext context;
  final bool isMin;

  const OrionPriceRangeEditEvent(this.context, {this.isMin = true});

  @override
  List<Object> get props => [context, isMin];
}

final class OrionDiamondCalculateDotPositionsEvent extends OrionEvent {
  final BuildContext context;

  const OrionDiamondCalculateDotPositionsEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class OrionDiamondChangePointIndexEvent extends OrionEvent {
  final BuildContext context;
  final int index;

  const OrionDiamondChangePointIndexEvent({required this.context,required this.index});

  @override
  List<Object> get props => [context,index];
}

final class OrionDiamondChartTouchInteractionUpEvent extends OrionEvent {
  final BuildContext context;
  final ChartTouchInteractionArgs tapArgs;

  const OrionDiamondChartTouchInteractionUpEvent({required this.context,required this.tapArgs});

  @override
  List<Object> get props => [context,tapArgs];
}

final class OrionDiamondChartTouchInteractionDownEvent extends OrionEvent {
  final BuildContext context;
  final ChartTouchInteractionArgs tapArgs;

  const OrionDiamondChartTouchInteractionDownEvent({required this.context,required this.tapArgs});

  @override
  List<Object> get props => [context,tapArgs];
}

final class OrionDiamondChartTouchInteractionMoveEvent extends OrionEvent {
  final ChartTouchInteractionArgs tapArgs;

  const OrionDiamondChartTouchInteractionMoveEvent({required this.tapArgs});

  @override
  List<Object> get props => [tapArgs];
}

final class OrionDiamondUpdatePinPositionEvent extends OrionEvent {
  final BuildContext context;
  final DragUpdateDetails dragUpdateDetails;

  const OrionDiamondUpdatePinPositionEvent({required this.context,required this.dragUpdateDetails});

  @override
  List<Object> get props => [context, dragUpdateDetails];
}

final class OrionDiamondSnapNearestPoint extends OrionEvent {
  final BuildContext context;
  const OrionDiamondSnapNearestPoint({required this.context});

  @override
  List<Object> get props => [context];
}

class OrionChangeListingTypeEvent extends OrionEvent {
  const OrionChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

class OrionListLoadMoreEvent extends OrionEvent {
  final BuildContext context;
  final int currentPage;

  const OrionListLoadMoreEvent(this.context, this.currentPage);

  @override
  List<Object> get props => [context, currentPage];
}

class OrionDiamondOnPointTapEvent extends OrionEvent {
  final BuildContext context;
  final int index;
  final ChartPointDetails pointDetails;

  const OrionDiamondOnPointTapEvent({required this.context,required this.index, required this.pointDetails});

  @override
  List<Object> get props => [context, index, pointDetails];
}
