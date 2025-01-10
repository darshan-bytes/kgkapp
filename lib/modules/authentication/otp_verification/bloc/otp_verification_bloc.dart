import 'package:kgk/kgk.dart';

part 'otp_verification_event.dart';

part 'otp_verification_state.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final TextEditingController otpController = TextEditingController();
  String? otpError;

  final Duration _resendOtpDuration = const Duration(seconds: 60);
  Timer? _resendOtpTimer;
  int _remainingTime = 60;
  String? displayDuration;

  String? _email;

  bool isFromSignIn = false;

  OtpVerificationBloc() : super(const OtpVerificationInitialState()) {
    on<OtpVerificationInitialEvent>(_onOtpVerificationInitialEvent);
    on<OtpVerificationOtpChangedEvent>(_onOtpVerificationOtpChangedEvent);
    on<OtpVerificationVerifyEvent>(_onOtpVerificationVerifyEvent);
    on<OtpVerificationResendCodeEvent>(_onOtpVerificationResendCodeEvent);
    on<OtpVerificationTimerEvent>(_onOtpVerificationTimerEvent);
  }

  void _onOtpVerificationInitialEvent(OtpVerificationInitialEvent event, Emitter<OtpVerificationState> emit) {
    _getDataFromRoutes(event.context);
    emit(OtpVerificationDataLoadedState());
    if (isFromSignIn) {
      add(OtpVerificationResendCodeEvent(event.context));
    }
  }

  void _onOtpVerificationOtpChangedEvent(OtpVerificationOtpChangedEvent event, Emitter<OtpVerificationState> emit) {
    emit(const OtpVerificationReloadState());
    otpError = null;
    emit(const OtpVerificationErrorChangedState());
  }

  Future<void> _onOtpVerificationVerifyEvent(OtpVerificationVerifyEvent event, Emitter<OtpVerificationState> emit) async {
    emit(const OtpVerificationReloadState());
    if (_validateField(emit)) {
      Map<String, dynamic> body = {
        ApiKey.email: _email,
        ApiKey.otpPasscode: otpController.text.trim(),
      };
      final response = await UserRepository(event.context).verifyEmailOtp(body: body);

      await response?.fold(
        (l) {
          Utils.showMessage(l.message);
        },
        (r) async {
          Utils.showMessage(r.message);
          await Utils.handleAuthSuccessResponse(event.context, r.responseData);
        },
      );
    }
  }

  Future<void> _onOtpVerificationResendCodeEvent(OtpVerificationResendCodeEvent event, Emitter<OtpVerificationState> emit) async {
    Map<String, dynamic> body = {ApiKey.email: _email};
    otpController.clear();
    final response = await UserRepository(event.context).resendEmailOtp(body: body);
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        Utils.showMessage(r.message);
        _startTimer();
      },
    );
  }

  void _onOtpVerificationTimerEvent(OtpVerificationTimerEvent event, Emitter<OtpVerificationState> emit) {
    emit(const OtpVerificationReloadState());
    emit(const OtpVerificationTimerState());
  }

  void _getDataFromRoutes(BuildContext context) {
    final routesData = context.routesData;
    _email = routesData?[RoutesData.email] as String?;
    isFromSignIn = routesData?[RoutesData.isFromSignIn] as bool? ?? false;
  }

  void _startTimer() {
    _remainingTime = _resendOtpDuration.inSeconds;

    _resendOtpTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // Decrement the remaining time
        _remainingTime--;
        Duration remainingDuration = Duration(seconds: _remainingTime);
        String minutes = remainingDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
        String seconds = remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0');
        displayDuration = "$minutes:$seconds";

        // Stop the timer when time runs out
        if (_remainingTime <= 0) {
          displayDuration = null;
          _resendOtpTimer?.cancel();
        }
        // Trigger event with the updated time
        if (!isClosed) {
          add(OtpVerificationTimerEvent(remainingTime: _remainingTime));
        }
      },
    );
  }

  @override
  Future<void> close() async {
    _resendOtpTimer?.cancel();
    return super.close();
  }

  bool _validateField(Emitter<OtpVerificationState> emit) {
    if (otpController.text.trim().isEmpty) {
      otpError = APPStrings.otpRequired.tr;
      emit(const OtpVerificationErrorChangedState());
      return false;
    } else if (otpController.text.trim().length != 6) {
      otpError = APPStrings.otpLength.tr;
      emit(const OtpVerificationErrorChangedState());
      return false;
    }
    return true;
  }
}
