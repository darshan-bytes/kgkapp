import 'package:kgk/kgk.dart';

class RetailStoreModel {
  RetailStoreModel({
    required this.id,
    required this.name,
    required this.status,
    required this.city,
    required this.stateCode,
    required this.locationUrl,
    required this.latitude,
    required this.longitude,
    required this.zipCode,
    required this.address1,
    required this.address2,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.stateName,
    required this.createdByDetails,
    required this.updatedByDetails,
    required this.distance,
  });

  final String? id;
  final String? name;
  final bool? status;
  final String? city;
  final String? stateCode;
  final String? locationUrl;
  final String? latitude;
  final String? longitude;
  final String? zipCode;
  final String? address1;
  final String? address2;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? stateName;
  final UserIdDetails? createdByDetails;
  final UserIdDetails? updatedByDetails;
  final double? distance;

  factory RetailStoreModel.fromJson(Map<String, dynamic> json) {
    return RetailStoreModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      city: json["city"],
      stateCode: json["state_code"],
      locationUrl: json["location_url"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      zipCode: json["zip_code"],
      address1: json["address_1"],
      address2: json["address_2"],
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      stateName: json["state_name"],
      createdByDetails: json["created_by_details"] == null ? null : UserIdDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : UserIdDetails.fromJson(json["updated_by_details"]),
      distance: json["distance"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "city": city,
        "state_code": stateCode,
        "location_url": locationUrl,
        "latitude": latitude,
        "longitude": longitude,
        "zip_code": zipCode,
        "address_1": address1,
        "address_2": address2,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "state_name": stateName,
        "created_by_details": createdByDetails?.toJson(),
        "updated_by_details": updatedByDetails?.toJson(),
        "distance": distance,
      };
}
