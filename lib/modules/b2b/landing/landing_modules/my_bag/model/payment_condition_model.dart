import 'package:kgk/kgk.dart';

class PaymentCondition {
  PaymentCondition({
    this.name, //required
    this.slug, //required
    this.createdBy, //required
    this.updatedBy, //required
    this.status, //required
    this.createdAt, //required
    this.updatedAt, //required
    this.id, //required
    this.createdByDetails, //required
    this.updatedByDetails, //required
  });

  final String? name;
  final String? slug;
  final String? createdBy;
  final String? updatedBy;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final UserIdDetails? createdByDetails;
  final UserIdDetails? updatedByDetails;

  PaymentCondition copyWith({
    String? name,
    String? slug,
    String? createdBy,
    String? updatedBy,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    UserIdDetails? createdByDetails,
    UserIdDetails? updatedByDetails,
  }) {
    return PaymentCondition(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      createdByDetails: createdByDetails ?? this.createdByDetails,
      updatedByDetails: updatedByDetails ?? this.updatedByDetails,
    );
  }

  factory PaymentCondition.fromJson(Map<String, dynamic> json) {
    return PaymentCondition(
      name: json["name"],
      slug: json["slug"],
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      id: json["id"],
      createdByDetails: json["created_by_details"] == null ? null : UserIdDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : UserIdDetails.fromJson(json["updated_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
        "created_by_details": createdByDetails?.toJson(),
        "updated_by_details": updatedByDetails?.toJson(),
      };
}
