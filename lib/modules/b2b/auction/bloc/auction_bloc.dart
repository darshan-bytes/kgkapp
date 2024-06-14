import 'package:kgk/kgk.dart';

part 'auction_event.dart';

part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  int current = 0;
  bool isCompare = false;
  bool isMyBidPlaced = false;

  Timer? _timer;
  Duration auctionEndDuration = const Duration(days: 5, hours: 3, minutes: 30, seconds: 45);

  TextEditingController bidAmountController = TextEditingController();
  final CarouselController controller = CarouselController();
  final ScrollController listScrollController = ScrollController();
  final ScrollController scrollController = ScrollController();
  final GlobalKey targetKey = GlobalKey();

  final List<String> imgList = [
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
  ];

  List<Map<String, dynamic>> recentBidList = [
    {"date_time": "17/03/23 10:00 PM", "price": "\$9000.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$8500.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$8000.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$7500.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$7000.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$6500.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$6000.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$5500.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$5000.00"},
    {"date_time": "17/03/23 10:00 PM", "price": "\$4500.00"},
  ];

  List<ProductDetails> youMayAlisLikeProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl: "https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
      name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
      originalPrice: "\$1,600.00",
    ),
  );

  AuctionBloc() : super(AuctionInitial()) {
    on<AuctionInitialEvent>(_onInitEvent);
    on<AuctionDiamondImagePageChangeEvent>(_onAuctionDiamondImagePageChangeEvent);
    on<AuctionProductCompareToggleEvent>(_onAuctionProductCompareToggleEvent);
    on<AuctionStartTimerEvent>(_onStartTimer);
    on<AuctionUpdateTimerEvent>(_onUpdateTimer);
    on<AuctionTimerCompletedEvent>(_onAuctionTimerCompletedEvent);
    on<AuctionPlaceBidEvent>(_onPlaceBidEvent);
  }

  void _onInitEvent(AuctionInitialEvent event, Emitter<AuctionState> emit) async {
    emit(const AuctionReloadState());
    resetData();
    emit(AuctionInitial());
  }

  void resetData() {
    _timer?.cancel();
    bidAmountController.clear();
    isCompare = false;
    auctionEndDuration = const Duration(days: 5, hours: 3, minutes: 30, seconds: 45);
    isMyBidPlaced = false;
    add(const AuctionStartTimerEvent());
  }

  void _onAuctionDiamondImagePageChangeEvent(AuctionDiamondImagePageChangeEvent event, Emitter<AuctionState> emit) {
    current = event.index;
    emit(AuctionDiamondImagePageChangeState());
  }

  void _onAuctionProductCompareToggleEvent(AuctionProductCompareToggleEvent event, Emitter<AuctionState> emit) {
    emit(const AuctionReloadState());
    isCompare = !isCompare;
    emit(const AuctionProductCompareToggleState());
  }

  void _onStartTimer(AuctionStartTimerEvent event, Emitter<AuctionState> emit) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (auctionEndDuration.compareTo(const Duration(days: 0, hours: 0, minutes: 0, seconds: 0)) > 0) {
        auctionEndDuration -= const Duration(seconds: 1);
        add(AuctionUpdateTimerEvent(auctionEndDuration));
      } else {
        _timer?.cancel();
        auctionEndDuration = const Duration(days: 0, hours: 0, minutes: 0, seconds: 0);
        add(AuctionTimerCompletedEvent(auctionEndDuration));
      }
    });
  }

  void _onUpdateTimer(AuctionUpdateTimerEvent event, Emitter<AuctionState> emit) {
    emit(AuctionTimerUpdateState(event.duration));
  }

  void _onAuctionTimerCompletedEvent(AuctionTimerCompletedEvent event, Emitter<AuctionState> emit) {
    emit(const AuctionTimerCompletedState());
  }

  void _onPlaceBidEvent(AuctionPlaceBidEvent event, Emitter<AuctionState> emit) {
    emit(const AuctionReloadState());
    isMyBidPlaced = true;
    bidAmountController.clear();
    _scrollToRecentBids();
    emit(const AuctionPlaceBidState());
  }

  String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    List<String> parts = [];

    if (days > 0) {
      parts.add("$days${"d"}");
    }
    if (hours > 0) {
      parts.add("$hours${"hrs"}");
    }
    if (minutes > 0) {
      parts.add("$minutes${"mins"}");
    }
    if (seconds > 0 || parts.isEmpty) {
      parts.add("$seconds${"sec"}");
    }

    return parts.join(" : ");

    /// For display full time in days, hours, minutes, seconds
    //   return "$days${"d"} : $hours${"hrs"} : $minutes${"mins"} : $seconds${"sec"}";
  }

  void _scrollToRecentBids() {
    Scrollable.ensureVisible(
      targetKey.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
