///[PlaceOrderProductRequest] class is used to prepare the product list request body for the place order API.
class PlaceOrderProductRequest {
  PlaceOrderProductRequest({
    required this.discountPercentage,
    required this.suid,
    required this.image,
    required this.name,
    required this.yourAmount,
    required this.yourRate,
    required this.yourDiscount,
    required this.quantity,
  });

  final double? discountPercentage;
  final String? suid;
  final String? image;
  final String? name;
  final String? yourAmount;
  final String? yourRate;
  final double? yourDiscount;
  final int? quantity;

  PlaceOrderProductRequest copyWith({
    double? discountPercentage,
    String? suid,
    String? image,
    String? name,
    String? yourAmount,
    String? yourRate,
    double? yourDiscount,
    int? quantity,
  }) {
    return PlaceOrderProductRequest(
      discountPercentage: discountPercentage ?? this.discountPercentage,
      suid: suid ?? this.suid,
      image: image ?? this.image,
      name: name ?? this.name,
      yourAmount: yourAmount ?? this.yourAmount,
      yourRate: yourRate ?? this.yourRate,
      yourDiscount: yourDiscount ?? this.yourDiscount,
      quantity: quantity ?? this.quantity,
    );
  }

  factory PlaceOrderProductRequest.fromJson(Map<String, dynamic> json) {
    return PlaceOrderProductRequest(
      discountPercentage: json["discount_percentage"],
      suid: json["suid"],
      image: json["image"],
      name: json["name"],
      yourAmount: json["your_amount"],
      yourRate: json["your_rate"],
      yourDiscount: json["your_discount"],
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
        "discount_percentage": discountPercentage,
        "suid": suid,
        "image": image,
        "name": name,
        "your_amount": yourAmount,
        "your_rate": yourRate,
        "your_discount": yourDiscount,
        "quantity": quantity,
      };
}
