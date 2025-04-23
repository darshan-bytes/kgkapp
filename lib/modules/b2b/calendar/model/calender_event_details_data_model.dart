import 'package:kgk/kgk.dart';

class CalenderEventDetailsDataModel {
  String? id;
  String? createdOn;
  String? updatedOn;
  int? categoryId;
  String? name;
  String? slug;
  String? description;
  String? startDate;
  String? endDate;
  String? priority;
  List<String>? assignedTo;
  String? status;
  int? createdBy;
  List<NotifyBeforeTaskDue>? notifyBeforeTaskDue;
  String? categoryName;
  List<UserIdDetails>? assignedToDetails;
  UserIdDetails? createdByDetails;

  CalenderEventDetailsDataModel({
    this.id,
    this.createdOn,
    this.updatedOn,
    this.categoryId,
    this.name,
    this.slug,
    this.description,
    this.startDate,
    this.endDate,
    this.priority,
    this.assignedTo,
    this.status,
    this.createdBy,
    this.notifyBeforeTaskDue,
    this.categoryName,
    this.assignedToDetails,
    this.createdByDetails,
  });

  CalenderEventDetailsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    categoryId = json['category_id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    priority = json['priority'];
    assignedTo = json['assigned_to'].cast<String>();
    status = json['status'];
    createdBy = json['created_by'];
    if (json['notify_before_task_due'] != null) {
      notifyBeforeTaskDue = [];
      json['notify_before_task_due'].forEach((v) {
        List<NotifyBeforeTaskDue>.from(json["notify_before_task_due"].map((x) => NotifyBeforeTaskDue.fromJson(x)));
      });
    }
    categoryName = json['category_name'];
    if (json['assigned_to_details'] != null) {
      assignedToDetails = <UserIdDetails>[];
      json['assigned_to_details'].forEach((v) {
        assignedToDetails!.add(UserIdDetails.fromJson(v));
      });
    }
    createdByDetails = json['created_by_details'] != null ? UserIdDetails.fromJson(json['created_by_details']) : null;
  }
}

extension CalenderEventDataModelExtension on CalenderEventDetailsDataModel {
  Priority get getPriority => Priority.values.firstWhereOrNull((element) => element.stringValue == priority) ?? Priority.low;
}

class NotifyBeforeTaskDue {
  final String id;
  final String taskId;
  final int day;
  final String time;
  final bool isDeleted;
  final DateTime deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String v;

  NotifyBeforeTaskDue({
    required this.id,
    required this.taskId,
    required this.day,
    required this.time,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NotifyBeforeTaskDue.fromJson(Map<String, dynamic> json) => NotifyBeforeTaskDue(
    id: json["_id"],
    taskId: json["task_id"],
    day: json["day"],
    time: json["time"],
    isDeleted: json["isDeleted"],
    deletedAt: json["deletedAt"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "task_id": taskId,
    "day": day,
    "time": time,
    "isDeleted": isDeleted,
    "deletedAt": deletedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
