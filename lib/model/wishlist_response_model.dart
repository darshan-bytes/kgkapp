class WishlistResponseModel {
  String? productId;
  String? listingName;
  String? customerId;
  String? id;
  String? createdAt;
  String? deletedAt;

  WishlistResponseModel({this.productId, this.listingName, this.customerId, this.id, this.createdAt, this.deletedAt});

  WishlistResponseModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    listingName = json['listing_name'];
    customerId = json['customer_id'];
    id = json['id'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['listing_name'] = listingName;
    data['customer_id'] = customerId;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
