class DashboardStatisticsDataModel {
  String? title;
  String? value;
  String? subTitle;
  String? variation;
  bool isNegative;

  DashboardStatisticsDataModel({this.title, this.value, this.subTitle, this.variation, this.isNegative = false});

  @override
  bool operator ==(Object other) {
    return other is DashboardStatisticsDataModel &&
        other.title == title &&
        other.value == value &&
        other.subTitle == subTitle &&
        other.variation == variation &&
        other.isNegative == isNegative;
  }

  @override
  int get hashCode => title.hashCode ^ value.hashCode ^ subTitle.hashCode ^ variation.hashCode ^ isNegative.hashCode;
}
