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
    required this.commentList,
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
  final UserIdDetails? createdByDetails;
  final List<MyInquiryComment> commentList;

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
      createdByDetails: json["created_by_details"] != null ? UserIdDetails.fromJson(json["created_by_details"]) : null,
      commentList:
          json["commentList"] == null ? [] : List<MyInquiryComment>.from(json["commentList"]!.map((x) => MyInquiryComment.fromJson(x))),
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
    "created_by_details": createdByDetails?.toJson(),
    "commentList": commentList.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() {
    return "$createdAt, $updatedAt, $id, $name, $email, $inquiryType, $commodity, $inquiryContextId, $contextId, $createdBy, $status, $assignedToDetails, $createdByDetails, $commentList";
  }
}

class MyInquiryComment {
  MyInquiryComment({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.inquiryId,
    required this.comments,
    required this.senderId,
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.profile,
  });

  final DateTime? createdAt;
  final dynamic updatedAt;
  final String? id;
  final String? inquiryId;
  final String? comments;
  final String? senderId;
  final String? userId;
  final String? firstname;
  final String? lastname;
  final String? profile;

  factory MyInquiryComment.fromJson(Map<String, dynamic> json) {
    return MyInquiryComment(
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: json["updated_at"],
      id: json["id"],
      inquiryId: json["inquiry_id"],
      comments: json["comments"],
      senderId: json["sender_id"],
      userId: json["user_id"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      profile: json["profile"],
    );
  }

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "id": id,
    "inquiry_id": inquiryId,
    "comments": comments,
    "sender_id": senderId,
    "user_id": userId,
    "firstname": firstname,
    "lastname": lastname,
    "profile": profile,
  };

  String? get fullName => (firstname == null && lastname == null) ? null : '${firstname ?? ''} ${lastname ?? ''}'.trim();
}
