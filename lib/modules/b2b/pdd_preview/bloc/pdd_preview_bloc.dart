import 'package:kgk/kgk.dart';
part 'pdd_preview_event.dart';
part 'pdd_preview_state.dart';

class PddPreviewBloc extends Bloc<PddPreviewEvent, PddPreviewState> {
  String appbarTitle = '';

  //For WebView
  late WebViewController webViewController;

  //For Version History
  List<PddVersionHistoryModel> versionHistoryList = [];

  //For Selected Version
  PddVersionHistoryModel? selectedversion;

  PddPreviewBloc() : super(InitialPddPreviewState()) {
    on<InitialPddPreviewEvent>(_onInitialPddListingEvent);
    on<VersionHistoryChangeEvent>(_onVersionHistoryChangeEvent);
    on<NavigateToPddVersionHistoryEvent>(_onNavigateToPddVersionHistoryEvent);
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
    versionHistoryList = List.generate(
            10,
            (index) => PddVersionHistoryModel(
                historyDateTime: DateFormat(DateFormatter.dateFormatDDMMMYYYY).format(DateTime.now().subtract(Duration(days: index + 1)))))
        .toList();
    selectedversion = versionHistoryList.first;
    emit(PddPreviewLoadedState());
  }

  Future<void> _onCmsWebViewInitialEvent() async {
    String webviewUrl = AppConst.pddPreviewWebViewURL;
    webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    if (webviewUrl.isNotNullNorEmpty) {
      await webViewController.loadRequest(Uri.parse(webviewUrl));
    }
  }

  void _onVersionHistoryChangeEvent(VersionHistoryChangeEvent event, Emitter<PddPreviewState> emit) {
    emit(PddPreviewReloadState());
    selectedversion = event.pddVersionHistoryModel;
    emit(PddPreviewChangePreviewTypeState());
  }

  void _onNavigateToPddVersionHistoryEvent(NavigateToPddVersionHistoryEvent event, Emitter<PddPreviewState> emit) {
    event.context.pushNamed(AppRoutes.presentationPreviewHistory);
  }
}
