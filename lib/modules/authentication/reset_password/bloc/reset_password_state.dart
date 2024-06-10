part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();
}

final class ResetPasswordInitialState extends ResetPasswordState {
  @override
  List<Object?> get props => [];
}

final class ResetPasswordChangedState extends ResetPasswordState {
  final bool isFormFilled;
  final bool isNotEmpty;

  const ResetPasswordChangedState(this.isFormFilled, this.isNotEmpty);

  @override
  List<Object> get props => [isFormFilled, isNotEmpty];
}

final class ResetPasswordConfirmChangedState extends ResetPasswordState {
  final bool isFormFilled;
  final bool isNotEmpty;

  const ResetPasswordConfirmChangedState(this.isFormFilled, this.isNotEmpty);

  @override
  List<Object> get props => [isFormFilled, isNotEmpty];
}
