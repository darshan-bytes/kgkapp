part of 'setting_detail_bloc.dart';

sealed class SettingDetailEvent extends Equatable {
  const SettingDetailEvent();
}

final class SettingDetailInitialEvent extends SettingDetailEvent {
  final BuildContext context;

  const SettingDetailInitialEvent({required this.context});

  @override
  List<Object> get props => [context];
}
