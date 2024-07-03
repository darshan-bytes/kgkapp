import 'package:kgk/kgk.dart';

part 'preview_catalogue_event.dart';

part 'preview_catalogue_state.dart';

class PreviewCatalogueBloc extends Bloc<PreviewCatalogueEvent, PreviewCatalogueState> {
  String title = '';
  DigitalCatalogueListingModel? digitalCatalogueListingModel;

  bool get isWebView => digitalCatalogueListingModel?.isWebView ?? false;

  List<int> pageList = [];
  int currentPage = 0;

  List<ProductDetails> productList = [];

  late WebViewController webViewController;

  bool isCommentVisible = false;

  int selectedCommentIndex = -1;

  late TextEditingController commentController;
  late FocusNode commentFocusNode;

  PreviewCatalogueBloc() : super(const PreviewCatalogueInitial()) {
    on<InitialPreviewCatalogueEvent>(_onInitialPreviewCatalogueEvent);
    on<PreviewCataloguePreviousNextPageEvent>(_onPreviewCataloguePreviousNextPageEvent);
    on<PreviewCatalogueCommentEvent>(_onPreviewCatalogueCommentEvent);
    on<PreviewCatalogueCommentProductSelectEvent>(_onPreviewCatalogueCommentProductSelectEvent);
  }

  void _onInitialPreviewCatalogueEvent(InitialPreviewCatalogueEvent event, Emitter<PreviewCatalogueState> emit) {
    if (event.context.routesData?[RoutesData.catalogueData] != null) {
      digitalCatalogueListingModel = event.context.routesData?[RoutesData.catalogueData];
      title = digitalCatalogueListingModel?.name ?? '';
      pageList = List.generate(3, (index) => index);
      if (isWebView) {
        webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
        if (digitalCatalogueListingModel?.webUrl.isNotNullNorEmpty == true) {
          webViewController.loadRequest(Uri.parse(digitalCatalogueListingModel?.webUrl ?? ''));
        }
      } else {
        commentController = TextEditingController();
        commentFocusNode = FocusNode();
        productList = List.generate(
          20,
          (index) => ProductDetails(
            imageUrl: index % 2 == 0
                ? "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png"
                : "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
            name: "Diamond Vine Ring in 18k Rose Gold",
            originalPrice: "\$5,000.00",
          ),
        );
      }
      emit(const PreviewCatalogueLoadedState());
    } else {
      emit(const PreviewCatalogueErrorState());
    }
  }

  void _onPreviewCataloguePreviousNextPageEvent(PreviewCataloguePreviousNextPageEvent event, Emitter<PreviewCatalogueState> emit) {
    emit(const PreviewCatalogueReloadState());
    if (event.isNext) {
      if (currentPage < pageList.length - 1) {
        currentPage++;
      }
    } else {
      if (currentPage > 0) {
        currentPage--;
      }
    }
    emit(PreviewCataloguePreviousNextPageState(event.isNext));
  }

  void _onPreviewCatalogueCommentEvent(PreviewCatalogueCommentEvent event, Emitter<PreviewCatalogueState> emit) {
    emit(const PreviewCatalogueReloadState());
    isCommentVisible = !isCommentVisible;
    if (!isCommentVisible) {
      commentFocusNode.unfocus();
    }
    emit(const PreviewCatalogueCommentState());
  }

  void _onPreviewCatalogueCommentProductSelectEvent(PreviewCatalogueCommentProductSelectEvent event, Emitter<PreviewCatalogueState> emit) {
    emit(const PreviewCatalogueReloadState());
    selectedCommentIndex = event.index;
    commentFocusNode.requestFocus();
    emit(const PreviewCatalogueCommentProductSelectState());
  }
}
