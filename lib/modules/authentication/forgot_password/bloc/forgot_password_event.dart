part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitialEvent extends ForgotPasswordEvent {
  const ForgotPasswordInitialEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordSubmitEvent extends ForgotPasswordEvent {
  final BuildContext context;

  final bool isFromResend;

  const ForgotPasswordSubmitEvent({required this.context, this.isFromResend = false});

  @override
  List<Object> get props => [context, isFromResend];
}
