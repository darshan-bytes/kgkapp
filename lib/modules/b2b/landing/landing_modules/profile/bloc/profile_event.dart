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

final class EditProfileChangeCountryCodeEvent extends ProfileEvent {
  final BuildContext context;
  final Country country;

  const EditProfileChangeCountryCodeEvent({
    required this.context,
    required this.country,
  });

  @override
  List<Object> get props => [context, country];
}

final class EditProfileSaveEvent extends ProfileEvent {
  final BuildContext context;

  const EditProfileSaveEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class EditProfilePhoneNumberValidationEvent extends ProfileEvent {
  final BuildContext context;
  final String phoneNumber;

  const EditProfilePhoneNumberValidationEvent({required this.context, required this.phoneNumber});

  @override
  List<Object> get props => [context, phoneNumber];
}

final class ChangePasswordEvent extends ProfileEvent {
  final BuildContext context;

  const ChangePasswordEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class EditProfileFieldChangeEvent extends ProfileEvent {
  final FieldTypeValidationEnum fieldType;

  const EditProfileFieldChangeEvent({required this.fieldType});

  @override
  List<Object> get props => [fieldType];
}

final class ChangePasswordFieldChangeEvent extends ProfileEvent {
  final FieldTypeValidationEnum fieldType;

  const ChangePasswordFieldChangeEvent({required this.fieldType});

  @override
  List<Object> get props => [fieldType];
}

final class ProfilePickImageEvent extends ProfileEvent {
  final ImageSource imageSource;

  const ProfilePickImageEvent({required this.imageSource});

  @override
  List<Object> get props => [imageSource];
}

final class RemoveProfileImageEvent extends ProfileEvent {
  const RemoveProfileImageEvent();

  @override
  List<Object> get props => [];
}
