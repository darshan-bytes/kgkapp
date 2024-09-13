import 'package:kgk/kgk.dart';

class ProductReviewModel {
  String? status;
  String? userId;
  String? productId;
  String? title;
  String? description;
  String? businessType;
  int? rating;
  String? images;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  UserIdDetails? userIdDetails;

  ProductReviewModel({
    this.status,
    this.userId,
    this.productId,
    this.title,
    this.description,
    this.businessType,
    this.rating,
    this.images,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userIdDetails,
  });

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id']?.toString();
    productId = json['product_id'];
    title = json['title'];
    description = json['description'];
    businessType = json['business_type'];
    rating = json['rating'];
    images = json['images'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    userIdDetails = json['user_id_details'] != null ? UserIdDetails.fromJson(json['user_id_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['title'] = title;
    data['description'] = description;
    data['business_type'] = businessType;
    data['rating'] = rating;
    data['images'] = images;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (userIdDetails != null) {
      data['user_id_details'] = userIdDetails!.toJson();
    }
    return data;
  }
}

extension ProductReviewModelExtension on ProductReviewModel {
  List<String>? get displayImage => images?.split(',').map((e) => e.trim().setMediaUrl).toList();
}
