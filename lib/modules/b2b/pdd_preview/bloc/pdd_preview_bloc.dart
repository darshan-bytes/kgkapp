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

  Future<void> _onInitialPddListingEvent(InitialPddPreviewEvent event, Emitter<PddPreviewState> emit) async {
    emit(PddPreviewReloadState());
    getRouteData(event.context);
    await _onCmsWebViewInitialEvent();
    emit(PddPreviewLoadedState());
  }

  Future<void> _onCmsWebViewInitialEvent() async {
    String webviewUrl = AppConst.pddPreviewWebViewURL;
    webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    if (webviewUrl.isNotNullNorEmpty) {
      await webViewController.loadRequest(Uri.parse(webviewUrl));
    }
  }
}
