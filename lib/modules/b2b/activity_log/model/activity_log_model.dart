import 'package:kgk/kgk.dart';

class ActivityLogModel {
  String? id;
  String? logDate;
  List<ActivityModel>? activities;

  ActivityLogModel({
    this.id,
    this.logDate,
    this.activities,
  });
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
}
