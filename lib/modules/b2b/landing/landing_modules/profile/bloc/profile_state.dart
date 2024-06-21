part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileReloadState extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ToggleProfileState extends ProfileState {
  const ToggleProfileState();

  @override
  List<Object> get props => [];
}
