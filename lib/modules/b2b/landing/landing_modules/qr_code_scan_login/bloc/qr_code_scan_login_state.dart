part of 'qr_code_scan_login_bloc.dart';

sealed class QrCodeScanLoginState extends Equatable {
  const QrCodeScanLoginState();
}

final class QrCodeScanLoginInitial extends QrCodeScanLoginState {
  @override
  List<Object> get props => [];
}

final class QrCodeScanLoginResult extends QrCodeScanLoginState {
  final BarcodeCapture? barcode;

  const QrCodeScanLoginResult({this.barcode});

  @override
  List<Object?> get props => [barcode];
}

final class QrCodeScanLoginError extends QrCodeScanLoginState {
  final String errorMessage;

  const QrCodeScanLoginError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
