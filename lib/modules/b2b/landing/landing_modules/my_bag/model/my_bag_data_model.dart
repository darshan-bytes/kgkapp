import 'package:kgk/kgk.dart';

class MyBagDataModel {
  String? createdAt;
  String? updatedAt;
  String? commodity;
  String? userId;
  bool? status;
  List<MyBagProductData>? products;
  String? sId;
  int? iV;

  MyBagDataModel({
    this.createdAt,
    this.updatedAt,
    this.commodity,
    this.userId,
    this.status,
    this.products,
    this.sId,
    this.iV,
  });

  MyBagDataModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    commodity = json['commodity'];
    userId = json['user_id'].toString();
    status = json['status'];
    if (json['products'] != null) {
      products = <MyBagProductData>[];
      json['products'].forEach((v) {
        products!.add(MyBagProductData.fromJson(v));
      });
    }
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['commodity'] = commodity;
    data['user_id'] = userId;
    data['status'] = status;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['__v'] = iV;
    return data;
  }
}

extension MyBagDataModelExtension on MyBagDataModel {
  Commodity get displayCommodity => Commodity.values.firstWhereOrNull((element) => element.value == commodity) ?? Commodity.diamond;
}

class MyBagProductData {
  String? suid;
  int? quantity;
  String? sId;

  MyBagProductData({this.suid, this.quantity, this.sId});

  MyBagProductData.fromJson(Map<String, dynamic> json) {
    suid = json['suid'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suid'] = suid;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
