// This screen is not in use
// import 'package:kgk/kgk.dart';
//
// part 'auction_event.dart';
//
// part 'auction_state.dart';
//
// class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
//   // Identifies the source of the user: B2B or B2C.
//   UserType userType = UserType.b2cUser;
//
//   int current = 0;
//   bool isCompare = false;
//   bool isMyBidPlaced = false;
//   bool isInitialised = false;
//
//   DiamondDataModel? diamondData;
//   ProductDetailsModel? productDetails;
//   String productName = '';
//   String startingBidPrice = '';
//   bool isBidPlaced = true;
//
//   Timer? _timer;
//   Duration auctionEndDuration = Duration.zero;
//
//   TextEditingController bidAmountController = TextEditingController();
//   final CarouselSliderController controller = CarouselSliderController();
//   final ScrollController listScrollController = ScrollController();
//   final ScrollController scrollController = ScrollController();
//   final GlobalKey targetKey = GlobalKey();
//   AuctionListModel auctionModel = AuctionListModel();
//
//   List<String> imgList = [];
//
//   List<Map<String, dynamic>> recentBidList = [];
//
//   List<ProductDetailsModel> youMayAlisLikeProductList = List.generate(
//     8,
//     (index) => ProductDetailsModel(
//       suid: "1",
//       diamond: "1.5 gram",
//       gram: "1.5 gram",
//       imageUrl: "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
//       name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
//       originalPrice: "\$1,600.00",
//     ),
//   );
//
//   AuctionBloc() : super(AuctionInitial()) {
//     on<AuctionInitialEvent>(_onInitEvent);
//     on<AuctionDiamondImagePageChangeEvent>(_onAuctionDiamondImagePageChangeEvent);
//     on<AuctionProductCompareToggleEvent>(_onAuctionProductCompareToggleEvent);
//     on<AuctionStartTimerEvent>(_onStartTimer);
//     on<AuctionUpdateTimerEvent>(_onUpdateTimer);
//     on<AuctionTimerCompletedEvent>(_onAuctionTimerCompletedEvent);
//     on<AuctionPlaceBidEvent>(_onPlaceBidEvent);
//   }
//
//   void _onInitEvent(AuctionInitialEvent event, Emitter<AuctionState> emit) async {
//     emit(const AuctionReloadState());
//     auctionModel = event.context.routesData?[RoutesData.auctionModelData];
//     if (!isInitialised && auctionModel.productId != null) {
//       isInitialised = true;
//       await getDiamondsDetails(emit, event.context, auctionModel.productId!);
//     }
//     userType = BlocProvider.of<AppBloc>(event.context).userType;
//     resetData();
//     emit(AuctionInitial());
//   }
//
//   void resetData() {
//     _timer?.cancel();
//     bidAmountController.clear();
//     isCompare = false;
//     isMyBidPlaced = false;
//     add(const AuctionStartTimerEvent());
//   }
//
//   void _onAuctionDiamondImagePageChangeEvent(AuctionDiamondImagePageChangeEvent event, Emitter<AuctionState> emit) {
//     current = event.index;
//     emit(AuctionDiamondImagePageChangeState());
//   }
//
//   void _onAuctionProductCompareToggleEvent(AuctionProductCompareToggleEvent event, Emitter<AuctionState> emit) {
//     emit(const AuctionReloadState());
//     isCompare = !isCompare;
//     emit(const AuctionProductCompareToggleState());
//   }
//
//   void _onStartTimer(AuctionStartTimerEvent event, Emitter<AuctionState> emit) {
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
//       if (auctionEndDuration.compareTo(const Duration(days: 0, hours: 0, minutes: 0, seconds: 0)) > 0) {
//         auctionEndDuration -= const Duration(seconds: 1);
//         add(AuctionUpdateTimerEvent(auctionEndDuration));
//       } else {
//         _timer?.cancel();
//         auctionEndDuration = const Duration(days: 0, hours: 0, minutes: 0, seconds: 0);
//         add(AuctionTimerCompletedEvent(auctionEndDuration));
//       }
//     });
//   }
//
//   void _onUpdateTimer(AuctionUpdateTimerEvent event, Emitter<AuctionState> emit) {
//     emit(AuctionTimerUpdateState(event.duration));
//   }
//
//   void _onAuctionTimerCompletedEvent(AuctionTimerCompletedEvent event, Emitter<AuctionState> emit) {
//     emit(const AuctionTimerCompletedState());
//   }
//
//   Future<void> _onPlaceBidEvent(AuctionPlaceBidEvent event, Emitter<AuctionState> emit) async {
//     emit(const AuctionReloadState());
//     await createBidForAuction(event.context);
//     emit(const AuctionPlaceBidState());
//   }
//
//   /// Create bid for auction
//   Future<void> createBidForAuction(BuildContext context) async {
//     if (auctionModel.id == null) return;
//     Map<String, dynamic> body = {ApiKey.auctionId: int.parse(auctionModel.id!), ApiKey.bidAmount: bidAmountController.text};
//     await AppRepository(context).createBidForAuction(body).then(
//           (r) => r?.fold(
//             (l) {
//               Utils.showMessage(l.message);
//             },
//             (r) {
//               Utils.showMessage(r.message);
//               isMyBidPlaced = true;
//               bidAmountController.clear();
//               _scrollToRecentBids();
//             },
//           ),
//         );
//   }
//
//   String formatDuration(Duration duration) {
//     int days = duration.inDays;
//     int hours = duration.inHours % 24;
//     int minutes = duration.inMinutes % 60;
//     int seconds = duration.inSeconds % 60;
//
//     List<String> parts = [];
//
//     if (days > 0) {
//       parts.add("$days${"d"}");
//     }
//     if (hours > 0) {
//       parts.add("$hours${"hrs"}");
//     }
//     if (minutes > 0) {
//       parts.add("$minutes${"mins"}");
//     }
//     if (seconds > 0 || parts.isEmpty) {
//       parts.add("$seconds${"sec"}");
//     }
//
//     return parts.join(" : ");
//
//     /// For display full time in days, hours, minutes, seconds
//     //   return "$days${"d"} : $hours${"hrs"} : $minutes${"mins"} : $seconds${"sec"}";
//   }
//
//   void _scrollToRecentBids() {
//     Scrollable.ensureVisible(
//       targetKey.currentContext!,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.fastOutSlowIn,
//     );
//   }
//
//   Future<void> getDiamondsDetails(Emitter<AuctionState> emit, BuildContext context, String productId) async {
//     Either<ErrorResponse, DiamondDataModel>? response = await AppRepository(context).getDiamondDetailById(productId);
//     await response?.fold(
//       (error) {
//         if (error.message.isNotNullNorEmpty) {
//           Utils.showMessage(error.message);
//         }
//       },
//       (data) async {
//         diamondData = data;
//         if (diamondData != null) {
//           bool isDiscounted =
//               diamondData!.discountPercentage != null && diamondData!.discountPercentage > 0;
//           productName = diamondData!.rmDescription ?? '';
//           imgList = diamondData!.image.map((e) => e.url ?? '').toList();
//           productDetails = ProductDetailsModel(
//             suid: diamondData!.suid,
//             productId: productId,
//             name: productName,
//             offerPrice: isDiscounted ? diamondData!.discountPrice?.setCurrency : null,
//             originalPrice: diamondData!.finalPrice?.setCurrency,
//             discountPercentageString:
//                 isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([diamondData!.discountPercentage]) : null,
//             productSku: diamondData!.lotCode,
//             reviewCount: diamondData!.reviewCount,
//             rating: diamondData!.rating,
//             commodity: Commodity.diamond,
//             isFavourite: diamondData?.isFavorite ?? false,
//             wishlistId: diamondData?.wishlistID,
//             auctionId: diamondData?.auctionId,
//           );
//
//           if (productDetails != null && productDetails?.auctionId != null) {
//             await fetchAuctionDetails(emit, context, productDetails!.auctionId!);
//           }
//         }
//       },
//     );
//   }
//
//   Future<void> fetchAuctionDetails(Emitter<AuctionState> emit, BuildContext context, String auctionId) async {
//     Either<ErrorResponse, AuctionDataModel>? response = await AppRepository(context).getAuctionDetails(id: auctionId);
//     await response?.fold((error) => Utils.showMessage(error.message), (data) {
//       startingBidPrice = data.startingPrice?.setCurrency ?? '';
//
//       // Determine if any bid has `isMyBid == true` before the loop
//       isBidPlaced = data.bids.any((bid) => bid.isMyBid == true);
//
//       // Populate `recentBidList` by iterating over `data.bids`
//       for (int i = 0; i < data.bids.length; i++) {
//         recentBidList.add({
//           AppConst.dateTimeKey: data.bids[i].createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMM),
//           AppConst.priceKey: data.bids[i].bidAmount?.setCurrency,
//           AppConst.isMyBidKey: data.bids[i].isMyBid,
//         });
//       }
//
//       // Emit the state after processing all bids
//       emit(const AuctionPlaceBidState());
//
//       DateTime currentDate = DateTime.now(); // Current date
//       DateTime endDate = DateTime.parse(data.endDate.toString()); // Provided end date
//
//       Duration duration = endDate.difference(currentDate); // Calculate duration
//
//       auctionEndDuration = duration;
//       isMyBidPlaced = false;
//       add(const AuctionStartTimerEvent());
//     });
//   }
// }
