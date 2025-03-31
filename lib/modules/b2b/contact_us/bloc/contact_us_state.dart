part of 'contact_us_bloc.dart';

sealed class ContactUsState extends Equatable {
  const ContactUsState();
}

final class ContactUsInitial extends ContactUsState {
  @override
  List<Object> get props => [];
}

final class ContactUsChangeInquiryTypeState extends ContactUsState {
  const ContactUsChangeInquiryTypeState();

  @override
  List<Object> get props => [];
}

final class ContactUsChangeSelectProductState extends ContactUsState {
  const ContactUsChangeSelectProductState();

  @override
  List<Object> get props => [];
}

final class ContactUsReloadState extends ContactUsState {
  const ContactUsReloadState();

  @override
  List<Object> get props => [];
}

final class ContactUsSubmitState extends ContactUsState {
  const ContactUsSubmitState();

  @override
  List<Object> get props => [];
}

final class ContactUsFieldValidationState extends ContactUsState {
  final FieldTypeValidationEnum fieldType;

  const ContactUsFieldValidationState({required this.fieldType});

  @override
  List<Object?> get props => [fieldType];
}

final class ContactUsAddRemoveContactState extends ContactUsState {
  final bool isRemove;
  final int index;
  final Country country;

  const ContactUsAddRemoveContactState({this.isRemove = false, required this.index, required this.country});

  @override
  List<Object> get props => [
    isRemove,
    index,
    country,
  ];
}

final class ContactUsChangeCountryCodeState extends ContactUsState {
  final Country country;

  const ContactUsChangeCountryCodeState({required this.country});

  @override
  List<Object> get props => [country];
}

final class ContactUsPhoneNumberValidationState extends ContactUsState {
  final ValidationFieldType phoneNumberValidationFieldType;
  final bool isError;
  final String? errorMessage;

  const ContactUsPhoneNumberValidationState({
    required this.phoneNumberValidationFieldType,
    required this.isError,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [phoneNumberValidationFieldType, isError, errorMessage];
}