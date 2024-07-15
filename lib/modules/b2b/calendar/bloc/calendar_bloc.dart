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
  List<Meeting<CalendarData>> meetingList = [];

  MeetingDataSource meetingDataSource = MeetingDataSource([]);

  CalendarBloc() : super(const CalendarInitial()) {
    on<InitialCalendarEvent>(_onInitialCalendarEvent);
    on<CalendarViewChangeEvent>(_onCalendarViewChangeEvent);
    on<CalendarOnViewChangedEvent>(_onCalendarOnViewChangedEvent);
    on<CalendarOnCellTapEvent>(_onCalendarOnCellTapEvent);
    on<CalendarEventTypeChangeEvent>(_onCalendarEventTypeChangeEvent);
  }

  void _onInitialCalendarEvent(InitialCalendarEvent event, Emitter<CalendarState> emit) {
    final CalendarStyle style = AppTheme.of(event.context).calendarStyle;
    calendarEventTypeList = _generateCalendarEventTypeList();
    selectedCalendarEventType = calendarEventTypeList.first;
    calendarDataList = _generateCalendarDataList();
    meetingList = _convertToMeeting(style);
    meetingDataSource = MeetingDataSource(meetingList);
    selectedMonth = calendarController.displayDate ?? DateTime.now();
    emit(const CalendarLoadedState());
  }

  void _onCalendarViewChangeEvent(CalendarViewChangeEvent event, Emitter<CalendarState> emit) {
    emit(const CalendarReloadState());
    calendarView = event.calendarView;
    calendarController.view = calendarView;
    selectedMonth = DateTime.now();
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
  ///   emit (Emitter<CalendarState>): The function to emit new states to the calendar bloc.
  void _onCalendarOnViewChangedEvent(CalendarOnViewChangedEvent event, Emitter<CalendarState> emit) {
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

    emit(const CalendarOnViewChangedState());
  }

  void _onCalendarOnCellTapEvent(CalendarOnCellTapEvent event, Emitter<CalendarState> emit) {
    if (event.details.targetElement == CalendarElement.calendarCell) {
      handleCalendarCellClick(event.context, event.details, emit);
    } else if (event.details.targetElement == CalendarElement.appointment) {
      if (event.details.appointments != null && event.details.appointments!.isNotEmpty) {
        handleAppointmentClick(event.context, event.details.appointments?.first);
      }
    }
  }

  void _onCalendarEventTypeChangeEvent(CalendarEventTypeChangeEvent event, Emitter<CalendarState> emit) {
    emit(const CalendarReloadState());
    selectedCalendarEventType = event.calendarEventType;
    emit(const CalendarEventTypeChangeState());
  }

  void handleCalendarCellClick(BuildContext context, CalendarTapDetails details, Emitter<CalendarState> emit) {
    emit(const CalendarReloadState());
    calendarController.selectedDate = details.date;
    calendarController.view = CalendarView.day;
    calendarView = CalendarView.day;
    emit(const CalendarViewChangeState());
  }

  void handleAppointmentClick(BuildContext context, Meeting<CalendarData> meeting) {
    /// To get the data model of the calendar data received from API use: meeting.value
    Utils.showSmartModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
      ),
      builder: (context) => TaskDetailsBottomSheet(calendarData: meeting.value),
    );
  }

  ///Data Class Wrapper method to convert data received from api to required data model type Meeting.
  List<Meeting<CalendarData>> _convertToMeeting(CalendarStyle style) {
    return calendarDataList
        .map((e) => Meeting<CalendarData>(
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

  ///Helper Methods
  List<CalendarData> _generateCalendarDataList() {
    return List.generate(
      170,
      (index) {
        int date = Random().nextInt(30);
        int start = Random().nextInt(10);
        int end = start + Random().nextInt(3);
        int month = DateTime.now().month;
        return CalendarData(
          id: index,
          title: 'Title ${index + 1}',
          description:
              'Lorem ipsum dolor sit amet consectetur. At velit in morbi integer. Nullam suspendisse pulvinar aliquet lacus morbi accumsan. Egestas enim consectetur convallis ut egestas. Volutpat ultrices ullamcorper hendrerit risus',
          type: [CalenderEventType.meeting.value, CalenderEventType.task.value].randomValue,
          start:
              '2024-${month < 10 ? '0$month' : month}-${date < 9 ? '0${date + 1}' : '${date + 1}'} ${start < 10 ? '0$start' : '$start'}:00:00',
          end: '2024-${month < 10 ? '0$month' : month}-${date < 9 ? '0${date + 1}' : '${date + 1}'} ${end < 10 ? '0$end' : '$end'}:00:00',
          assignedTo: 'Jason Smith',
          assignedToImage: 'https://i.ibb.co/SJDj2Pj/Frame-3977.png',
          assignedBy: 'Jason Smith',
          assignedByImage: 'https://i.ibb.co/SJDj2Pj/Frame-3977.png',
          categoryName: 'Category ${date + 1}',
          status: ['Pending', 'Completed', 'In Progress'].randomValue,
          priority: ['High', 'Medium', 'Low'].randomValue,
          createdDate: '2024-${month < 11 ? '0${month - 1}' : month - 1}-${date < 9 ? '0${date + 1}' : '${date + 1}'} 10:00:00',
        );
      },
    );
  }

  List<CalendarEventTypeModel> _generateCalendarEventTypeList() {
    return [
      CalendarEventTypeModel(id: 1, title: APPStrings.all.tr),
      CalendarEventTypeModel(id: 3, title: APPStrings.tasks.tr),
      CalendarEventTypeModel(id: 2, title: APPStrings.meetings.tr),
    ];
  }
}
