part of 'otp_verification_bloc.dart';

sealed class OtpVerificationState extends Equatable {
  const OtpVerificationState();
}

final class OtpVerificationInitialState extends OtpVerificationState {
  const OtpVerificationInitialState();

  @override
  List<Object> get props => [];
}

final class OtpVerificationReloadState extends OtpVerificationState {
  const OtpVerificationReloadState();

  @override
  List<Object> get props => [];
}

final class OtpVerificationErrorChangedState extends OtpVerificationState {
  const OtpVerificationErrorChangedState();

  @override
  List<Object> get props => [];
}

final class OtpVerificationTimerState extends OtpVerificationState {
  const OtpVerificationTimerState();

  @override
  List<Object?> get props => [];
}

final class OtpVerificationDataLoadedState extends OtpVerificationState {
  const OtpVerificationDataLoadedState();

  @override
  List<Object?> get props => [];
}
