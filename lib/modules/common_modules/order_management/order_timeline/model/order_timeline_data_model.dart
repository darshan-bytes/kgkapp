import 'package:kgk/kgk.dart';

class OrderTimelineDataModel {
  int? id;
  String? title;
  String? description;
  String? date;
  String? time;
  String dateTime;

  OrderTimelineDataModel({this.id, this.title, this.description, this.date, this.time, required this.dateTime});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderTimelineDataModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.date == date &&
        other.time == time &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ date.hashCode ^ time.hashCode ^ dateTime.hashCode;
  }
}

extension OrderTimelineDataModelExt on OrderTimelineDataModel {
  DateTime get dateTimeObject {
    return DateTime.parse(dateTime);
  }
}
