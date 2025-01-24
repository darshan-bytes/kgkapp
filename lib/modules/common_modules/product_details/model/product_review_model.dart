import 'package:kgk/kgk.dart';

class ProductReviewWrapperModel {
  int? filteredRecords;
  int? totalRecords;
  double? avgRating;
  List<ProductReviewModel>? dataList;
  bool userReviewSubmitted = false;
  String? page;
  String? limit;
  Map<String, int>? starCounts;

  ProductReviewWrapperModel({
    this.filteredRecords,
    this.dataList,
    this.avgRating,
    this.totalRecords,
    this.page,
    this.limit,
    this.userReviewSubmitted = false,
    this.starCounts,
  });

  ProductReviewWrapperModel.fromJson(Map<String, dynamic> json) {
    filteredRecords = json['filteredRecords']?.toString().toInt;
    totalRecords = json['totalRecords']?.toString().toInt;
    avgRating = json['avgRating']?.toString().toDouble;

    starCounts = json['starCounts'] != null ? Map<String, int>.from(json['starCounts']) : null;

    if (json['data'] != null) {
      dataList = <ProductReviewModel>[];
      json['data'].forEach((v) {
        dataList!.add(ProductReviewModel.fromJson(v));
      });
    }

    page = json['page'];
    limit = json['limit'];
    userReviewSubmitted = json['userReviewSubmited'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filteredRecords'] = filteredRecords;
    data['totalRecords'] = totalRecords;
    data['avgRating'] = avgRating;
    data['starCounts'] = starCounts;
    if (dataList != null) {
      data['data'] = dataList?.map((x) => x.toJson()).toList();
    }
    data['page'] = page;
    data['limit'] = limit;
    data['userReviewSubmited'] = userReviewSubmitted;
    return data;
  }
}

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
    rating = json['rating']?.toInt();
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
