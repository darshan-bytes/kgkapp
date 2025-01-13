part of 'orion_bloc.dart';

sealed class OrionState extends Equatable {
  const OrionState();
}

final class OrionInitial extends OrionState {
  const OrionInitial();

  @override
  List<Object> get props => [];
}

final class OrionLoadedState extends OrionState {
  const OrionLoadedState();

  @override
  List<Object> get props => [];
}

final class OrionReloadedState extends OrionState {
  const OrionReloadedState();

  @override
  List<Object> get props => [];
}

final class OrionPriceRangeChangedState extends OrionState {
  const OrionPriceRangeChangedState();

  @override
  List<Object> get props => [];
}

final class OrionDiamondShapeChangedState extends OrionState {
  final int oldIndex;
  final int newIndex;

  const OrionDiamondShapeChangedState(this.oldIndex, this.newIndex);

  @override
  List<Object> get props => [oldIndex, newIndex];
}

final class OrionDiamondCutChangedState extends OrionState {
  final int diamondPropertiesIndex;
  final int propertiesIndex;

  const OrionDiamondCutChangedState(this.diamondPropertiesIndex, this.propertiesIndex);

  @override
  List<Object> get props => [diamondPropertiesIndex, propertiesIndex];
}

final class OrionDiamondMovedState extends OrionState {
  const OrionDiamondMovedState();

  @override
  List<Object> get props => [];
}

class OrionChangeListingTypeState extends OrionState {
  @override
  List<Object> get props => [];
}

final class OrionProductReloadState extends OrionState {
  @override
  List<Object> get props => [];
}

final class OrionDiamondListLoadedState extends OrionState {
  const OrionDiamondListLoadedState();

  @override
  List<Object> get props => [];
}

final class OrionProductLoadedState extends OrionState {
  const OrionProductLoadedState();

  @override
  List<Object> get props => [];
}

final class OrionListLoadingMoreState extends OrionState {
  @override
  List<Object> get props => [];
}

final class OrionListLoadedMoreState extends OrionState {
  final int currentPage;

  const OrionListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
