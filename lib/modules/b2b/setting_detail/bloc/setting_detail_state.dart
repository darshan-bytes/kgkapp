part of 'setting_detail_bloc.dart';

sealed class SettingDetailState extends Equatable {
  const SettingDetailState();
}

final class SettingDetailInitial extends SettingDetailState {
  @override
  List<Object> get props => [];
}

final class SettingDetailLoadedState extends SettingDetailState {
  const SettingDetailLoadedState();

  @override
  List<Object> get props => [];
}

final class SettingToggleState extends SettingDetailState {
  final bool isSettingOpen;

  const SettingToggleState(this.isSettingOpen);

  @override
  List<Object> get props => [isSettingOpen];
}

final class SettingDiamondToggleState extends SettingDetailState {
  final bool isDiamondDetailsOpen;

  const SettingDiamondToggleState(this.isDiamondDetailsOpen);

  @override
  List<Object> get props => [isDiamondDetailsOpen];
}

final class MetalCustomizationChangeState extends SettingDetailState {
  final int index;
  final int previousIndex;

  const MetalCustomizationChangeState(this.index, this.previousIndex);

  @override
  List<Object> get props => [index, previousIndex];
}
