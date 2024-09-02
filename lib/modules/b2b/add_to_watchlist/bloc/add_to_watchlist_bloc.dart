import 'package:kgk/kgk.dart';

part 'add_to_watchlist_event.dart';

part 'add_to_watchlist_state.dart';

class AddToWatchlistBloc extends Bloc<AddToWatchlistEvent, AddToWatchlistState> {
  bool get isEdit => actionType == WatchlistActionType.edit;

  bool get isRemove => actionType == WatchlistActionType.remove;
  WatchlistActionType actionType = WatchlistActionType.add;
  List<WatchlistData> arrWatchlist = [];

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

  WatchlistData? selectedWatchlist;

  ProductDetails? productDetails;

  late WatchlistBloc watchlistBloc;

  AddToWatchlistBloc() : super(const AddToWatchlistInitial()) {
    on<AddToWatchlistInitialEvent>(_onAddToWatchlistInitialEvent);
    on<WatchlistChangeNameEvent>(_onChangeWatchList);
    on<WatchlistCheckEvent>(_onSelectedWatchlistEvent);
    on<AddToWatchListSaveEvent>(_onAddToWatchListSave);
  }

  Future<void> _onAddToWatchlistInitialEvent(AddToWatchlistInitialEvent event, Emitter<AddToWatchlistState> emit) async {
    watchlistBloc = BlocProvider.of<WatchlistBloc>(event.context);
    watchlistBloc.add(WatchListLoadFullListEvent(event.context));
    arrWatchlist = await watchlistBloc.allWatchlistFull.future;
    actionType = event.actionType;
    emit(const AddToWatchlistReloadState());
    productDetails = event.productDetails;
    selectedWatchlist = null;
    for (WatchlistSelectionModel element in _arrSelectedWatchlist) {
      element.isSelected = false;
      emit(const AddToWatchlistLoadedState());
    }
  }

  void _onChangeWatchList(WatchlistChangeNameEvent event, Emitter<AddToWatchlistState> emit) {
    emit((const AddToWatchlistReloadState()));
    selectedWatchlist = event.selectedWatchlist;
    emit(const WatchlistChangeNameState());
  }

  void _onSelectedWatchlistEvent(WatchlistCheckEvent event, Emitter<AddToWatchlistState> emit) {
    emit(const AddToWatchlistReloadState());
    arrSelectedWatchlist[event.index].isSelected = !arrSelectedWatchlist[event.index].isSelected;
    emit(WatchlistSelectedState(event.index));
  }

  Future<void> _onAddToWatchListSave(AddToWatchListSaveEvent event, Emitter<AddToWatchlistState> emit) async {
    if (selectedWatchlist?.sId == null) {
      Utils.showMessage(APPStrings.pleaseSelectWatchlist.tr);
      return;
    }
    Map<String, dynamic> body = {
      ApiKey.productId: productDetails?.productId,
      ApiKey.commodity: productDetails?.commodity?.value,
      ApiKey.notifyOnPriceDrop: _arrSelectedWatchlist[1].isSelected,
      ApiKey.notifyOnDiscount: _arrSelectedWatchlist[2].isSelected,
    };

    Either<ErrorResponse, CommonResponse>? response;
    if (selectedWatchlist?.products?.map((WatchlistProducts e) => e.productId).contains(productDetails?.productId) == false) {
      response = await AppRepository(event.context).watchListAddProduct(selectedWatchlist!.sId ?? '', body);
    } else {
      response =
          await AppRepository(event.context).watchListUpdateProduct(selectedWatchlist!.sId ?? '', productDetails?.productId ?? '', body);
    }

    response?.fold((ErrorResponse error) {
      Utils.showMessage(error.message ?? '');
    }, (CommonResponse response) {
      // Resets the watchlist full list to get updated data when the user clicks on the add to watchlist button for the same product again.
      // This requires calling the update product API.
      watchlistBloc.resetAllWatchlistFull();
      event.context.pop();
      Utils.showMessage(response.message ?? '');
    });
  }
}
