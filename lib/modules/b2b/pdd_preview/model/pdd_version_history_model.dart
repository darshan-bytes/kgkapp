import 'package:kgk/kgk.dart';

class PddVersionHistoryModel {
  String? id;
  String? historyDateTime;

  PddVersionHistoryModel({this.id, this.historyDateTime});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PddVersionHistoryModel && other.id == id && other.historyDateTime == historyDateTime;
  }

  @override
  int get hashCode => id.hashCode ^ historyDateTime.hashCode;
}
