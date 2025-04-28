import 'package:kgk/kgk.dart';

class BlocEventDeBouncer {
  static const int _blocEventDeBouncerTimeInMS = 500;

  static const _kEventDeBouncerDuration = Duration(milliseconds: _blocEventDeBouncerTimeInMS);

  static EventTransformer<Event> debounceTransformer<Event>({Duration duration = _kEventDeBouncerDuration}) {
    return (events, mapper) {
      return events.debounceTime(duration).switchMap(mapper);
    };
  }
}
