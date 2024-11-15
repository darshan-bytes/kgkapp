import 'package:kgk/kgk.dart';

part 'auction_listing_event.dart';

part 'auction_listing_state.dart';

class AuctionListingBloc extends Bloc<AuctionListingEvent, AuctionListingState> {
  final TextEditingController auctionSearchController = TextEditingController();

  List<AuctionListModel> auctionList = [];

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  int? totalNumberOfPages;

  AuctionListingBloc() : super(AuctionListingInitialState()) {
    on<InitialAuctionListingEvent>(_onInitialAuctionListingEvent);
    on<AuctionListLoadMoreEvent>(_onAuctionListLoadMoreEvent);
    on<AuctionListPullToRefreshEvent>(_onAuctionListPullToRefresh);
  }

  Future<void> _onInitialAuctionListingEvent(InitialAuctionListingEvent event, Emitter<AuctionListingState> emit) async {
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(AuctionListLoadMoreEvent(event.context, currentPage));
      },
    );
    clearData();

    await fetchAuctionListData(event.context, emit, true);

    refreshCompleter.complete(true);
    emit(const AuctionListingLoadedState());
  }

  void clearData() {
    auctionSearchController.clear();
  }

  Future<void> fetchAuctionListData(BuildContext context, Emitter<AuctionListingState> emit, bool isLoadMore) async {
    await AppRepository(context)
        .getAuctionList(limit: AppConst.pageLimit.toString(), page: paginationScrollController.currentPage.toString())
        .then((value) {
      value?.fold((l) {
        Utils.showMessage(l.message);
      }, (r) {
        AuctionListingModel auctionListingModel = r;
        r.totalRecords ??= 0;
        totalNumberOfPages = Utils.calculateTotalPages(r.totalRecords, AppConst.pageLimit);
        for (int i = 0; i < auctionListingModel.data.length; i++) {
          auctionList.add(AuctionListModel(
            id: auctionListingModel.data[i].auctionId,
            imageUrl: auctionListingModel.data[i].productImage,
            name: auctionListingModel.data[i].productDescription,
            skuNo: auctionListingModel.data[i].productSku,
            orderStatus: auctionListingModel.data[i].auctionStatus == "ONGOING" ? ProjectStatus.onGoing : ProjectStatus.winner,
            bidAmount: auctionListingModel.data[i].bidAmount?.setCurrency,
            bidPlacedOn: auctionListingModel.data[i].createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMM),
            type: auctionListingModel.data[i].type,
          ));
        }
      });
    });
  }

  Future<void> _onAuctionListLoadMoreEvent(AuctionListLoadMoreEvent event, Emitter<AuctionListingState> emit) async {
    emit(const AuctionListLoadingMoreState());
    fetchAuctionListData(event.context, emit, true);
    paginationScrollController.isPageLoaded.complete(event.currentPage == totalNumberOfPages);
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
