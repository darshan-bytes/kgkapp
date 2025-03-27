import 'package:kgk/kgk.dart';

class PddDataModel {
  PddDataModel({
    required this.id,
    required this.presentationNumber,
    required this.createdBy,
    required this.approvedBy,
    required this.approvedAt,
    required this.status,
    required this.coverImage,
    required this.createdAt,
    required this.updatedAt,
    required this.totalProjects,
    required this.conceptNumber,
    required this.conceptName,
    required this.collection,
    required this.businessCategory,
    required this.assignedTo,
    required this.conceptById,
    required this.conceptBy,
    required this.createdByDetails,
    required this.approvedByDetails,
    required this.assignedToDetails,
  });

  final String? id;
  final String? presentationNumber;
  final int? createdBy;
  final int? approvedBy;
  final DateTime? approvedAt;
  final String? status;
  final dynamic coverImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? totalProjects;
  final String? conceptNumber;
  final String? conceptName;
  final String? collection;
  final String? businessCategory;
  final List<String> assignedTo;
  final int? conceptById;
  final String? conceptBy;
  final UserIdDetails createdByDetails;
  final UserIdDetails approvedByDetails;
  final List<UserIdDetails> assignedToDetails;

  factory PddDataModel.fromJson(Map<String, dynamic> json) {
    return PddDataModel(
      id: json["_id"],
      presentationNumber: json["presentation_number"],
      createdBy: json["created_by"],
      approvedBy: json["approved_by"],
      approvedAt: DateTime.tryParse(json["approved_at"] ?? ""),
      status: json["status"],
      coverImage: json["cover_image"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      totalProjects: json["totalProjects"],
      conceptNumber: json["concept_number"],
      conceptName: json["concept_name"],
      collection: json["collection"],
      businessCategory: json["business_category"],
      assignedTo: json["assigned_to"] == null ? [] : List<String>.from(json["assigned_to"]!.map((x) => x)),
      conceptById: json["concept_by_id"],
      conceptBy: json["concept_by"],
      createdByDetails: UserIdDetails.fromJson(json["created_by_details"]),
      approvedByDetails: UserIdDetails.fromJson(json["approved_by_details"]),
      assignedToDetails: json["assigned_to_details"] == null
          ? []
          : List<UserIdDetails>.from(json["assigned_to_details"]!.map((x) => UserIdDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "presentation_number": presentationNumber,
        "created_by": createdBy,
        "approved_by": approvedBy,
        "approved_at": approvedAt?.toIso8601String(),
        "status": status,
        "cover_image": coverImage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "totalProjects": totalProjects,
        "concept_number": conceptNumber,
        "concept_name": conceptName,
        "collection": collection,
        "business_category": businessCategory,
        "assigned_to": assignedTo.map((x) => x).toList(),
        "concept_by_id": conceptById,
        "concept_by": conceptBy,
        "created_by_details": createdByDetails.toJson(),
        "approved_by_details": approvedByDetails.toJson(),
      };

  @override
  String toString() {
    return "$id, $presentationNumber, $createdBy, $approvedBy, $approvedAt, $status, $coverImage, $createdAt, $updatedAt, $totalProjects, $conceptNumber, $conceptName, $collection, $businessCategory, $assignedTo, $conceptById, $conceptBy, $createdByDetails, $approvedByDetails, $assignedToDetails, ";
  }
}
