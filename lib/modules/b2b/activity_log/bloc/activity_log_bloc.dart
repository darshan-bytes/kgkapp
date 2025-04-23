import 'package:kgk/kgk.dart';

part 'activity_log_event.dart';
part 'activity_log_state.dart';

class ActivityLogBloc extends Bloc<ActivityLogEvent, ActivityLogState> {
  TextEditingController customerController = TextEditingController();
  TextEditingController moduleController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();

  List<ActivityLogModel> activityLogList = [];

  ActivityLogBloc() : super(ActivityLogInitial()) {
    on<ActivityLogInitialEvent>(_activityLogInitialEvent);
  }

  void _activityLogInitialEvent(ActivityLogInitialEvent event, Emitter<ActivityLogState> emit) {
    emit(ActivityLogReloadState());

    List<ActivityModel> getActivities(int index) {
      return List.generate(index + 1, (index) {
        return ActivityModel(
          id: index.toString(),
          time: "11:45 am",
          activity: "Created a moodboard Summer Collection and shared with customer.",
        );
      });
    }

    activityLogList = List.generate(3, (index) {
      return ActivityLogModel(id: index.toString(), logDate: "16 Aug 2023", activities: getActivities(index));
    });
    emit(const ActivityLogLoadedState());
  }
}
