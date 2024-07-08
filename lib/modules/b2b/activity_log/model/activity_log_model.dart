import 'package:kgk/kgk.dart';

class ActivityLogModel {
  String? id;
  String? logDate;
  List<ActivityModel>? activities = [];

  ActivityLogModel({
    this.id,
    this.logDate,
    this.activities,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActivityLogModel && other.id == id && other.logDate == logDate && other.activities == activities;
  }

  @override
  int get hashCode {
    return id.hashCode ^ logDate.hashCode ^ activities.hashCode;
  }
}

class ActivityModel {
  String? id;
  String? time;
  String? activity;

  ActivityModel({
    this.id,
    this.time,
    this.activity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActivityModel && other.id == id && other.time == time && other.activity == activity;
  }

  @override
  int get hashCode {
    return id.hashCode ^ time.hashCode ^ activity.hashCode;
  }
}
