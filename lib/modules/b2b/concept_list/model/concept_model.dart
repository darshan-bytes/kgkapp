import 'package:kgk/kgk.dart';

class ConceptModel {
  ConceptModel({
    required this.id,
    required this.conceptNumber,
    required this.conceptName,
    required this.conceptBy,
    required this.collectionName,
    required this.businessCategory,
    required this.country,
    required this.conceptById,
    required this.cscCode,
    required this.receivedAt,
    required this.importedFrom,
    required this.status,
    required this.assignedTo,
    required this.description,
    required this.isPrivate,
    required this.createdBy,
    required this.updatedBy,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.files,
    required this.v,
    required this.presentation,
    required this.presentationCount,
    this.conceptNumberNumeric,
    this.conceptCustomerIdDetails,
    this.assignedToDetails,
    this.createdByDetails,
    this.updatedByDetails,
  });

  final String? id;
  final String? conceptNumber;
  final String? conceptName;
  final String? conceptBy;
  final String? collectionName;
  final String? businessCategory;
  final String? country;
  final int? conceptById;
  final String? cscCode;
  final DateTime? receivedAt;
  final String? importedFrom;
  final String? status;
  final List<String> assignedTo;
  final String? description;
  final bool? isPrivate;
  final int? createdBy;
  final int? updatedBy;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> files;
  final int? v;
  final List<Presentation> presentation;
  final int? presentationCount;
  final int? conceptNumberNumeric;
  final UserIdDetails? conceptCustomerIdDetails;
  final List<UserIdDetails>? assignedToDetails;
  final UserIdDetails? createdByDetails;
  final UserIdDetails? updatedByDetails;

