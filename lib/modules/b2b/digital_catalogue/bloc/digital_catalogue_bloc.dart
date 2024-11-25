import 'package:kgk/kgk.dart';

part 'digital_catalogue_event.dart';

part 'digital_catalogue_state.dart';

class DigitalCatalogueBloc extends Bloc<DigitalCatalogueEvent, DigitalCatalogueState> {
  bool _isInitialised = false;

  final TextEditingController searchController = TextEditingController();
  List<DigitalCatalogueListingModel> digitalCatalogueList = [];

  SmartPaginationScrollController digitalCatalogueScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  int? totalNumberOfPages;

  DigitalCatalogueBloc() : super(DigitalCatalogueIntial()) {
    on<DigitalCatalogueInitialEvent>(_onDashboardInitialEvent);
    on<DigitalCataloguePullToRefreshEvent>(_digitalCataloguePullToRefresh);
    on<DigitalCatalogueLoadMoreEvent>(_onDigitalCatalogueLoadMore);
    on<DigitalCatalogueSearchEvent>(_onDigitalCatalogueSearch, transformer: BlocEventDeBouncer.debounceTransformer());
  }

  Future<void> _onDashboardInitialEvent(DigitalCatalogueInitialEvent event, Emitter<DigitalCatalogueState> emit) async {
    if (_isInitialised) return;
    _isInitialised = true;
    emit(const DigitalCatalogueReloadState());
    digitalCatalogueList.clear();
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    if (digitalCatalogueScrollController.isInitialised) {
      digitalCatalogueScrollController.dispose();
      digitalCatalogueScrollController = SmartPaginationScrollController();
    }
    digitalCatalogueScrollController.init(
      loadAction: (int currentPage) async {
        add(DigitalCatalogueLoadMoreEvent(context: event.context, currentPage: currentPage));
      },
    );

    await fetchDigitalCatalogueList(event.context);
    refreshCompleter.complete(true);

    emit(const DigitalCatalogueLoadedState());
  }

  Future<void> _digitalCataloguePullToRefresh(DigitalCataloguePullToRefreshEvent event, Emitter<DigitalCatalogueState> emit) async {
    digitalCatalogueScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));

    refreshCompleter.complete(true);
    emit(const DigitalCatalogueLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const DigitalCataloguePullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }

  Future<void> fetchDigitalCatalogueList(
    BuildContext context, {
    int page = 1,
    bool isLoadMore = false,
  }) async {
    final Map<String, dynamic> body = {
      ApiKey.filters: {
        ApiKey.dynamicObject: {},
      },
      ApiKey.pagination: {
        ApiKey.page: page,
        ApiKey.limit: AppConst.pageLimit,
      },
      ApiKey.search: searchController.text,
      ApiKey.sort: {
        ApiKey.field: 'id',
        ApiKey.dir: 'DESC',
      },
    };

    final response = await AppRepository(context).digitalCatalogueFilters(body: body, isLoadMore: isLoadMore);
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        r.totalRecords ??= 0;
        r.filteredRecords ??= 0;
        totalNumberOfPages = Utils.calculateTotalPages(r.filteredRecords, AppConst.pageLimit);

        if ((r.dataList as List<DigitalCatalogueDetails>).isNotNullNorEmpty) {
          digitalCatalogueList.addAll(List.generate(r.dataList!.length, (index) {
            DigitalCatalogueDetails digitalCatalogueDetails = r.dataList![index];
            return DigitalCatalogueListingModel(
              id: digitalCatalogueDetails.id,
              name: digitalCatalogueDetails.name,
              description: digitalCatalogueDetails.cscCode,
              image: digitalCatalogueDetails.catalogueCoverImage?.setMediaUrl,
              productCount: digitalCatalogueDetails.products.length.toString(),
              date: digitalCatalogueDetails.updatedAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
              isWebView: false,
              webUrl: null,
            );
          }));
        }

        digitalCatalogueScrollController.isPageLoaded.complete(page == totalNumberOfPages);
      },
    );
  }

  Future<void> _onDigitalCatalogueLoadMore(DigitalCatalogueLoadMoreEvent event, Emitter<DigitalCatalogueState> emit) async {
    emit(const DigitalCatalogueLoadingMoreState());
    await fetchDigitalCatalogueList(event.context, page: event.currentPage, isLoadMore: true);
    emit(const DigitalCatalogueLoadMoreState());
  }

  Future<void> _onDigitalCatalogueSearch(DigitalCatalogueSearchEvent event, Emitter<DigitalCatalogueState> emit) async {
    emit(const DigitalCatalogueReloadState());
    digitalCatalogueList.clear();
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    digitalCatalogueScrollController.pullToRefresh();

    await fetchDigitalCatalogueList(event.context);
    refreshCompleter.complete(true);

    emit(const DigitalCatalogueLoadedState());
  }
}
