import 'package:kgk/kgk.dart';

class PddDataModel {
  String? sId;
  String? image;
  String? presentationNumber;
  int? createdBy;
  int? approvedBy;
  String? approvedAt;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? totalProjects;
  String? conceptNumber;
  String? conceptName;
  String? collection;
  String? businessCategory;
  List<String>? assignedTo;
  UserIdDetails? createdByDetails;
  UserIdDetails? approvedByDetails;
  List<UserIdDetails>? assignedToDetails;

  PddDataModel(
      {this.sId,
      this.image,
      this.presentationNumber,
      this.createdBy,
      this.approvedBy,
      this.approvedAt,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.totalProjects,
      this.conceptNumber,
      this.conceptName,
      this.collection,
      this.businessCategory,
      this.assignedTo,
      this.createdByDetails,
      this.approvedByDetails,
      this.assignedToDetails});

  PddDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    presentationNumber = json['presentation_number'];
    createdBy = json['created_by'];
    approvedBy = json['approved_by'];
    approvedAt = json['approved_at'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalProjects = json['totalProjects'];
    conceptNumber = json['concept_number'];
    conceptName = json['concept_name'];
    collection = json['collection'];
    businessCategory = json['business_category'];
    assignedTo = json['assigned_to'].cast<String>();
    createdByDetails = json['created_by_details'] != null ? UserIdDetails.fromJson(json['created_by_details']) : null;
    approvedByDetails = json['approved_by_details'] != null ? UserIdDetails.fromJson(json['approved_by_details']) : null;
    if (json['assigned_to_details'] != null) {
      assignedToDetails = <UserIdDetails>[];
      json['assigned_to_details'].forEach((v) {
        assignedToDetails!.add(UserIdDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['image'] = image;
    data['presentation_number'] = presentationNumber;
    data['created_by'] = createdBy;
    data['approved_by'] = approvedBy;
    data['approved_at'] = approvedAt;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['totalProjects'] = totalProjects;
    data['concept_number'] = conceptNumber;
    data['concept_name'] = conceptName;
    data['collection'] = collection;
    data['business_category'] = businessCategory;
    data['assigned_to'] = assignedTo;
    if (createdByDetails != null) {
      data['created_by_details'] = createdByDetails!.toJson();
    }
    if (approvedByDetails != null) {
      data['approved_by_details'] = approvedByDetails!.toJson();
    }
    if (assignedToDetails != null) {
      data['assigned_to_details'] = assignedToDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

extension ProjectStatusExtension on PddDataModel {
  ProjectStatus? get projectStatus {
    switch (status) {
      case "approved":
        return ProjectStatus.approved;
      case "pending":
        return ProjectStatus.pending;
      default:
        return null;
    }
  }
}
