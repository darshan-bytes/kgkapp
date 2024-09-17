part of 'signup_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
}

final class SignUpInitialEvent extends SignUpEvent {
  final BuildContext context;

  const SignUpInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class SignUpChangeAccountTypeEvent extends SignUpEvent {
  final BuildContext context;
  final bool isIndividual;

  const SignUpChangeAccountTypeEvent(this.context, this.isIndividual);

  @override
  List<Object> get props => [context, isIndividual];
}

final class SignUpChangeCountryCodeEvent extends SignUpEvent {
  final int index;
  final Country country;

  const SignUpChangeCountryCodeEvent({
    required this.index,
    required this.country,
  });

  @override
  List<Object> get props => [index, country];
}

final class SignUpChangeCountryEvent extends SignUpEvent {
  final Country country;

  const SignUpChangeCountryEvent(this.country);

  @override
  List<Object> get props => [country];
}

final class SignUpBusinessTypeChangedEvent extends SignUpEvent {
  final int index;
  final bool isSelected;

  const SignUpBusinessTypeChangedEvent(this.isSelected, this.index);

  @override
  List<Object> get props => [isSelected, index];
}

final class SignupAddContactEvent extends SignUpEvent {
  const SignupAddContactEvent();

  @override
  List<Object> get props => [];
}

final class SignUpRemoveContactEvent extends SignUpEvent {
  final int index;

  const SignUpRemoveContactEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class SignUpResetEvent extends SignUpEvent {
  const SignUpResetEvent();

  @override
  List<Object> get props => [];
}

final class SignUpChangeOfficeLocationEvent extends SignUpEvent {
  final OfficeLocation officeLocation;

  const SignUpChangeOfficeLocationEvent(this.officeLocation);

  @override
  List<Object> get props => [officeLocation];
}

final class SignUpSubmitEvent extends SignUpEvent {
  final BuildContext context;

  const SignUpSubmitEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class SignUpEmailValidationEvent extends SignUpEvent {
  final BuildContext context;
  final String email;

  const SignUpEmailValidationEvent({required this.context, required this.email});

  @override
  List<Object> get props => [context, email];
}

final class SignUpPhoneNumberValidationEvent extends SignUpEvent {
  final BuildContext context;
  final String phoneNumber;

  const SignUpPhoneNumberValidationEvent({required this.context, required this.phoneNumber});

  @override
  List<Object> get props => [context, phoneNumber];
}
