part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();
}

final class InitialCalendarEvent extends CalendarEvent {
  final BuildContext context;

  const InitialCalendarEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class CalendarViewChangeEvent extends CalendarEvent {
  final CalendarView calendarView;

  const CalendarViewChangeEvent(this.calendarView);

  @override
  List<Object> get props => [calendarView];
}

final class CalendarOnViewChangedEvent extends CalendarEvent {
  final ViewChangedDetails viewChangeDetails;

  const CalendarOnViewChangedEvent(this.viewChangeDetails);

  @override
  List<Object> get props => [viewChangeDetails];
}

final class CalendarOnCellTapEvent extends CalendarEvent {
  final CalendarTapDetails details;
  final BuildContext context;

  const CalendarOnCellTapEvent(this.details, this.context);

  @override
  List<Object> get props => [details, context];
}

final class CalendarEventTypeChangeEvent extends CalendarEvent {
  final CalendarEventTypeModel calendarEventType;

  const CalendarEventTypeChangeEvent(this.calendarEventType);

  @override
  List<Object> get props => [calendarEventType];
}