  factory ConceptModel.fromJson(Map<String, dynamic> json) {
    return ConceptModel(
      id: json["_id"],
      conceptNumber: json["concept_number"],
      conceptName: json["concept_name"],
      conceptBy: json["concept_by"],
      collectionName: json["collection_name"],
      businessCategory: json["business_category"],
      country: json["country"],
      conceptById: json["concept_by_id"],
      cscCode: json["csc_code"],
      receivedAt: DateTime.tryParse(json["received_at"] ?? ""),
      importedFrom: json["imported_from"],
      status: json["status"],
      assignedTo: json["assigned_to"] == null ? [] : List<String>.from(json["assigned_to"]!.map((x) => x)),
      description: json["description"],
      isPrivate: json["is_private"],
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      deleted: json["deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      files: json["files"] == null ? [] : List<dynamic>.from(json["files"]!.map((x) => x)),
      v: json["__v"],
      presentation: json["presentation"] == null ? [] : List<Presentation>.from(json["presentation"]!.map((x) => Presentation.fromJson(x))),
      presentationCount: json["presentation_count"],
      conceptNumberNumeric: json["concept_number_numeric"],
      conceptCustomerIdDetails:
          json["concept_customer_id_details"] == null ? null : UserIdDetails.fromJson(json["concept_customer_id_details"]),
      assignedToDetails:
          json["assigned_to_details"] == null
              ? []
              : List<UserIdDetails>.from(json["assigned_to_details"]!.map((x) => UserIdDetails.fromJson(x))),
      createdByDetails: json["created_by_details"] == null ? null : UserIdDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : UserIdDetails.fromJson(json["updated_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "concept_number": conceptNumber,
    "concept_name": conceptName,
    "concept_by": conceptBy,
    "collection_name": collectionName,
    "business_category": businessCategory,
    "country": country,
    "concept_by_id": conceptById,
    "csc_code": cscCode,
    "received_at": receivedAt?.toIso8601String(),
    "imported_from": importedFrom,
    "status": status,
    "assigned_to": assignedTo.map((x) => x).toList(),
    "description": description,
    "is_private": isPrivate,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted": deleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "files": files.map((x) => x).toList(),
    "__v": v,
    "presentation": presentation.map((x) => x.toJson()).toList(),
    "presentation_count": presentationCount,
    "concept_number_numeric": conceptNumberNumeric,
    "concept_customer_id_details": conceptCustomerIdDetails?.toJson(),
    "assigned_to_details": assignedToDetails?.map((x) => x.toJson()).toList(),
    "created_by_details": createdByDetails?.toJson(),
    "updated_by_details": updatedByDetails?.toJson(),
  };

  @override
  String toString() {
    return "$id, $conceptNumber, $conceptName, $conceptBy, $collectionName, $businessCategory, $country, $conceptById, $cscCode, $receivedAt, $importedFrom, $status, $assignedTo, $description, $isPrivate, $createdBy, $updatedBy, $deleted, $createdAt, $updatedAt, $files, $v, $presentation, $presentationCount, $conceptNumberNumeric, $conceptCustomerIdDetails, $assignedToDetails, $createdByDetails, $updatedByDetails, ";
  }
}

class Presentation {
  Presentation({
    required this.id,
    required this.presentationTemplateId,
    required this.conceptNumber,
    required this.conceptBy,
    required this.conceptById,
    required this.presentationNumber,
    required this.createdBy,
    required this.approvedBy,
    required this.assignedTo,
    required this.approvedAt,
    required this.cscCode,
    required this.status,
    required this.presentationFile,
    required this.coverImage,
    required this.data,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.shareWith,
    required this.v,
    required this.updatedBy,
    this.conceptName,
    this.createdByDetails,
    this.updatedByDetails,
    this.approvedByDetails,
    this.assignedToDetails,
  });

  final String? id;
  final String? presentationTemplateId;
  final String? conceptNumber;
  final String? conceptBy;
  final int? conceptById;
  final String? presentationNumber;
  final int? createdBy;
  final int? approvedBy;
  final List<String> assignedTo;
  final DateTime? approvedAt;
  final String? cscCode;
  String? status;
  final dynamic presentationFile;
  final dynamic coverImage;
  final Map<String, dynamic>? data;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> shareWith;
  final int? v;
  final int? updatedBy;
  final String? conceptName;
  final UserIdDetails? createdByDetails;
  final UserIdDetails? updatedByDetails;
  final UserIdDetails? approvedByDetails;
  final List<UserIdDetails>? assignedToDetails;

  factory Presentation.fromJson(Map<String, dynamic> json) {
    return Presentation(
      id: json["_id"],
      presentationTemplateId: json["presentation_template_id"],
      conceptNumber: json["concept_number"],
      conceptBy: json["concept_by"],
      conceptById: json["concept_by_id"],
      presentationNumber: json["presentation_number"],
      createdBy: json["created_by"],
      approvedBy: json["approved_by"],
      assignedTo: json["assigned_to"] == null ? [] : List<String>.from(json["assigned_to"]!.map((x) => x)),
      approvedAt: DateTime.tryParse(json["approved_at"] ?? ""),
      cscCode: json["csc_code"],
      status: json["status"],
      presentationFile: json["presentation_file"],
      coverImage: json["cover_image"],
      data: json["data"],
      deleted: json["deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      shareWith: json["share_with"] == null ? [] : List<dynamic>.from(json["share_with"]!.map((x) => x)),
      v: json["__v"],
      updatedBy: json["updated_by"],
      conceptName: json["concept_name"],
      createdByDetails: json["created_by_details"] == null ? null : UserIdDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : UserIdDetails.fromJson(json["updated_by_details"]),
      approvedByDetails: json["approved_by_details"] == null ? null : UserIdDetails.fromJson(json["approved_by_details"]),
      assignedToDetails:
          json["assigned_to_details"] == null
              ? []
              : List<UserIdDetails>.from(json["assigned_to_details"]!.map((x) => UserIdDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "presentation_template_id": presentationTemplateId,
    "concept_number": conceptNumber,
    "concept_by": conceptBy,
    "concept_by_id": conceptById,
    "presentation_number": presentationNumber,
    "created_by": createdBy,
    "approved_by": approvedBy,
    "assigned_to": assignedTo.map((x) => x).toList(),
    "approved_at": approvedAt?.toIso8601String(),
    "csc_code": cscCode,
    "status": status,
    "presentation_file": presentationFile,
    "cover_image": coverImage,
    "data": data,
    "deleted": deleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "share_with": shareWith.map((x) => x).toList(),
    "__v": v,
    "updated_by": updatedBy,
    "concept_name": conceptName,
    "created_by_details": createdByDetails?.toJson(),
    "updated_by_details": updatedByDetails?.toJson(),
    "approved_by_details": approvedByDetails?.toJson(),
    "assigned_to_details": assignedToDetails?.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() {
    return "$id, $presentationTemplateId, $conceptNumber, $conceptBy, $conceptById, $presentationNumber, $createdBy, $approvedBy, $assignedTo, $approvedAt, $cscCode, $status, $presentationFile, $coverImage, $deleted, $createdAt, $updatedAt, $shareWith, $v, $updatedBy, $conceptName, $createdByDetails, $updatedByDetails, $approvedByDetails, $assignedToDetails, ";
  }
}
