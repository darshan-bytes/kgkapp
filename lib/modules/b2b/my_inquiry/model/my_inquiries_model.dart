import 'package:kgk/data/network/model/user_response.dart';

class MyInquiriesModel {
  MyInquiriesModel({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.email,
    required this.inquiryType,
    required this.commodity,
    required this.inquiryContextId,
    required this.contextId,
    required this.createdBy,
    required this.status,
    required this.assignedToDetails,
    required this.createdByDetails,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final String? name;
  final String? email;
  final String? inquiryType;
  final String? commodity;
  final String? inquiryContextId;
  final String? contextId;
  final String? createdBy;
  final String? status;
  final List<UserIdDetails> assignedToDetails;
  final UserIdDetails createdByDetails;

  factory MyInquiriesModel.fromJson(Map<String, dynamic> json) {
    return MyInquiriesModel(
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      id: json["id"],
      name: json["name"],
      email: json["email"],
      inquiryType: json["inquiry_type"],
      commodity: json["commodity"]?.toString(),
      inquiryContextId: json["inquiry_context_id"],
      contextId: json["context_id"],
      createdBy: json["created_by"],
      status: json["status"],
      assignedToDetails:
          json["assigned_to_details"] == null
              ? []
              : List<UserIdDetails>.from(json["assigned_to_details"]!.map((x) => UserIdDetails.fromJson(x))),
      createdByDetails: UserIdDetails.fromJson(json["created_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "id": id,
    "name": name,
    "email": email,
    "inquiry_type": inquiryType,
    "commodity": commodity,
    "inquiry_context_id": inquiryContextId,
    "context_id": contextId,
    "created_by": createdBy,
    "status": status,
    "assigned_to_details": List<dynamic>.from(assignedToDetails.map((x) => x.toJson())),
    "created_by_details": createdByDetails.toJson(),
  };

  @override
  String toString() {
    return "$createdAt, $updatedAt, $id, $name, $email, $inquiryType, $commodity, $inquiryContextId, $contextId, $createdBy, $status, $assignedToDetails, $createdByDetails, ";
  }
}
