import 'package:kgk/kgk.dart';

part 'digital_catalogue_event.dart';

part 'digital_catalogue_state.dart';

class DigitalCatalogueBloc extends Bloc<DigitalCatalogueEvent, DigitalCatalogueState> {
  List<DigitalCatalogueListingModel> digitalCatalogueList = [];

  SmartPaginationScrollController digitalCatalogueScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  DigitalCatalogueBloc() : super(DigitalCatalogueIntial()) {
    on<DigitalCatalogueInitialEvent>(_onDashboardInitialEvent);
    on<DigitalCataloguePullToRefreshEvent>(_digitalCataloguePullToRefresh);
  }

  void _onDashboardInitialEvent(DigitalCatalogueInitialEvent event, Emitter<DigitalCatalogueState> emit) {
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
      loadAction: (int currentPage) async {},
    );

    digitalCatalogueList = List.generate(
      20,
      (index) {
        return DigitalCatalogueListingModel(
          id: index,
          name: index.remainder(2) == 0 ? 'Timeless radiance' : 'Gilded whispers',
          description: index.remainder(2) == 0
              ? 'Step  into a world of "Timeless Radiance" where elegance meets brilliance. Embrace the allure of exquisite jewelry that illuminates every moment with its captivating charm. Our carefully curated collection features shimmering diamonds, lustrous metals, and intricate designs, crafted to celebrate cherished memories and create enduring moments of beauty and splendor.'
              : 'Step into a world of "Gilded Whispers" where elegance meets brilliance. Embrace the allure of exquisite jewelry that illuminates every moment with its captivating charm. Our carefully curated collection features shimmering diamonds, lustrous metals, and intricate designs, crafted to celebrate cherished memories and create enduring moments of beauty and splendor.',
          image: index.remainder(2) == 0 ? 'https://i.ibb.co/8BMpdhW/Image.png' : 'https://i.ibb.co/n7SrRv7/Image.png',
          productCount: "32",
          date: "24/03/2023, 06:00 PM",
          isWebView: index.remainder(2) != 0,
          webUrl: index.remainder(2) != 0 ? 'https://www.kgkgroup.com/gemstones/' : null,
        );
      },
    );
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
}
