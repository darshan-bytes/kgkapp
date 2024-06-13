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

  const ToggleProfileListEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
