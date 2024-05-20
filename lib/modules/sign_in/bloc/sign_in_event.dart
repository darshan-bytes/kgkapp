part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();
}

class ChangeSwitchValueEvent extends SignInEvent {
  final bool switchValue;

  const ChangeSwitchValueEvent({required this.switchValue});

  @override
  List<Object> get props => [switchValue];
}
