part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSubmitEvent extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordSubmitEvent({required this.email});

  @override
  List<Object> get props => [];
}
