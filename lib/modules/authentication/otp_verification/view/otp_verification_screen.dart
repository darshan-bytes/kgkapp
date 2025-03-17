import 'package:kgk/kgk.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).signInScreenStyle;
    final OtpVerificationBloc bloc = BlocProvider.of<OtpVerificationBloc>(context);
    return BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
      buildWhen: (previous, current) => current is OtpVerificationDataLoadedState,
      builder: (context, state) {
        if (state is! OtpVerificationDataLoadedState) {
          return const SizedBox.shrink();
        }
        return Scaffold(
          appBar: SmartAppBar(
            appBarHeight: 52.h,
            isBorder: false,
            backgroundColor: style.backgroundColor,
          ),
          body: SafeArea(
            child: SmartSingleChildScrollView(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SmartText(
                    APPStrings.verifyYourAccount.tr,
                    style: style.titleTextStyle,
                  ),
                  SmartText(
                    APPStrings.verifyYourAccountDesc.tr,
                    style: style.subTitleStyle,
                  ),
                  SizedBox(height: 32.h),
                  _buildOtpField(context, style, bloc),
                  SizedBox(height: 16.h),
                  _buildResendCodeText(context, style, bloc),
                  SizedBox(height: 16.h),
                  _buildVerifyButton(context, bloc),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpField(BuildContext context, SignInScreenStyle style, OtpVerificationBloc bloc) {
    return BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
      buildWhen: (previous, current) => current is OtpVerificationErrorChangedState,
      builder: (context, state) {
        return SmartTextField(
          labelText: APPStrings.otp.tr,
          controller: bloc.otpController,
          obscured: true,
          textInputAction: TextInputAction.done,
          errorText: bloc.otpError,
          maxLength: 6,
          textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          onValueChanges: (value) {
            if (bloc.otpError.isNotNullNorEmpty) {
              bloc.add(OtpVerificationOtpChangedEvent());
            }
          },
        );
      },
    );
  }

  Widget _buildResendCodeText(BuildContext context, SignInScreenStyle style, OtpVerificationBloc bloc) {
    return BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
      buildWhen: (previous, current) => current is OtpVerificationTimerState,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            bloc.add(OtpVerificationResendCodeEvent(context));
          },
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: SmartText(
              bloc.displayDuration ?? APPStrings.resendCode.tr,
              style: style.forgotPasswordStyle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildVerifyButton(BuildContext context, OtpVerificationBloc bloc) {
    return SmartButton(
      onTap: () {
        bloc.add(OtpVerificationVerifyEvent(context));
      },
      title: APPStrings.verify.tr,
    );
  }
}
