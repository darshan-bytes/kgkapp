part of 'setting_detail_bloc.dart';

sealed class SettingDetailEvent extends Equatable {
  const SettingDetailEvent();
}

class SettingToggleEvent extends SettingDetailEvent {
  const SettingToggleEvent();

  @override
  List<Object> get props => [];
}

class SettingDiamondDetailsToggleEvent extends SettingDetailEvent {
  const SettingDiamondDetailsToggleEvent();

  @override
  List<Object> get props => [];
}

final class MetalCustomizationChangeEvent extends SettingDetailEvent {
  final int index;

  const MetalCustomizationChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}
