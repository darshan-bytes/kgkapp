import 'package:kgk/kgk.dart';

class BagOrderSummaryDataModel {
  BagOrderSummaryDataModel({
    required this.subTotal,
    required this.totalAmount,
    required this.charges,
    required this.promoCode,
    required this.percentage,
    required this.afterDiscountSubtractAmount,
    required this.totalAmountInNumber,
  });

  final String? subTotal;
  final String? totalAmount;
  final List<BagOrderCharge> charges;
  final BagOrderCharge? promoCode;
  final double? percentage;
  final String? afterDiscountSubtractAmount;
  final double? totalAmountInNumber;

  factory BagOrderSummaryDataModel.fromJson(Map<String, dynamic> json) {
    return BagOrderSummaryDataModel(
      subTotal: json["subTotal"],
      totalAmount: json["totalAmount"],
      charges: json["charges"] == null ? [] : List<BagOrderCharge>.from(json["charges"]!.map((x) => BagOrderCharge.fromJson(x))),
      promoCode: json["promoCode"] == null ? null : BagOrderCharge.fromJson(json["promoCode"]),
      percentage: json["percentage"]?.toString().toDouble,
      afterDiscountSubtractAmount: json["afterDiscountSubtractAmount"],
      totalAmountInNumber: json["totalAmountInNumber"]?.toString().toDouble,
    );
  }

  Map<String, dynamic> toJson() => {
    "subTotal": subTotal,
    "totalAmount": totalAmount,
    "charges": charges.map((x) => x.toJson()).toList(),
    "promoCode": promoCode?.toJson(),
    "percentage": percentage,
    "afterDiscountSubtractAmount": afterDiscountSubtractAmount,
    "totalAmountInNumber": totalAmountInNumber,
  };
}

class BagOrderCharge {
  BagOrderCharge({
    required this.id,
    required this.title,
    required this.displayValue,
    required this.value,
    required this.percentage,
    required this.fromPercentage,
    required this.symbol,
  });

  final String? id;
  final String? title;
  final String? displayValue;
  final double? value;
  final double? percentage;
  final bool? fromPercentage;
  final String? symbol;

  factory BagOrderCharge.fromJson(Map<String, dynamic> json) {
    return BagOrderCharge(
      id: json["_id"],
      title: json["title"],
      displayValue: json["display_value"],
      value: json["value"]?.toString().toDouble,
      percentage: json["percentage"]?.toString().toDouble,
      fromPercentage: json["from_percentage"],
      symbol: json["symbol"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "display_value": displayValue,
    "value": value,
    "percentage": percentage,
    "from_percentage": fromPercentage,
    "symbol": symbol,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BagOrderCharge && runtimeType == other.runtimeType && id == other.id && title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  String? get displaySymbol =>
      (symbol == 'add'
          ? "+ "
          : symbol == 'sub'
          ? "- "
          : null);
}
