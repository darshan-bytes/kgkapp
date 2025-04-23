class PresentationModel {
  PresentationModel({
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
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.shareWith,
    required this.v,
    required this.conceptName,
    required this.createdByDetails,
    required this.assignedToDetails,
  });

  final String? id;
  final String? presentationTemplateId;
  final String? conceptNumber;
  final String? conceptBy;
  final int? conceptById;
  final String? presentationNumber;
  final int? createdBy;
  final dynamic approvedBy;
  final List<String> assignedTo;
  final dynamic approvedAt;
  final String? cscCode;
  final String? status;
  final dynamic presentationFile;
  final dynamic coverImage;
  final bool? deleted;
  final DateTime? createdAt;
  final dynamic updatedAt;
  final List<dynamic> shareWith;
  final int? v;
  final String? conceptName;
  final CreatedByDetails? createdByDetails;
  final List<CreatedByDetails> assignedToDetails;

  factory PresentationModel.fromJson(Map<String, dynamic> json) {
    return PresentationModel(
      id: json["_id"],
      presentationTemplateId: json["presentation_template_id"],
      conceptNumber: json["concept_number"],
      conceptBy: json["concept_by"],
      conceptById: json["concept_by_id"],
      presentationNumber: json["presentation_number"],
      createdBy: json["created_by"],
      approvedBy: json["approved_by"],
      assignedTo: json["assigned_to"] == null ? [] : List<String>.from(json["assigned_to"]!.map((x) => x)),
      approvedAt: json["approved_at"],
      cscCode: json["csc_code"],
      status: json["status"],
      presentationFile: json["presentation_file"],
      coverImage: json["cover_image"],
      deleted: json["deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: json["updatedAt"],
      shareWith: json["share_with"] == null ? [] : List<dynamic>.from(json["share_with"]!.map((x) => x)),
      v: json["__v"],
      conceptName: json["concept_name"],
      createdByDetails: json["created_by_details"] == null ? null : CreatedByDetails.fromJson(json["created_by_details"]),
      assignedToDetails:
          json["assigned_to_details"] == null
              ? []
              : List<CreatedByDetails>.from(json["assigned_to_details"]!.map((x) => CreatedByDetails.fromJson(x))),
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
    "approved_at": approvedAt,
    "csc_code": cscCode,
    "status": status,
    "presentation_file": presentationFile,
    "cover_image": coverImage,
    "deleted": deleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt,
    "share_with": shareWith.map((x) => x).toList(),
    "__v": v,
    "concept_name": conceptName,
    "created_by_details": createdByDetails?.toJson(),
    "assigned_to_details": assignedToDetails.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() {
    return "$id, $presentationTemplateId, $conceptNumber, $conceptBy, $conceptById, $presentationNumber, $createdBy, $approvedBy, $assignedTo, $approvedAt, $cscCode, $status, $presentationFile, $coverImage, $deleted, $createdAt, $updatedAt, $shareWith, $v, $conceptName, $createdByDetails, $assignedToDetails, ";
  }
}

class CreatedByDetails {
  CreatedByDetails({
    required this.firstname,
    required this.lastname,
    required this.profilePic,
    required this.userAccountId,
    required this.email,
    required this.userType,
    required this.accountType,
    required this.phoneCode,
    required this.phone,
    required this.orgName,
    required this.customerAliasName,
    required this.customerCode,
    required this.profilePicUrl,
  });

  final String? firstname;
  final String? lastname;
  final String? profilePic;
  final String? userAccountId;
  final String? email;
  final String? userType;
  final String? accountType;
  final String? phoneCode;
  final String? phone;
  final String? orgName;
  final String? customerAliasName;
  final String? customerCode;
  final String? profilePicUrl;

  factory CreatedByDetails.fromJson(Map<String, dynamic> json) {
    return CreatedByDetails(
      firstname: json["firstname"],
      lastname: json["lastname"],
      profilePic: json["profile_pic"],
      userAccountId: json["user_account_id"],
      email: json["email"],
      userType: json["user_type"],
      accountType: json["account_type"],
      phoneCode: json["phone_code"],
      phone: json["phone"],
      orgName: json["org_name"],
      customerAliasName: json["customer_alias_name"],
      customerCode: json["customer_code"],
      profilePicUrl: json["profile_pic_url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "profile_pic": profilePic,
    "user_account_id": userAccountId,
    "email": email,
    "user_type": userType,
    "account_type": accountType,
    "phone_code": phoneCode,
    "phone": phone,
    "org_name": orgName,
    "customer_alias_name": customerAliasName,
    "customer_code": customerCode,
    "profile_pic_url": profilePicUrl,
  };

  @override
  String toString() {
    return "$firstname, $lastname, $profilePic, $userAccountId, $email, $userType, $accountType, $phoneCode, $phone, $orgName, $customerAliasName, $customerCode, $profilePicUrl, ";
  }
}
