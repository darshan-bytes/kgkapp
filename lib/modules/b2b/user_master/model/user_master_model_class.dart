import 'package:kgk/kgk.dart';

class UserMasterListingModelClass {
  String? createdAt;
  String? updatedAt;
  String? id;
  String? email;
  String? userType;
  bool? status;
  String? createdBy;
  CustomerUser? customerUser;
  UserIdDetails? createdByDetails;

  UserMasterListingModelClass(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.email,
      this.userType,
      this.status,
      this.createdBy,
      this.customerUser,
      this.createdByDetails});

  UserMasterListingModelClass.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
    email = json['email'];
    userType = json['user_type'];
    status = json['status'];
    createdBy = json['created_by'];
    customerUser = json['customerUser'] != null ? CustomerUser.fromJson(json['customerUser']) : null;
    createdByDetails = json['created_by_details'] != null ? UserIdDetails.fromJson(json['created_by_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['id'] = id;
    data['email'] = email;
    data['user_type'] = userType;
    data['status'] = status;
    data['created_by'] = createdBy;
    if (customerUser != null) {
      data['customerUser'] = customerUser!.toJson();
    }
    if (createdByDetails != null) {
      data['created_by_details'] = createdByDetails!.toJson();
    }
    return data;
  }
}

extension UserMasterListingModelClassExtension on UserMasterListingModelClass {
  String? get businessType => customerUser?.customerOrg?.businessTypeDetails.isNotNullNorEmpty == true
      ? customerUser?.customerOrg?.businessTypeDetails?.first.name
      : null;
}

class CustomerUser {
  String? userAccountId;
  String? firstname;
  String? lastname;
  String? phoneCode;
  String? phone;
  String? customerOrgId;
  String? profilePic;
  String? roleId;
  CustomerOrg? customerOrg;
  Role? role;
  String? profilePicUrl;

  CustomerUser(
      {this.userAccountId,
      this.firstname,
      this.lastname,
      this.phoneCode,
      this.phone,
      this.customerOrgId,
      this.profilePic,
      this.roleId,
      this.customerOrg,
      this.role,
      this.profilePicUrl});

  CustomerUser.fromJson(Map<String, dynamic> json) {
    userAccountId = json['user_account_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    customerOrgId = json['customer_org_id'];
    profilePic = json['profile_pic'];
    roleId = json['role_id'];
    customerOrg = json['customerOrg'] != null ? CustomerOrg.fromJson(json['customerOrg']) : null;
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    profilePicUrl = json['profile_pic_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_account_id'] = userAccountId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone_code'] = phoneCode;
    data['phone'] = phone;
    data['customer_org_id'] = customerOrgId;
    data['profile_pic'] = profilePic;
    data['role_id'] = roleId;
    if (customerOrg != null) {
      data['customerOrg'] = customerOrg!.toJson();
    }
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['profile_pic_url'] = profilePicUrl;
    return data;
  }
}

extension CustomerUserExtension on CustomerUser {
  String get fullName => '${firstname ?? ""} ${lastname ?? ""}';
}

class CustomerOrg {
  String? id;
  String? name;
  String? businessType;
  String? accountType;
  String? subareaCode;
  List<BusinessTypeDetails>? businessTypeDetails;

  CustomerOrg({this.id, this.name, this.businessType, this.accountType, this.subareaCode, this.businessTypeDetails});

  CustomerOrg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    businessType = json['business_type'];
    accountType = json['account_type'];
    subareaCode = json['subarea_code'];
    if (json['business_type_details'] != null) {
      businessTypeDetails = <BusinessTypeDetails>[];
      json['business_type_details'].forEach((v) {
        businessTypeDetails!.add(BusinessTypeDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['business_type'] = businessType;
    data['account_type'] = accountType;
    data['subarea_code'] = subareaCode;
    if (businessTypeDetails != null) {
      data['business_type_details'] = businessTypeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessTypeDetails {
  String? id;
  String? name;

  BusinessTypeDetails({this.id, this.name});

  BusinessTypeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
