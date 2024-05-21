import 'package:kgk/kgk.dart';

part 'no_internet_event.dart';
part 'no_internet_state.dart';

class NoInternetBloc extends Bloc<NoInternetEvent, NoInternetState> {
  NoInternetBloc() : super(NoInternetInitial()) {
    on<NoInternetEvent>((event, emit) {});
  }
}
