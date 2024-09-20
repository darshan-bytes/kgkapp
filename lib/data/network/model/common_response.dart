import 'package:kgk/kgk.dart';

/// Common response model
class CommonResponse<T> {
  int? statusCode;
  String? message;
  dynamic responseData;

  CommonResponse({this.statusCode, this.message, this.responseData});

  bool get isSuccess => statusCode == 200 || statusCode == 201;

  bool get isTokenExpired => statusCode == 401;

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
      case const (BusinessType):
        return BusinessType.fromJson(json);
      case const (OfficeLocation):
        return OfficeLocation.fromJson(json);
      case const (ForgotPasswordModel):
        return ForgotPasswordModel.fromJson(json);
      case const (CurrencyListModel):
        return CurrencyListModel.fromJson(json);
      case const (DiamondListingModel):
        return DiamondListingModel.fromJson(json);
      case const (GemstoneListingModel):
        return GemstoneListingModel.fromJson(json);
      case const (JewelleryListingModel):
        return JewelleryListingModel.fromJson(json);
      case const (DiamondDataModel):
        return DiamondDataModel.fromJson(json);
      case const (GemstoneDatum):
        return GemstoneDatum.fromJson(json);
      case const (PaginationData<WatchlistData>):
        return PaginationData<WatchlistData>.fromJson(json);
      case const (WatchlistData):
        return WatchlistData.fromJson(json);
      case const (JewelleryDataModel):
        return JewelleryDataModel.fromJson(json);
      case const (WishlistResponseModel):
        return WishlistResponseModel.fromJson(json);
      case const (ProductReviewModel):
        return ProductReviewModel.fromJson(json);
      case const (WishlistModel):
        return WishlistModel.fromJson(json);
      case const (PaginationData<ProductReviewModel>):
        return PaginationData<ProductReviewModel>.fromJson(json);
      case const (MyBagDataModel):
        return MyBagDataModel.fromJson(json);
      case const (GemstoneFilterModel):
        return GemstoneFilterModel.fromJson(json);
      case const (SecondaryFilterModel):
        return SecondaryFilterModel.fromJson(json);
      case const (Map<String, dynamic>):
        return json;
      default:
        throw KGKException(message: 'Specific model retrieve error.....', code: 'model_not_found');
    }
  }
}
