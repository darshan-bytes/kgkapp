class CalendarEventTypeModel {
  int? id;
  String? title;

  CalendarEventTypeModel({
    this.id,
    this.title,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarEventTypeModel && other.id == id && other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode;
  }
}
