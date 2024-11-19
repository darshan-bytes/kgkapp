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

final class EditProfileChangeCountryCodeState extends ProfileState {
  final Country country;

  const EditProfileChangeCountryCodeState({required this.country});

  @override
  List<Object> get props => [country];
}

final class EditProfilePhoneNumberValidationState extends ProfileState {
  final ValidationFieldType phoneNumberValidationFieldType;
  final bool isError;

  const EditProfilePhoneNumberValidationState({required this.phoneNumberValidationFieldType, required this.isError});

  @override
  List<Object> get props => [phoneNumberValidationFieldType, isError];
}
