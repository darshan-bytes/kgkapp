part of 'signup_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
}

final class SignupInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

final class SignUpChangeAccountTypeState extends SignUpState {
  final bool isIndividual;

  const SignUpChangeAccountTypeState(this.isIndividual);

  @override
  List<Object> get props => [isIndividual];
}

final class SignUpChangeCountryCodeState extends SignUpState {
  final Country country;
  final int index;

  const SignUpChangeCountryCodeState({required this.country, required this.index});

  @override
  List<Object> get props => [country, index];
}

final class SignUpBusinessTypeChangedState extends SignUpState {
  final int index;
  final bool isSelected;

  const SignUpBusinessTypeChangedState(this.index, this.isSelected);

  @override
  List<Object> get props => [index, isSelected];
}

final class SignUpChangeCountryState extends SignUpState {
  final Country country;

  const SignUpChangeCountryState(this.country);

  @override
  List<Object> get props => [country];
}

final class SignUpAddRemoveContactState extends SignUpState {
  final bool isRemove;
  final int index;
  final Country country;

  const SignUpAddRemoveContactState({this.isRemove = false, required this.index, required this.country});

  @override
  List<Object> get props => [
        isRemove,
        index,
        country,
      ];
}

final class SignUpReloadState extends SignUpState {
  @override
  List<Object> get props => [];
}

final class SignUpChangeOfficeLocationState extends SignUpState {
  final OfficeLocation officeLocation;

  const SignUpChangeOfficeLocationState(this.officeLocation);

  @override
  List<Object> get props => [officeLocation];
}
