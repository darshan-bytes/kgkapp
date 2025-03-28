import 'package:kgk/kgk.dart';

part 'cms_web_view_event.dart';

part 'cms_web_view_state.dart';

class CmsWebViewBloc extends Bloc<CmsWebViewEvent, CmsWebViewState> {
  late WebViewController webViewController;
  String appBarTitle = '';
  late AppBloc appBloc;

  CmsWebViewBloc() : super(CmsWebViewInitialState()) {
    on<CmsWebViewInitialEvent>(_onCmsWebViewInitialEvent);
  }

  Future<void> _onCmsWebViewInitialEvent(CmsWebViewInitialEvent event, Emitter<CmsWebViewState> emit) async {
    CmsWebViewDataModel? webViewData = event.context.routesData?[RoutesData.cmsPageData];
    appBloc = BlocProvider.of<AppBloc>(event.context);
    if (webViewData != null) {
      // For future development
      // if( webViewData.attribute.isNotNullNorEmpty) {
      //   await AppRepository(event.context).fetchStrapiDataFroAboutUs(webViewData.attribute);
      // }

      appBarTitle = webViewData.title ?? '';
      String url = webViewData.url ?? '';

      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) {
            event.context.setAppLoading(true);
          },
          onPageFinished: (url) {
            event.context.setAppLoading(false);
          },
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ));
      if (url.isNotNullNorEmpty) {
        await webViewController.loadRequest(Uri.parse(url));
        emit(CmsWebViewLoadedState(controller: webViewController));
      }
    }
  }
}
