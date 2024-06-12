import 'package:kgk/kgk.dart';

part 'auction_listing_event.dart';

part 'auction_listing_state.dart';

class AuctionListingBloc extends Bloc<AuctionListingEvent, AuctionListingState> {
  // controllers
  final TextEditingController auctionSearchController = TextEditingController();

  // Dropdown and selection variables
  final List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];
  String selectedPageNumber = '01';

  // Auctions lists
  List<AuctionListModel> filteredAuctionList = _generateAuctionList();
  List<AuctionListModel> originalAuctionList = _generateAuctionList();

  AuctionListingBloc() : super(AuctionListingInitialState()) {
    on<InitialAuctionListingEvent>(_onInitialAuctionListingEvent);
    on<ChangeAuctionListingPageNumberEvent>(_onPageNumberChanged);
    on<FilterAuctionsEvent>(_onFilterAuctionsEvent);
  }

  void _onInitialAuctionListingEvent(InitialAuctionListingEvent event, Emitter<AuctionListingState> emit) {
    //TODO: Write code to get data from API
    emit(AuctionListingReloadState());
    clearData();
    emit(AuctionListingInitialState());
  }

  void _onFilterAuctionsEvent(FilterAuctionsEvent event, Emitter<AuctionListingState> emit) {
    emit(AuctionListingReloadState());
    if (auctionSearchController.text.isNotEmpty) {
      String query = auctionSearchController.text.toLowerCase();
      filteredAuctionList = originalAuctionList.where((AuctionListModel element) {
        return (element.name ?? '').toLowerCase().contains(query) ||
            (element.skuNo ?? '').toLowerCase().contains(query) ||
            (element.bidAmount ?? '').toLowerCase().contains(query) ||
            (element.bidPlacedOn ?? '').toLowerCase().contains(query) ||
            (element.type ?? '').toLowerCase().contains(query);
      }).toList();
    } else {
      filteredAuctionList = originalAuctionList;
    }
    emit(FilterAuctionsState());
  }

  void _onPageNumberChanged(ChangeAuctionListingPageNumberEvent event, Emitter<AuctionListingState> emit) {
    emit(AuctionListingReloadState());
    selectedPageNumber = event.pageNumber;
    emit(ChangeAuctionListingPageNumberState());
  }

  void clearData() {
    auctionSearchController.clear();
    filteredAuctionList = _generateAuctionList();
  }

  // Helper methods
  static List<AuctionListModel> _generateAuctionList() {
    return List.generate(
        8,
        (index) => AuctionListModel(
              id: index.toString(),
              imageUrl: "https://i.ibb.co/Rhgz539/image-224.png",
              name: "Diamond Vine Ring in 18k Gold",
              skuNo: "DERC03RDA",
              orderStatus: index == 0 ? OrderStatus.onGoing : OrderStatus.winner,
              bidAmount: "\$5000.00",
              bidPlacedOn: "23/03/2023, 10:46",
              type: "Jewellery",
            ));
  }
}
