import 'package:kgk/kgk.dart';

class BlocEventDeBouncer {
  static const int _blocEventDeBouncerTimeInMS = 500;

  static const kEventDeBouncerDuration = Duration(
    milliseconds: _blocEventDeBouncerTimeInMS,
  );

  static EventTransformer<Event> debounceTransformer<Event>({
    Duration duration = kEventDeBouncerDuration,
  }) {
    return (events, mapper) {
      return events.debounceTime(duration).switchMap(mapper);
    };
  }
}
