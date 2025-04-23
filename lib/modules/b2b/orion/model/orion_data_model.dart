class OrionDataModel {
  OrionDataModel({
    required this.id,
    required this.ctsOrGms,
    required this.finalPrice,
    required this.discountPercentage,
    required this.totalPrice,
    required this.discountPrice,
    required this.rate,
    required this.originalPrice,
    required this.originalDiscountPrice,
    required this.priceCts,
    required this.rappaportPrice,
    required this.lsp,
    required this.isAddedToCart,
  });

  final String? id;
  final double? ctsOrGms;
  final String? finalPrice;
  final double? discountPercentage;
  final double? totalPrice;
  final String? discountPrice;
  final double? rate;
  final double? originalPrice;
  final double? originalDiscountPrice;
  final dynamic priceCts;
  final dynamic rappaportPrice;
  final dynamic lsp;
  final bool? isAddedToCart;

  factory OrionDataModel.fromJson(Map<String, dynamic> json) {
    return OrionDataModel(
      id: json["id"],
      ctsOrGms: json["cts_or_gms"].toDouble(),
      finalPrice: json["final_price"],
      discountPercentage: json["discount_percentage"].toDouble(),
      totalPrice: json["total_price"].toDouble(),
      discountPrice: json["discount_price"],
      rate: json["rate"] == null ? 0.0 : json["rate"].toDouble(),
      originalPrice: json["original_price"].toDouble(),
      originalDiscountPrice: json["original_discount_price"].toDouble(),
      priceCts: json["price_cts"],
      rappaportPrice: json["rappaport_price"],
      lsp: json["lsp"],
      isAddedToCart: json["isAddedToCart"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "cts_or_gms": ctsOrGms,
    "final_price": finalPrice,
    "discount_percentage": discountPercentage,
    "total_price": totalPrice,
    "discount_price": discountPrice,
    "rate": rate,
    "original_price": originalPrice,
    "original_discount_price": originalDiscountPrice,
    "price_cts": priceCts,
    "rappaport_price": rappaportPrice,
    "lsp": lsp,
    "isAddedToCart": isAddedToCart,
  };

  @override
  String toString() {
    return "$id, $ctsOrGms, $finalPrice, $discountPercentage, $totalPrice, $discountPrice, $originalPrice, $originalDiscountPrice, $priceCts, $rappaportPrice, $lsp, $isAddedToCart, ";
  }
}
