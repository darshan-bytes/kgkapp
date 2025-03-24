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
  final AtedByDetails? createdByDetails;
  final AtedByDetails? updatedByDetails;
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
      createdByDetails: json["created_by_details"] == null ? null : AtedByDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : AtedByDetails.fromJson(json["updated_by_details"]),
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

class AtedByDetails {
  AtedByDetails({
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

  factory AtedByDetails.fromJson(Map<String, dynamic> json) {
    return AtedByDetails(
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
}
