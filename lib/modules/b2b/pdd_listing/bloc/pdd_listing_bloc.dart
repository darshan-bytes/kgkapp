import 'package:kgk/kgk.dart';

part 'pdd_listing_event.dart';

part 'pdd_listing_state.dart';

class PddListingBloc extends Bloc<PddListingEvent, PddListingState> {
  PddListingBloc() : super(PddListingInitial()) {
    on<PddListingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
