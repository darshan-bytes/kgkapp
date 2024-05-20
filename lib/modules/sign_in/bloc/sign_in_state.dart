part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();
}

final class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

final class ChangeValueState extends SignInState {
  const ChangeValueState();

  @override
  List<Object> get props => [];
}

final class SignInReloadState extends SignInState {
  const SignInReloadState();

  @override
  List<Object> get props => [];
}
