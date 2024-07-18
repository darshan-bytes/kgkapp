import 'package:kgk/kgk.dart';

part 'auction_listing_event.dart';

part 'auction_listing_state.dart';

class AuctionListingBloc extends Bloc<AuctionListingEvent, AuctionListingState> {
  final TextEditingController auctionSearchController = TextEditingController();

  List<AuctionListModel> auctionList = [];

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  AuctionListingBloc() : super(AuctionListingInitialState()) {
    on<InitialAuctionListingEvent>(_onInitialAuctionListingEvent);
    on<AuctionListLoadMoreEvent>(_onAuctionListLoadMoreEvent);
    on<AuctionListPullToRefreshEvent>(_onAuctionListPullToRefresh);
  }

  void _onInitialAuctionListingEvent(InitialAuctionListingEvent event, Emitter<AuctionListingState> emit) {
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(AuctionListLoadMoreEvent(currentPage));
      },
    );
    clearData();
    auctionList = List.generate(
      20,
      (index) => AuctionListModel(
        id: index.toString(),
        imageUrl: "https://i.ibb.co/Rhgz539/image-224.png",
        name: "Diamond Vine Ring in 18k Gold",
        skuNo: "DERC03RDA",
        orderStatus: index == 0 ? ProjectStatus.onGoing : ProjectStatus.winner,
        bidAmount: "\$5000.00",
        bidPlacedOn: "23/03/2023, 10:46",
        type: "Jewellery",
      ),
    );
    refreshCompleter.complete(true);
    emit(const AuctionListingLoadedState());
  }

  void clearData() {
    auctionSearchController.clear();
  }

  Future<void> _onAuctionListLoadMoreEvent(AuctionListLoadMoreEvent event, Emitter<AuctionListingState> emit) async {
    emit(const AuctionListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    auctionList.addAll(
      List.generate(
        10,
        (index) => AuctionListModel(
          id: index.toString(),
          imageUrl: "https://i.ibb.co/Rhgz539/image-224.png",
          name: "Diamond Vine Ring in 18k Gold",
          skuNo: "DERC03RDA",
          orderStatus: index == 0 ? ProjectStatus.onGoing : ProjectStatus.winner,
          bidAmount: "\$5000.00",
          bidPlacedOn: "23/03/2023, 10:46",
          type: "Jewellery",
        ),
      ),
    );
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(AuctionListLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onAuctionListPullToRefresh(AuctionListPullToRefreshEvent event, Emitter<AuctionListingState> emit) async {
    emit(const AuctionListingReloadingState());
    paginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    auctionList = List.generate(
      10,
      (index) => AuctionListModel(
        id: index.toString(),
        imageUrl: "https://i.ibb.co/Rhgz539/image-224.png",
        name: "Diamond Vine Ring in 18k Gold",
        skuNo: "DERC03RDA",
        orderStatus: index == 0 ? ProjectStatus.onGoing : ProjectStatus.winner,
        bidAmount: "\$5000.00",
        bidPlacedOn: "23/03/2023, 10:46",
        type: "Jewellery",
      ),
    );
    refreshCompleter.complete(true);
    emit(const AuctionListingLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const AuctionListPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
