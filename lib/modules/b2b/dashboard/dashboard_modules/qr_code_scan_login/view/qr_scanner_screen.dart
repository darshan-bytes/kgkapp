import 'package:kgk/kgk.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QrCodeScanLoginBloc qrCodeScanLoginBloc = BlocProvider.of<QrCodeScanLoginBloc>(context);
    final QrScannerStyle style = AppTheme.of(context).qrScannerStyle;
    return Scaffold(
      appBar: SmartAppBar(
        title: APPStrings.makeAnInquiry.tr,
        onBack: () {
          qrCodeScanLoginBloc.add(QrCodeScanLoginStopEvent(context: context));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SmartText(
            APPStrings.toLogInToSiteWithQr.tr,
            style: style.titleStyle,
            optionalPadding: EdgeInsets.all(16.w),
          ),
          Expanded(
            child: MobileScanner(
                controller: qrCodeScanLoginBloc.mobileScannerController,
                overlayBuilder: (context, overlay) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(color: style.overLayColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(height: 288.w, color: style.overLayColor),
                          ),
                          SmartImage(
                            path: AppImages.icQrScannerFrame,
                            width: 288.w,
                            height: 288.w,
                          ),
                          Expanded(
                            child: Container(height: 288.w, color: style.overLayColor),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(color: style.overLayColor),
                      ),
                    ],
                  );
                },
                onDetect: (barcode) {
                  qrCodeScanLoginBloc.add(QrCodeScanLoginStopEvent(barcode: barcode, context: context));
                },
                errorBuilder: (context, error, child) {
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    alignment: Alignment.center,
                    child: SmartText(error.toString()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
