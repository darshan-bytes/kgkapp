import 'package:kgk/kgk.dart';

class BagOrderSummaryDataModel {
  BagOrderSummaryDataModel({
    required this.subTotal,
    required this.totalAmount,
    required this.charges,
    required this.promoCode,
  });

  final String? subTotal;
  final String? totalAmount;
  final List<BagOrderCharge> charges;
  final BagOrderCharge? promoCode;

  BagOrderSummaryDataModel copyWith({
    String? subTotal,
    String? totalAmount,
    List<BagOrderCharge>? charges,
    BagOrderCharge? promoCode,
  }) {
    return BagOrderSummaryDataModel(
      subTotal: subTotal ?? this.subTotal,
      totalAmount: totalAmount ?? this.totalAmount,
      charges: charges ?? this.charges,
      promoCode: promoCode ?? this.promoCode,
    );
  }

  factory BagOrderSummaryDataModel.fromJson(Map<String, dynamic> json) {
    return BagOrderSummaryDataModel(
      subTotal: json["subTotal"],
      totalAmount: json["totalAmount"],
      charges: json["charges"] == null ? [] : List<BagOrderCharge>.from(json["charges"]!.map((x) => BagOrderCharge.fromJson(x))),
      promoCode: json["promoCode"] == null ? null : BagOrderCharge.fromJson(json["promoCode"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "subTotal": subTotal,
        "totalAmount": totalAmount,
        "charges": charges.map((x) => x.toJson()).toList(),
        "promoCode": promoCode?.toJson(),
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
  });

  final String? id;
  final String? title;
  final String? displayValue;
  final double? value;
  final double? percentage;
  final bool? fromPercentage;

  BagOrderCharge copyWith({
    String? id,
    String? title,
    String? displayValue,
    double? value,
    double? percentage,
    bool? fromPercentage,
  }) {
    return BagOrderCharge(
      id: id ?? this.id,
      title: title ?? this.title,
      displayValue: displayValue ?? this.displayValue,
      value: value ?? this.value,
      percentage: percentage ?? this.percentage,
      fromPercentage: fromPercentage ?? this.fromPercentage,
    );
  }

  factory BagOrderCharge.fromJson(Map<String, dynamic> json) {
    return BagOrderCharge(
      id: json["_id"],
      title: json["title"],
      displayValue: json["display_value"],
      value: json["value"]?.toString().toDouble,
      percentage: json["percentage"]?.toString().toDouble,
      fromPercentage: json["from_percentage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "display_value": displayValue,
        "value": value,
        "percentage": percentage,
        "from_percentage": fromPercentage,
      };
}
