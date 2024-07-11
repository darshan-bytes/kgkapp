import 'package:kgk/kgk.dart';

class CalendarData {
  int? id;
  String? title;
  String? description;
  String? type;
  String? start;
  String? end;
  String? categoryName;
  String? status;
  String? priority;
  String? assignedTo;
  String? assignedToImage;
  String? assignedBy;
  String? assignedByImage;
  String? createdDate;

  CalendarData({
    this.id,
    this.title,
    this.description,
    this.type,
    this.start,
    this.end,
    this.categoryName,
    this.status,
    this.priority,
    this.assignedTo,
    this.assignedToImage,
    this.assignedBy,
    this.assignedByImage,
    this.createdDate,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarData &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.type == type &&
        other.start == start &&
        other.end == end &&
        other.categoryName == categoryName &&
        other.status == status &&
        other.priority == priority &&
        other.assignedTo == assignedTo &&
        other.assignedToImage == assignedToImage &&
        other.assignedBy == assignedBy &&
        other.assignedByImage == assignedByImage &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        type.hashCode ^
        start.hashCode ^
        end.hashCode ^
        categoryName.hashCode ^
        status.hashCode ^
        priority.hashCode ^
        assignedTo.hashCode ^
        assignedToImage.hashCode ^
        assignedBy.hashCode ^
        assignedByImage.hashCode ^
        createdDate.hashCode;
  }
}

extension CalendarDataExtension on CalendarData {
  CalenderEventType get calenderEventType =>
      CalenderEventType.values.firstWhereOrNull((element) => element.value == type) ?? CalenderEventType.undefined;
}

class MeetingDataSource extends CalendarDataSource<Meeting<CalendarData>> {
  MeetingDataSource(List<Meeting<CalendarData>> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting<T> {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
    required this.value,
  });

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  T value;
}
