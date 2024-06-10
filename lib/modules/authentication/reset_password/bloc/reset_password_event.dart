part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

final class ResetPasswordInitialEvent extends ResetPasswordEvent {
  const ResetPasswordInitialEvent();

  @override
  List<Object> get props => [];
}

final class ResetPasswordChangedEvent extends ResetPasswordEvent {
  final String newPassword;

  const ResetPasswordChangedEvent(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

final class ResetPasswordConfirmChangedEvent extends ResetPasswordEvent {
  final String confirmPassword;

  const ResetPasswordConfirmChangedEvent(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}
