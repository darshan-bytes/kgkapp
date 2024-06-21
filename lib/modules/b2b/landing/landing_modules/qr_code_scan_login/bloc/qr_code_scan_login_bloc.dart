import 'package:kgk/kgk.dart';

part 'qr_code_scan_login_event.dart';

part 'qr_code_scan_login_state.dart';

class QrCodeScanLoginBloc extends Bloc<QrCodeScanLoginEvent, QrCodeScanLoginState> {
  MobileScannerController mobileScannerController = MobileScannerController(autoStart: true);

  QrCodeScanLoginBloc() : super(QrCodeScanLoginInitial()) {
    on<QrCodeScanLoginStopEvent>(_onQrCodeScanLoginStopEvent);
  }

  Future<void> _onQrCodeScanLoginStopEvent(QrCodeScanLoginStopEvent event, Emitter<QrCodeScanLoginState> emit) async {
    mobileScannerController.stop();

    event.context.pop();
    if (event.barcode != null) {
      Utils.showMessage('Barcode Data: ${event.barcode?.barcodes.first.displayValue}');
    }
    emit(QrCodeScanLoginResult(barcode: event.barcode));
  }

  @override
  Future<void> close() {
    mobileScannerController.dispose();
    return super.close();
  }
}
