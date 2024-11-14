class LanguageListModel {
  LanguageListModel({
    required this.filteredRecords,
    required this.totalRecords,
    required this.languageData,
    required this.limit,
    required this.page,
  });

  final int? filteredRecords;
  final int? totalRecords;
  final List<LanguageDatum> languageData;
  final int? limit;
  final int? page;

  LanguageListModel copyWith({
    int? filteredRecords,
    int? totalRecords,
    List<LanguageDatum>? languageData,
    int? limit,
    int? page,
  }) {
    return LanguageListModel(
      filteredRecords: filteredRecords ?? this.filteredRecords,
      totalRecords: totalRecords ?? this.totalRecords,
      languageData: languageData ?? this.languageData,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }

  factory LanguageListModel.fromJson(Map<String, dynamic> json) {
    return LanguageListModel(
      filteredRecords: json["filteredRecords"],
      totalRecords: json["totalRecords"],
      languageData: json["data"] == null ? [] : List<LanguageDatum>.from(json["data"]!.map((x) => LanguageDatum.fromJson(x))),
      limit: json["limit"],
      page: json["page"],
    );
  }

  Map<String, dynamic> toJson() => {
        "filteredRecords": filteredRecords,
        "totalRecords": totalRecords,
        "data": languageData.map((x) => x.toJson()).toList(),
        "limit": limit,
        "page": page,
      };

  @override
  String toString() {
    return "$filteredRecords, $totalRecords, $languageData, $limit, $page, ";
  }
}

class LanguageDatum {
  LanguageDatum({
    required this.name,
    required this.slug,
    required this.code,
    required this.textDirection,
    required this.dateFormat,
    required this.createdBy,
    required this.updatedBy,
    required this.status,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.flagIcon,
    required this.createdByDetails,
    required this.updatedByDetails,
  });

  final String? name;
  final String? slug;
  final String? code;
  final String? textDirection;
  final String? dateFormat;
  final String? createdBy;
  final String? updatedBy;
  final bool? status;
  final bool? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final String? flagIcon;
  final LanguageAtedByDetails? createdByDetails;
  final LanguageAtedByDetails? updatedByDetails;

  LanguageDatum copyWith({
    String? name,
    String? slug,
    String? code,
    String? textDirection,
    String? dateFormat,
    String? createdBy,
    String? updatedBy,
    bool? status,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? flagIcon,
    LanguageAtedByDetails? createdByDetails,
    LanguageAtedByDetails? updatedByDetails,
  }) {
    return LanguageDatum(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      code: code ?? this.code,
      textDirection: textDirection ?? this.textDirection,
      dateFormat: dateFormat ?? this.dateFormat,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      status: status ?? this.status,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      flagIcon: flagIcon ?? this.flagIcon,
      createdByDetails: createdByDetails ?? this.createdByDetails,
      updatedByDetails: updatedByDetails ?? this.updatedByDetails,
    );
  }

  factory LanguageDatum.fromJson(Map<String, dynamic> json) {
    return LanguageDatum(
      name: json["name"],
      slug: json["slug"],
      code: json["code"],
      textDirection: json["text_direction"],
      dateFormat: json["date_format"],
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      status: json["status"],
      isDefault: json["is_default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      id: json["id"],
      flagIcon: json["flag_icon"],
      createdByDetails: json["created_by_details"] == null ? null : LanguageAtedByDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : LanguageAtedByDetails.fromJson(json["updated_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "code": code,
        "text_direction": textDirection,
        "date_format": dateFormat,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "status": status,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
        "flag_icon": flagIcon,
        "created_by_details": createdByDetails?.toJson(),
        "updated_by_details": updatedByDetails?.toJson(),
      };

  @override
  String toString() {
    return "$name, $slug, $code, $textDirection, $dateFormat, $createdBy, $updatedBy, $status, $isDefault, $createdAt, $updatedAt, $id, $flagIcon, $createdByDetails, $updatedByDetails, ";
  }
}

class LanguageAtedByDetails {
  LanguageAtedByDetails({
    required this.firstname,
    required this.lastname,
    required this.profilePic,
    required this.userAccountId,
    required this.email,
    required this.userType,
    required this.accountType,
    required this.phoneCode,
    required this.phone,
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
  final String? profilePicUrl;

  LanguageAtedByDetails copyWith({
    String? firstname,
    String? lastname,
    String? profilePic,
    String? userAccountId,
    String? email,
    String? userType,
    String? accountType,
    String? phoneCode,
    String? phone,
    String? profilePicUrl,
  }) {
    return LanguageAtedByDetails(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      profilePic: profilePic ?? this.profilePic,
      userAccountId: userAccountId ?? this.userAccountId,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      accountType: accountType ?? this.accountType,
      phoneCode: phoneCode ?? this.phoneCode,
      phone: phone ?? this.phone,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    );
  }

  factory LanguageAtedByDetails.fromJson(Map<String, dynamic> json) {
    return LanguageAtedByDetails(
      firstname: json["firstname"],
      lastname: json["lastname"],
      profilePic: json["profile_pic"],
      userAccountId: json["user_account_id"],
      email: json["email"],
      userType: json["user_type"],
      accountType: json["account_type"],
      phoneCode: json["phone_code"],
      phone: json["phone"],
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
        "profile_pic_url": profilePicUrl,
      };

  @override
  String toString() {
    return "$firstname, $lastname, $profilePic, $userAccountId, $email, $userType, $accountType, $phoneCode, $phone, $profilePicUrl, ";
  }
}
