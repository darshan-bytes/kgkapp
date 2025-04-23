import 'package:kgk/data/network/model/user_response.dart';

class MyInquiriesModel {
  MyInquiriesModel({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.email,
    required this.assignTo,
    required this.inquiryType,
    required this.commodity,
    required this.inquiryContextId,
    required this.contextId,
    required this.createdBy,
    required this.status,
    required this.assignedToDetails,
    required this.assignToDetails,
    required this.createdByDetails,
  });

  final DateTime? createdAt;
  final dynamic updatedAt;
  final String? id;
  final String? name;
  final String? email;
  final String? assignTo;
  final String? inquiryType;
  final String? commodity;
  final dynamic inquiryContextId;
  final dynamic contextId;
  final String? createdBy;
  final String? status;
  final List<UserIdDetails> assignedToDetails;
  final UserIdDetails? assignToDetails;
  final UserIdDetails createdByDetails;

  factory MyInquiriesModel.fromJson(Map<String, dynamic> json) {
    return MyInquiriesModel(
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: json["updated_at"],
      id: json["id"],
      name: json["name"],
      email: json["email"],
      assignTo: json["assign_to"],
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
      assignToDetails: json["assign_to_details"] == null ? null : UserIdDetails.fromJson(json["assign_to_details"]),
      createdByDetails: UserIdDetails.fromJson(json["created_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "id": id,
    "name": name,
    "email": email,
    "assign_to": assignTo,
    "inquiry_type": inquiryType,
    "commodity": commodity,
    "inquiry_context_id": inquiryContextId,
    "context_id": contextId,
    "created_by": createdBy,
    "status": status,
    "assigned_to_details": List<dynamic>.from(assignedToDetails.map((x) => x.toJson())),
    "assign_to_details": assignToDetails?.toJson(),
    "created_by_details": createdByDetails.toJson(),
  };

  @override
  String toString() {
    return "$createdAt, $updatedAt, $id, $name, $email, $assignTo, $inquiryType, $commodity, $inquiryContextId, $contextId, $createdBy, $status, $assignedToDetails, $assignToDetails, $createdByDetails, ";
  }
}
