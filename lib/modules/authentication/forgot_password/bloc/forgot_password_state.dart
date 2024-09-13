part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

final class ForgotPasswordSuccessState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
