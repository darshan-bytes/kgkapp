part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();
}

final class SignInInitialEvent extends SignInEvent {
  final BuildContext context;

  const SignInInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

class SignInButtonPressedEvent extends SignInEvent {
  final BuildContext context;

  const SignInButtonPressedEvent({required this.context});

  @override
  List<Object> get props => [context];
}
