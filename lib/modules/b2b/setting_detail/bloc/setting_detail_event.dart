part of 'setting_detail_bloc.dart';

sealed class SettingDetailEvent extends Equatable {
  const SettingDetailEvent();
}

class SettingToggleEvent extends SettingDetailEvent {
  final bool isSettingOpen;

  const SettingToggleEvent({required this.isSettingOpen});

  @override
  List<Object> get props => [isSettingOpen];
}

class SettingImagePageChangeEvent extends SettingDetailEvent {
  final int index;

  const SettingImagePageChangeEvent({required this.index});

  @override
  List<Object> get props => [index];
}
