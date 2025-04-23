import 'package:kgk/kgk.dart';

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
  double? totalQuantity;
  UserIdDetails? createdByDetails;
  String? commodity;

  OrderItem({
    this.sId,
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
    this.createdByDetails,
    this.commodity,
  });

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    totalPrice = json['total_price']?.toString();
    currency = json['currency'];
    createdBy = json['created_by'];
    orderStatus = json['order_status'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uniqueId = json['unique_id'];
    items = json['items'];
    totalQuantity = json['total_quantity']?.toString().toDouble;
    createdByDetails = json['created_by_details'] != null ? UserIdDetails.fromJson(json['created_by_details']) : null;
    commodity = json['commodity'];
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
    data['commodity'] = commodity;
    return data;
  }
}
