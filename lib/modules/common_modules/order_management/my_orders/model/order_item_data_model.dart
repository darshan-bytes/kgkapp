class OrderItem {
  String? sId;
  String? createdAt;
  String? totalPrice;
  String? currency;
  int? createdBy;
  String? orderStatus;
  String? name;
  String? email;
  String? phone;
  int? uniqueId;
  int? items;
  int? totalQuantity;
  CreatedByDetails? createdByDetails;

  OrderItem(
      {this.sId,
      this.createdAt,
      this.totalPrice,
      this.currency,
      this.createdBy,
      this.orderStatus,
      this.name,
      this.email,
      this.phone,
      this.uniqueId,
      this.items,
      this.totalQuantity,
      this.createdByDetails});

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    totalPrice = json['total_price'];
    currency = json['currency'];
    createdBy = json['created_by'];
    orderStatus = json['order_status'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uniqueId = json['unique_id'];
    items = json['items'];
    totalQuantity = json['total_quantity'];
    createdByDetails = json['created_by_details'] != null ? CreatedByDetails.fromJson(json['created_by_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['total_price'] = totalPrice;
    data['currency'] = currency;
    data['created_by'] = createdBy;
    data['order_status'] = orderStatus;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['unique_id'] = uniqueId;
    data['items'] = items;
    data['total_quantity'] = totalQuantity;
    if (createdByDetails != null) {
      data['created_by_details'] = createdByDetails!.toJson();
    }
    return data;
  }
}

class CreatedByDetails {
  String? firstname;
  String? lastname;
  String? profilePic;
  String? userAccountId;
  String? email;
  String? userType;
  String? accountType;
  String? phoneCode;
  String? phone;
  String? orgName;
  String? customerAliasName;
  String? customerCode;
  String? profilePicUrl;

  CreatedByDetails(
      {this.firstname,
      this.lastname,
      this.profilePic,
      this.userAccountId,
      this.email,
      this.userType,
      this.accountType,
      this.phoneCode,
      this.phone,
      this.orgName,
      this.customerAliasName,
      this.customerCode,
      this.profilePicUrl});

  CreatedByDetails.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    profilePic = json['profile_pic'];
    userAccountId = json['user_account_id'];
    email = json['email'];
    userType = json['user_type'];
    accountType = json['account_type'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    orgName = json['org_name'];
    customerAliasName = json['customer_alias_name'];
    customerCode = json['customer_code'];
    profilePicUrl = json['profile_pic_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['profile_pic'] = profilePic;
    data['user_account_id'] = userAccountId;
    data['email'] = email;
    data['user_type'] = userType;
    data['account_type'] = accountType;
    data['phone_code'] = phoneCode;
    data['phone'] = phone;
    data['org_name'] = orgName;
    data['customer_alias_name'] = customerAliasName;
    data['customer_code'] = customerCode;
    data['profile_pic_url'] = profilePicUrl;
    return data;
  }
}
