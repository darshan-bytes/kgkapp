part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSubmitEvent extends ForgotPasswordEvent {
  const ForgotPasswordSubmitEvent();

  @override
  List<Object> get props => [];
}
