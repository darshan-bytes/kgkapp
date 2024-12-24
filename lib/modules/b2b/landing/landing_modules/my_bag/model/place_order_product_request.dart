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
  final double? yourAmount;
  final double? yourRate;
  final double? yourDiscount;
  final int? quantity;

  PlaceOrderProductRequest copyWith({
    double? discountPercentage,
    String? suid,
    String? image,
    String? name,
    double? yourAmount,
    double? yourRate,
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
