import 'package:kgk/kgk.dart';

part 'qr_code_scan_login_event.dart';

part 'qr_code_scan_login_state.dart';

class QrCodeScanLoginBloc extends Bloc<QrCodeScanLoginEvent, QrCodeScanLoginState> {
  MobileScannerController mobileScannerController = MobileScannerController(autoStart: true);

  QrCodeScanLoginBloc() : super(QrCodeScanLoginInitial()) {
    on<QrCodeScanLoginStopEvent>(_onQrCodeScanLoginStopEvent);
  }

  // On Qr Code Scan Login
  Future<void> _onQrCodeScanLoginStopEvent(QrCodeScanLoginStopEvent event, Emitter<QrCodeScanLoginState> emit) async {
    mobileScannerController.stop();

    if (event.barcode != null) {
      Utils.showQrAuthLoadingDialog(event.context);
      await verifyQrCodeForAuth(event.context, emit, event.barcode!.barcodes.first.displayValue!);
    }
    emit(QrCodeScanLoginResult(barcode: event.barcode));
  }

  // Verify Qr Code for Auth
  Future<void> verifyQrCodeForAuth(BuildContext context, Emitter<QrCodeScanLoginState> emit, String code) async {
    if (code.isNotNullNorEmpty) {
      String deviceId = await getDeviceId() ?? '';
      Map<String, dynamic> params = {ApiKey.qrToken: code, ApiKey.deviceId: deviceId};

      await UserRepository(context).verifyQrCodeForAuth(params).then((value) async {
        await value?.fold((l) {
          ErrorResponse errorModel = l;
          Utils.showMessage(errorModel.message ?? '');
          emit(QrCodeScanLoginError(errorMessage: errorModel.message ?? ''));
        }, (r) async {
          context.popUntil((route) => (route.settings.name == AppRoutes.landingPage));
        });
      });
    }
  }

  @override
  Future<void> close() {
    mobileScannerController.dispose();
    return super.close();
  }

  // Get Device Id for Qr
  Future<String?> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      var androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    }
    return null;
  }
}
