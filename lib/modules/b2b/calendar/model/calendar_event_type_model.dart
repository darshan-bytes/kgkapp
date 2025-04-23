class CalendarEventTypeModel {
  String? title;
  String? key;

  CalendarEventTypeModel({this.title, this.key});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarEventTypeModel && other.title == title && other.key == key;
  }

  @override
  int get hashCode {
    return title.hashCode ^ key.hashCode;
  }
}
