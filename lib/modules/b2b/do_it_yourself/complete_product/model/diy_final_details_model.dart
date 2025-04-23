import 'package:kgk/kgk.dart';

class DiyFinalDetailsModel {
  DiyFinalDetailsModel({required this.product, required this.diamondDetailed, required this.sku, required this.dIYPrice});

  final DiyStyleListModel? product;
  final DiamondDataModel? diamondDetailed;
  final String? sku;
  final DIYPrice? dIYPrice;

  factory DiyFinalDetailsModel.fromJson(Map<String, dynamic> json) {
    return DiyFinalDetailsModel(
      product: json["product"] == null ? null : DiyStyleListModel.fromJson(json["product"]),
      diamondDetailed: json["diamondDetailed"] == null ? null : DiamondDataModel.fromJson(json["diamondDetailed"]),
      sku: json["sku"],
      dIYPrice: json["price"] == null ? null : DIYPrice.fromJson(json["price"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "diamondDetailed": diamondDetailed?.toJson(),
    "sku": sku,
    "price": dIYPrice?.toJson(),
  };
}

class DIYPrice {
  DIYPrice({
    required this.totalDiscountPrice,
    required this.totalDiscountPriceIn,
    required this.totalFinalPrice,
    required this.totalFinalPriceIn,
    required this.totalDiscount,
  });

  final String? totalDiscountPrice;
  final double? totalDiscountPriceIn;
  final String? totalFinalPrice;
  final double? totalFinalPriceIn;
  final double? totalDiscount;

  factory DIYPrice.fromJson(Map<String, dynamic> json) {
    return DIYPrice(
      totalDiscountPrice: json["total_discount_price"],
      totalDiscountPriceIn: json["total_discount_price_in"]?.toString().toDouble,
      totalFinalPrice: json["total_final_price"],
      totalFinalPriceIn: json["total_final_price_in"]?.toString().toDouble,
      totalDiscount: json["total_discount"]?.toString().toDouble,
    );
  }

  Map<String, dynamic> toJson() => {
    "total_discount_price": totalDiscountPrice,
    "total_discount_price_in": totalDiscountPriceIn,
    "total_final_price": totalFinalPrice,
    "total_final_price_in": totalFinalPriceIn,
    "total_discount": totalDiscount,
  };
}
