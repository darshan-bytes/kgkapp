import 'package:kgk/kgk.dart';

class PaginationData<T> {
  int? filteredRecords;
  int? totalRecords;

  ///[avgRating] is used to store the average rating of the product mainly used in the product review data. Added it in this model because all other data in the response are common with pagination data.
  double? avgRating;
  List<dynamic>? dataList;

  PaginationData({
    this.filteredRecords,
    this.dataList,
    this.avgRating,
    this.totalRecords,
  });

  PaginationData.fromJson(Map<String, dynamic> json) {
    filteredRecords = json['filteredRecords']?.toString().toInt;
    totalRecords = json['totalRecords']?.toString().toInt;
    avgRating = json['avgRating']?.toString().toDouble;
    dataList = json.containsKey('data') && json['data'] != null ? getResponseData(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filteredRecords'] = filteredRecords;
    data['totalRecords'] = totalRecords;
    data['avgRating'] = avgRating;
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
      case const (ProductReviewModel):
        return ProductReviewModel.fromJson(json);
      case const (CadLibraryListItemDataModel):
        return CadLibraryListItemDataModel.fromJson(json);
      case const (DigitalCatalogueDetails):
        return DigitalCatalogueDetails.fromJson(json);
      case const (Map<String, dynamic>):
        return json;
      default:
        throw KGKException(message: 'Specific model retrieve error.....', code: 'model_not_found');
    }
  }
}
