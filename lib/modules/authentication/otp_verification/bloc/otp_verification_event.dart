part of 'otp_verification_bloc.dart';

sealed class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();
}

final class OtpVerificationInitialEvent extends OtpVerificationEvent {
  final BuildContext context;

  const OtpVerificationInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class OtpVerificationOtpChangedEvent extends OtpVerificationEvent {
  const OtpVerificationOtpChangedEvent();

  @override
  List<Object> get props => [];
}

final class OtpVerificationVerifyEvent extends OtpVerificationEvent {
  final BuildContext context;

  const OtpVerificationVerifyEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class OtpVerificationResendCodeEvent extends OtpVerificationEvent {
  final BuildContext context;

  const OtpVerificationResendCodeEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class OtpVerificationTimerEvent extends OtpVerificationEvent {
  final int remainingTime;

  const OtpVerificationTimerEvent({required this.remainingTime});

  @override
  List<Object> get props => [remainingTime];
}
