part of 'setting_detail_bloc.dart';

sealed class SettingDetailState extends Equatable {
  const SettingDetailState();
}

final class SettingDetailInitial extends SettingDetailState {
  @override
  List<Object> get props => [];
}

final class SettingToggleState extends SettingDetailState {
  @override
  List<Object> get props => [];
}

final class SettingImagePageChangeState extends SettingDetailState {
  @override
  List<Object> get props => [];
}
