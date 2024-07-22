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

class SignInButtonPressedEvent extends SignInEvent {
  final BuildContext context;

  const SignInButtonPressedEvent({required this.context});

  @override
  List<Object> get props => [context];
}
