import 'package:kgk/kgk.dart';

part 'edit_watchlist_event.dart';

part 'edit_watchlist_state.dart';

class EditWatchlistBloc extends Bloc<EditWatchlistEvent, EditWatchlistState> {
  bool isEdit = true;
  String appBarTitle = '';
  Duration? duration;

  int get durationDays => duration?.inDays ?? 0;

  int get durationHours => duration?.inHours.remainder(24) ?? 0;

  int get durationMinutes => duration?.inMinutes.remainder(60) ?? 0;
  final TextEditingController nameController = TextEditingController();

  WatchlistData? watchlistData;

  EditWatchlistBloc() : super(const EditWatchlistInitial()) {
    on<EditWatchlistInitialEvent>(_onEditWatchlistInitialEvent);
    on<EditWatchlistDurationChangedEvent>(_onEditWatchlistDurationChangedEvent);
    on<EditWatchlistSaveEvent>(_onEditWatchlistSaveEvent);
  }

  void _onEditWatchlistInitialEvent(EditWatchlistInitialEvent event, Emitter<EditWatchlistState> emit) {
    emit(const EditWatchlistReloadState());
    isEdit = event.isEdit;
    if (isEdit) {
      watchlistData = event.watchlistData;
      appBarTitle = APPStrings.editWatchlist.tr;
      nameController.text = watchlistData?.name ?? '';
      duration = Duration(
          days: watchlistData?.duration?.days ?? 0,
          hours: watchlistData?.duration?.hours ?? 0,
          minutes: watchlistData?.duration?.minutes ?? 0);
    } else {
      watchlistData = null;
      appBarTitle = APPStrings.createWatchlist.tr;
      nameController.clear();
      duration = Duration.zero;
    }
    emit(const EditWatchlistLoadedState());
  }

  void _onEditWatchlistDurationChangedEvent(EditWatchlistDurationChangedEvent event, Emitter<EditWatchlistState> emit) {
    duration = event.duration;
    emit(const EditWatchlistDurationChangedState());
  }

  Future<void> _onEditWatchlistSaveEvent(EditWatchlistSaveEvent event, Emitter<EditWatchlistState> emit) async {
    final Map<String, dynamic> body = {
      ApiKey.name: nameController.text,
      ApiKey.hours: duration?.inHours.remainder(24),
      ApiKey.minutes: duration?.inMinutes.remainder(60),
      ApiKey.days: duration?.inDays,
      if (isEdit) ApiKey.watchlistId: watchlistData?.sId,
    };

    final Either<ErrorResponse, CommonResponse>? response = isEdit
        ? await AppRepository(event.context).editWatchlist(body: body)
        : await AppRepository(event.context).createWatchlist(body: body);

    response?.fold(
      (error) => Utils.showMessage(error.message),
      (data) {
        nameController.clear();
        final Map<RoutesData, bool> popArguments = isEdit ? {RoutesData.isWatchlistUpdated: true} : {RoutesData.isWatchlistCreated: true};

        event.context.pop(arguments: popArguments);
        Utils.showMessage(data.message);
      },
    );
  }
}
