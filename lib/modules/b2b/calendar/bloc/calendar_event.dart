part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();
}

final class InitialCalendarEvent extends CalendarEvent {
  final BuildContext context;
  final DateTime? selectedDate;

  const InitialCalendarEvent(this.context, {this.selectedDate});

  @override
  List<Object> get props => [context];
}

final class CalendarViewChangeEvent extends CalendarEvent {
  final CalendarView calendarView;
  final BuildContext context;
  const CalendarViewChangeEvent(this.calendarView, this.context);

  @override
  List<Object> get props => [calendarView, context];
}

final class CalendarOnViewChangedEvent extends CalendarEvent {
  final ViewChangedDetails viewChangeDetails;
  final BuildContext context;

  const CalendarOnViewChangedEvent(this.viewChangeDetails, this.context);

  @override
  List<Object> get props => [viewChangeDetails, context];
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
  final BuildContext context;

  const CalendarEventTypeChangeEvent(this.calendarEventType, this.context);

  @override
  List<Object> get props => [calendarEventType];
}

final class CalenderSearchEvent extends CalendarEvent {
  final BuildContext context;

  const CalenderSearchEvent(this.context);

  @override
  List<Object> get props => [context];
}
