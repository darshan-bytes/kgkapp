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

  EditWatchlistBloc() : super(const EditWatchlistInitial()) {
    on<EditWatchlistInitialEvent>(_onEditWatchlistInitialEvent);
    on<EditWatchlistDurationChangedEvent>(_onEditWatchlistDurationChangedEvent);
  }

  void _onEditWatchlistInitialEvent(EditWatchlistInitialEvent event, Emitter<EditWatchlistState> emit) {
    isEdit = event.isEdit;
    if (isEdit) {
      appBarTitle = APPStrings.editWatchlist.tr;
      nameController.text = 'Watchlist 1';
      duration = const Duration(days: 1, hours: 3, minutes: 30);
    } else {
      appBarTitle = APPStrings.createWatchlist.tr;
      duration = Duration.zero;
    }
    emit(const EditWatchlistLoadedState());
  }

  void _onEditWatchlistDurationChangedEvent(EditWatchlistDurationChangedEvent event, Emitter<EditWatchlistState> emit) {
    duration = event.duration;
    emit(const EditWatchlistDurationChangedState());
  }
}
