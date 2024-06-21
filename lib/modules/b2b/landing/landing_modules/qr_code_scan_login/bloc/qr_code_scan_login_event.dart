part of 'qr_code_scan_login_bloc.dart';

sealed class QrCodeScanLoginEvent extends Equatable {
  const QrCodeScanLoginEvent();
}

final class QrCodeScanLoginStopEvent extends QrCodeScanLoginEvent {
  final BarcodeCapture? barcode;
  final BuildContext context;

  const QrCodeScanLoginStopEvent({this.barcode, required this.context});

  @override
  List<Object?> get props => [barcode, context];
}
