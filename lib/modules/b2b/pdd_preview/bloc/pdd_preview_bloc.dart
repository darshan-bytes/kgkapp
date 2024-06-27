import 'package:kgk/kgk.dart';
part 'pdd_preview_event.dart';
part 'pdd_preview_state.dart';

class PddPreviewBloc extends Bloc<PddPreviewEvent, PddPreviewState> {
  String appbarTitle = '';
  late WebViewController webViewController;

  PddPreviewBloc() : super(InitialPddPreviewState()) {
    on<InitialPddPreviewEvent>(_onInitialPddListingEvent);
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      appbarTitle = data[RoutesData.presentationId] ?? '';
    }
  }

  void clearData() {
    appbarTitle = '';
  }

  void _onInitialPddListingEvent(InitialPddPreviewEvent event, Emitter<PddPreviewState> emit) {
    emit(PddPreviewReloadState());
    clearData();
    getRouteData(event.context);
    _onCmsWebViewInitialEvent();
    emit(PddPreviewLoadedState());
  }

  Future<void> _onCmsWebViewInitialEvent() async {
    String webviewUrl = "https://www.kgkgroup.com/";
    webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    if (webviewUrl.isNotNullNorEmpty) {
      await webViewController.loadRequest(Uri.parse(webviewUrl));
    }
  }
}
