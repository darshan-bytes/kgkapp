part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class InitialProfileListEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

final class ToggleProfileListEvent extends ProfileEvent {
  final int index;

  const ToggleProfileListEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
