part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordError extends ForgotPasswordState {
  final String error;

  const ForgotPasswordError({required this.error});
}

class ForgotPasswordSent extends ForgotPasswordState {}
