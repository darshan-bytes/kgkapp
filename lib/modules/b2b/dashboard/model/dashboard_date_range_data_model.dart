class DashboardDateRangeDataModel {
  String? title;
  int? id;

  DashboardDateRangeDataModel({this.title, this.id});

  @override
  bool operator ==(Object other) {
    return other is DashboardDateRangeDataModel && other.title == title && other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ id.hashCode;
}
