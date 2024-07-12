part of 'calendar_bloc.dart';

sealed class CalendarState extends Equatable {
  const CalendarState();
}

final class CalendarInitial extends CalendarState {
  const CalendarInitial();

  @override
  List<Object> get props => [];
}

final class CalendarReloadState extends CalendarState {
  const CalendarReloadState();

  @override
  List<Object> get props => [];
}

final class CalendarLoadedState extends CalendarState {
  const CalendarLoadedState();

  @override
  List<Object> get props => [];
}

final class CalendarViewChangeState extends CalendarState {
  const CalendarViewChangeState();

  @override
  List<Object> get props => [];
}

final class CalendarOnViewChangedState extends CalendarState {
  const CalendarOnViewChangedState();

  @override
  List<Object> get props => [];
}

final class CalendarEventTypeChangeState extends CalendarState {
  const CalendarEventTypeChangeState();

  @override
  List<Object> get props => [];
}
