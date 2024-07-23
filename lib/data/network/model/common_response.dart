import 'package:kgk/kgk.dart';

/// Common response model
class CommonResponse<T> {
  int? statusCode;
  String? message;
  dynamic responseData;

  CommonResponse({this.statusCode, this.message, this.responseData});

  bool get isSuccess => statusCode == 200 || statusCode == 201;

  bool get isTokenExpired => statusCode == 400;

  CommonResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    responseData = json.containsKey('data') && json['data'] != null ? getResponseData(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (responseData != null) {
      data['data'] = responseData!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'CommonResponse{responseCode: $statusCode, responseMessage: $message, responseData: $responseData}';
  }

  /// To get response data either in list or models
  dynamic getResponseData(dynamic json) {
    if (json is List) {
      List<T> list = [];
      for (var element in json) {
        list.add(getModelValue(element));
      }
      return list;
    } else {
      return getModelValue(json);
    }
  }

  /// To retrieve generic specific model value from json
  dynamic getModelValue(dynamic json) {
    switch (T) {
      case const (UserResponse):
        return UserResponse.fromJson(json);
    }
  }
}
