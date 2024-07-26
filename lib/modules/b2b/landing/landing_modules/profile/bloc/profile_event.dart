part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class InitialProfileListEvent extends ProfileEvent {
  final BuildContext context;

  const InitialProfileListEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class ToggleProfileListEvent extends ProfileEvent {
  final int index;
  final BuildContext context;

  const ToggleProfileListEvent({required this.index, required this.context});

  @override
  List<Object?> get props => [index, context];
}

final class LogoutEvent extends ProfileEvent {
  final BuildContext context;

  const LogoutEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class DeleteProfileEvent extends ProfileEvent {
  final BuildContext context;

  const DeleteProfileEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
