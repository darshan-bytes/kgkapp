import 'package:kgk/kgk.dart';

class PaginationData<T> {
  int? filteredRecords;
  int? totalRecords;
  List<dynamic>? dataList;

  PaginationData({
    this.filteredRecords,
    this.dataList,
    this.totalRecords,
  });

  PaginationData.fromJson(Map<String, dynamic> json) {
    filteredRecords = json['filteredRecords'];
    totalRecords = json['totalRecords'];
    dataList = json.containsKey('data') && json['data'] != null ? getResponseData(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filteredRecords'] = filteredRecords;
    data['totalRecords'] = totalRecords;
    if (dataList != null) {
      data['data'] = dataList?.map((x) => x?.toJson()).toList();
    }
    return data;
  }

  List<T> getResponseData(dynamic json) {
    if (json is List) {
      List<T> list = [];
      for (var element in json) {
        list.add(getModelValue(element));
      }
      return list;
    } else {
      return [];
    }
  }

  /// To retrieve generic specific model value from json
  dynamic getModelValue(dynamic json) {
    switch (T) {
      case const (WatchlistData):
        return WatchlistData.fromJson(json);
      case const (Map<String, dynamic>):
        return json;
      default:
        throw KGKException(message: 'Specific model retrieve error.....', code: 'model_not_found');
    }
  }
}
