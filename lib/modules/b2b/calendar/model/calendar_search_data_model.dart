class CalendarDataModel {
  CalendarDataModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.type,
  });

  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final dynamic startTime;
  final dynamic endTime;
  final String? id;
  final String? type;

  factory CalendarDataModel.fromJson(Map<String, dynamic> json) {
    return CalendarDataModel(
      title: json["title"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      startTime: json["start_time"],
      endTime: json["end_time"],
      id: json["id"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "start_time": startTime,
    "end_time": endTime,
    "id": id,
    "type": type,
  };
}
