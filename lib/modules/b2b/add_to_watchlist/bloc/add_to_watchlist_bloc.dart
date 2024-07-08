import 'package:kgk/kgk.dart';

part 'add_to_watchlist_event.dart';

part 'add_to_watchlist_state.dart';

class AddToWatchlistBloc extends Bloc<AddToWatchlistEvent, AddToWatchlistState> {
  bool get isEdit => actionType == WatchlistActionType.edit;

  bool get isRemove => actionType == WatchlistActionType.remove;
  WatchlistActionType actionType = WatchlistActionType.add;
  List<WatchlistDetailsModel> arrWatchlist = [
    WatchlistDetailsModel(name: "My Watchlist"),
    WatchlistDetailsModel(name: "John Samanta"),
    WatchlistDetailsModel(name: "Jenny Wilson"),
    WatchlistDetailsModel(name: "Alex Williams"),
  ];

  final List<WatchlistSelectionModel> _arrSelectedWatchlist = [
    WatchlistSelectionModel(name: APPStrings.notifyWhenProductIsInStock.tr),
    WatchlistSelectionModel(name: APPStrings.notifyWhenPriceDrops.tr),
    WatchlistSelectionModel(name: APPStrings.notifyWhenDiscountApplied.tr),
  ];

  List<WatchlistSelectionModel> get arrSelectedWatchlist {
    if (productDetails?.isOutOfStock == true) {
      return _arrSelectedWatchlist;
    } else {
      return _arrSelectedWatchlist.sublist(1);
    }
  }

  WatchlistDetailsModel? selectedWatchlistName;

  ProductDetails? productDetails;

  AddToWatchlistBloc() : super(const AddToWatchlistInitial()) {
    on<AddToWatchlistInitialEvent>(_onAddToWatchlistInitialEvent);
    on<WatchlistChangeNameEvent>(_onChangeWatchList);
    on<WatchlistCheckEvent>(_onSelectedWatchlistEvent);
  }

  void _onAddToWatchlistInitialEvent(AddToWatchlistInitialEvent event, Emitter<AddToWatchlistState> emit) {
    if (productDetails != event.productDetails || actionType != event.actionType) {
      actionType = event.actionType;
      emit(const AddToWatchlistReloadState());
      productDetails = event.productDetails;
      selectedWatchlistName = null;
      for (var element in arrSelectedWatchlist) {
        element.isSelected = false;
      }
      emit(const AddToWatchlistLoadedState());
    }
  }

  void _onChangeWatchList(WatchlistChangeNameEvent event, Emitter<AddToWatchlistState> emit) {
    emit((const AddToWatchlistReloadState()));
    selectedWatchlistName = event.selectedWatchlist;
    emit(const WatchlistChangeNameState());
  }

  void _onSelectedWatchlistEvent(WatchlistCheckEvent event, Emitter<AddToWatchlistState> emit) {
    emit(const AddToWatchlistReloadState());
    arrSelectedWatchlist[event.index].isSelected = !arrSelectedWatchlist[event.index].isSelected;
    emit(WatchlistSelectedState(event.index));
  }
}
