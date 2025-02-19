import 'package:kgk/kgk.dart';

class CurrencyListModel {
  CurrencyListModel({
    required this.name,
    required this.slug,
    required this.code,
    required this.symbol,
    required this.isDefault,
    required this.symbolPosition,
    required this.decimalSeparator,
    required this.thousandSeparator,
    required this.decimalDigits,
    required this.conversionType,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.updatedBy,
    required this.createdByDetails,
    required this.updatedByDetails,
  });

  final String? name;
  final String? slug;
  final String? code;
  final String? symbol;
  final bool? isDefault;
  final String? symbolPosition;
  final String? decimalSeparator;
  final String? thousandSeparator;
  final String? decimalDigits;
  final String? conversionType;
  final bool? status;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? id;
  final String? updatedBy;
  final UserIdDetails? createdByDetails;
  final UserIdDetails? updatedByDetails;

  factory CurrencyListModel.fromJson(Map<String, dynamic> json) {
    return CurrencyListModel(
      name: json["name"],
      slug: json["slug"],
      code: json["code"],
      symbol: json["symbol"],
      isDefault: json["is_default"],
      symbolPosition: json["symbol_position"],
      decimalSeparator: json["decimal_separator"],
      thousandSeparator: json["thousand_separator"],
      decimalDigits: json["decimal_digits"],
      conversionType: json["conversion_type"],
      status: json["status"],
      createdBy: json["created_by"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      id: json["id"],
      updatedBy: json["updated_by"],
      createdByDetails: json["created_by_details"] == null ? null : UserIdDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : UserIdDetails.fromJson(json["updated_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "code": code,
        "symbol": symbol,
        "is_default": isDefault,
        "symbol_position": symbolPosition,
        "decimal_separator": decimalSeparator,
        "thousand_separator": thousandSeparator,
        "decimal_digits": decimalDigits,
        "conversion_type": conversionType,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
        "updated_by": updatedBy,
        "created_by_details": createdByDetails?.toJson(),
        "updated_by_details": updatedByDetails?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyListModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          slug == other.slug &&
          code == other.code &&
          symbol == other.symbol &&
          isDefault == other.isDefault &&
          symbolPosition == other.symbolPosition &&
          decimalSeparator == other.decimalSeparator &&
          thousandSeparator == other.thousandSeparator &&
          decimalDigits == other.decimalDigits &&
          conversionType == other.conversionType &&
          status == other.status &&
          createdBy == other.createdBy &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          id == other.id &&
          updatedBy == other.updatedBy &&
          createdByDetails == other.createdByDetails &&
          updatedByDetails == other.updatedByDetails;

  @override
  int get hashCode =>
      name.hashCode ^
      slug.hashCode ^
      code.hashCode ^
      symbol.hashCode ^
      isDefault.hashCode ^
      symbolPosition.hashCode ^
      decimalSeparator.hashCode ^
      thousandSeparator.hashCode ^
      decimalDigits.hashCode ^
      conversionType.hashCode ^
      status.hashCode ^
      createdBy.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      id.hashCode ^
      updatedBy.hashCode ^
      createdByDetails.hashCode ^
      updatedByDetails.hashCode;

  @override
  String toString() {
    return "$name, $slug, $code, $symbol, $isDefault, $symbolPosition, $decimalSeparator, $thousandSeparator, $decimalDigits, $conversionType, $status, $createdBy, $createdAt, $updatedAt, $id, $updatedBy, $createdByDetails, $updatedByDetails, ";
  }
}
