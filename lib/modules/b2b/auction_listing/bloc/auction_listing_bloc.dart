import 'package:kgk/kgk.dart';

part 'auction_listing_event.dart';

part 'auction_listing_state.dart';

class AuctionListingBloc extends Bloc<AuctionListingEvent, AuctionListingState> {
  final TextEditingController auctionSearchController = TextEditingController();

  List<AuctionListModel> auctionList = [];

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  AuctionListingBloc() : super(AuctionListingInitialState()) {
    on<InitialAuctionListingEvent>(_onInitialAuctionListingEvent);
    on<AuctionListLoadMoreEvent>(_onAuctionListLoadMoreEvent);
  }

  void _onInitialAuctionListingEvent(InitialAuctionListingEvent event, Emitter<AuctionListingState> emit) {
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
        orderStatus: index == 0 ? OrderStatus.onGoing : OrderStatus.winner,
        bidAmount: "\$5000.00",
        bidPlacedOn: "23/03/2023, 10:46",
        type: "Jewellery",
      ),
    );
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
          orderStatus: index == 0 ? OrderStatus.onGoing : OrderStatus.winner,
          bidAmount: "\$5000.00",
          bidPlacedOn: "23/03/2023, 10:46",
          type: "Jewellery",
        ),
      ),
    );
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(AuctionListLoadedMoreState(event.currentPage + 1));
  }
}
