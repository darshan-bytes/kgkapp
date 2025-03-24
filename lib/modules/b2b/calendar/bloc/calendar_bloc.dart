import 'package:kgk/kgk.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final TextEditingController searchController = TextEditingController();
  CalendarView calendarView = CalendarView.month;
  CalendarController calendarController = CalendarController();
  DateTime selectedMonth = DateTime.now();

  List<CalendarEventTypeModel> calendarEventTypeList = [];
  CalendarEventTypeModel? selectedCalendarEventType;
  List<CalendarData> calendarDataList = [];
  List<CalenderEvent<CalendarData>> meetingList = [];

  MeetingDataSource meetingDataSource = MeetingDataSource([]);

  CalendarBloc() : super(const CalendarInitial()) {
    on<InitialCalendarEvent>(_onInitialCalendarEvent);
    on<CalendarViewChangeEvent>(_onCalendarViewChangeEvent);
    on<CalendarOnViewChangedEvent>(_onCalendarOnViewChangedEvent);
    on<CalendarOnCellTapEvent>(_onCalendarOnCellTapEvent);
    on<CalendarEventTypeChangeEvent>(_onCalendarEventTypeChangeEvent);
    on<CalenderSearchEvent>(_onCalendarSearchEvent);
  }

  Future<void> _onInitialCalendarEvent(InitialCalendarEvent event, Emitter<CalendarState> emit) async {
    if (event.selectedDate != null) {
      selectedMonth = event.selectedDate!;
      calendarController.displayDate = event.selectedDate;
    } else {
      selectedMonth = calendarController.displayDate ?? DateTime.now();
    }
    calendarEventTypeList = _generateCalendarEventTypeList();
    selectedCalendarEventType = calendarEventTypeList.first;
    await getCalendarData(event.context);
    emit(const CalendarLoadedState());
  }

  Future<void> _onCalendarViewChangeEvent(CalendarViewChangeEvent event, Emitter<CalendarState> emit) async {
    emit(const CalendarReloadState());
    calendarView = event.calendarView;
    calendarController.view = calendarView;
    selectedMonth = DateTime.now();
    await getCalendarData(event.context);
    emit(const CalendarViewChangeState());
  }

  /// Handles the event when the calendar view changes.
  ///
  /// This method is triggered whenever the calendar view is changed by the user,
  /// such as switching between months or changing the view to week, day, etc.
  /// It updates the state to reload the calendar and then sets the selected month
  /// based on the visible dates in the new view.
  ///
  /// If all visible dates belong to the same month, that month is selected directly.
  /// Otherwise, it calculates the most represented month among the visible dates
  /// and selects it as the current month.
  ///
  /// The selection logic involves creating a map to count the occurrence of each month
  /// in the visible dates, finding the month(s) with the maximum count, and then
  /// setting the selected month to the first date in the visible dates that matches
  /// this most represented month.
  ///
  /// Args:
  ///   event (CalendarOnViewChangedEvent): The event containing details about the view change,
  ///                                        including the list of currently visible dates.
  ///   emit (Emitter CalendarState): The function to emit new states to the calendar bloc.
  Future<void> _onCalendarOnViewChangedEvent(CalendarOnViewChangedEvent event, Emitter<CalendarState> emit) async {
    emit(const CalendarReloadState());

    if (event.viewChangeDetails.visibleDates.first.month == event.viewChangeDetails.visibleDates.last.month) {
      selectedMonth = event.viewChangeDetails.visibleDates.first;
    } else {
      // Initializes a map to track the frequency of each month among the visible dates.
      Map<int, int> monthMap = {};

      // Iterates over each date in the visible dates of the calendar view.
      for (DateTime element in event.viewChangeDetails.visibleDates) {
        // Checks if the month of the current date is already in the map.
        if (monthMap.containsKey(element.month) && monthMap[element.month] != null) {
          // If present, increments the count for this month.
          monthMap[element.month] = monthMap[element.month]! + 1;
        } else {
          // If not present, initializes the count for this month to 1.
          monthMap[element.month] = 1;
        }
      }

      // Variable to hold the maximum occurrence count among the months.
      int max = 0;
      // Finds the maximum occurrence count.
      for (var element in monthMap.values) {
        if (element > max) {
          max = element;
        }
      }

      // Iterates over the monthMap to find the month(s) with the maximum occurrence count.
      monthMap.forEach((key, value) {
        // If the current month's count equals the maximum count,
        // sets it as the selected month using the first matching date.
        if (value == max) {
          selectedMonth = event.viewChangeDetails.visibleDates.firstWhere((element) => element.month == key);
        }
      });
    }

    await getCalendarData(event.context);
    emit(const CalendarOnViewChangedState());
  }

  Future<void> _onCalendarOnCellTapEvent(CalendarOnCellTapEvent event, Emitter<CalendarState> emit) async {
    if (event.details.targetElement == CalendarElement.calendarCell) {
      handleCalendarCellClick(event.context, event.details, emit);
    } else if (event.details.targetElement == CalendarElement.appointment) {
      if (event.details.appointments != null && event.details.appointments!.isNotEmpty) {
        await getCalenderEventDetails(event.context, emit, event.details.appointments?.first);
      }
    }
  }

  Future<void> _onCalendarEventTypeChangeEvent(CalendarEventTypeChangeEvent event, Emitter<CalendarState> emit) async {
    emit(const CalendarReloadState());
    selectedCalendarEventType = event.calendarEventType;
    await getCalendarData(event.context);
    emit(const CalendarEventTypeChangeState());
  }

  Future<void> _onCalendarSearchEvent(CalenderSearchEvent event, Emitter<CalendarState> emit) async {
    emit(const CalendarReloadState());
    await getCalendarData(event.context);
    emit(const CalendarLoadedState());
  }

  String? get formattedDate {
    switch (calendarView.name) {
      case ApiKey.month:
        return selectedMonth.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatMMYYYY);
      case ApiKey.day:
        return selectedMonth.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYY);
      case ApiKey.week:
        return selectedMonth.isoWeekOfYear;
      default:
        return null;
    }
  }

  Future<void> getCalendarData(BuildContext context, {bool isShowLoader = true, bool isForceFetch = false}) async {
    List<CalendarDataModel> dataList = [];
    try {
      final Map<String, dynamic> body = {
        ApiKey.search: searchController.text,
        ApiKey.date: formattedDate ?? '',
        ApiKey.type: selectedCalendarEventType?.key,
        ApiKey.formatType: calendarView.name,
      };
      Either<ErrorResponse, List<CalendarDataModel>>? response = await AppRepository(context).getCalenderEvent(body: body);
      response?.fold((l) {
        dataList = [];
        Utils.showMessage(l.message);
      }, (success) {
        dataList.clear();
        final CalendarStyle style = AppTheme.of(context).calendarStyle;

        dataList = success;
        calendarDataList.clear();
        calendarDataList = List.generate(
          dataList.length,
          (index) {
            return CalendarData(
                id: dataList[index].id ?? '',
                title: dataList[index].title,
                type: dataList[index].type,
                start: dataList[index].startDate.toString(),
                end: dataList[index].endDate.toString());
          },
        );
        meetingList = _convertToMeeting(style);
        meetingDataSource = MeetingDataSource(meetingList);
      });
    } catch (e) {
      printWrapped(e.toString());
    }
  }

  Future<void> getCalenderEventDetails(BuildContext context, Emitter<CalendarState> emit, CalenderEvent<CalendarData> calenderEvent) async {
    emit(const CalendarReloadState());
    final response = await AppRepository(context).getCalenderEventDetails(id: calenderEvent.value.id ?? '');

    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        handleAppointmentClick(context, r);
        emit(CalendarLoadedState());
      },
    );
  }

  void handleCalendarCellClick(BuildContext context, CalendarTapDetails details, Emitter<CalendarState> emit) {
    emit(const CalendarReloadState());
    calendarController.selectedDate = details.date;
    calendarController.view = CalendarView.day;
    calendarView = CalendarView.day;
    emit(const CalendarViewChangeState());
  }

  void handleAppointmentClick(BuildContext context, CalenderEventDetailsDataModel eventDetail) {
    /// To get the data model of the calendar data received from API use: meeting.value
    Utils.showSmartModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(12.r), topEnd: Radius.circular(12.r)),
      ),
      builder: (context) => TaskDetailsBottomSheet(calendarData: eventDetail),
    );
  }

  ///Data Class Wrapper method to convert data received from api to required data model type Meeting.
  List<CalenderEvent<CalendarData>> _convertToMeeting(CalendarStyle style) {
    return calendarDataList
        .map((e) => CalenderEvent<CalendarData>(
              value: e,
              eventName: e.title ?? '',
              from: e.start!.stringToDateTime() ?? DateTime.now(),
              to: e.end!.stringToDateTime() ?? DateTime.now(),
              background: e.calenderEventType == CalenderEventType.meeting
                  ? style.meetEventCellBackgroundColor
                  : style.taskEventCellBackgroundColor,
              isAllDay: false,
            ))
        .toList();
  }

  List<CalendarEventTypeModel> _generateCalendarEventTypeList() {
    return [
      CalendarEventTypeModel(title: APPStrings.all.tr, key: ApiKey.all),
      CalendarEventTypeModel(title: APPStrings.tasks.tr, key: ApiKey.task),
      CalendarEventTypeModel(title: APPStrings.meetings.tr, key: ApiKey.meeting),
    ];
  }
}
