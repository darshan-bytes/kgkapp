part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSubmitEvent extends ForgotPasswordEvent {
  final BuildContext context;

  const ForgotPasswordSubmitEvent({required this.context});

  @override
  List<Object> get props => [];
}
