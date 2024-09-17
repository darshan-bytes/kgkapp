import 'package:kgk/kgk.dart';

class StyleDesignModel{
  String? id;
  String? productImageUrl;
  String? designId;
  String? styleId;
  String? productName;
  String? userImageUrl;
  String? userName;
  String? diamondType;
  String? diamondShape;
  ProjectStatus? status;
  String? firstType;
  String? secondType;
  String? thirdType;
  String? firstGram;
  String? secondGram;
  String? thirdGram;
  String? numberOfProduct;

  StyleDesignModel({
    this.id,
    this.productImageUrl,
    this.designId,
    this.styleId,
    this.productName,
    this.userImageUrl,
    this.userName,
    this.diamondType,
    this.diamondShape,
    this.status,
    this.firstType,
    this.secondType,
    this.thirdType,
    this.firstGram,
    this.secondGram,
    this.thirdGram,
    this.numberOfProduct,
  });

  factory StyleDesignModel.fromJson(Map<String, dynamic> json) {
    return StyleDesignModel(
      id: json['id'],
      productImageUrl: json['productImageUrl'],
      designId: json['designId'],
      styleId: json['styleId'],
      productName: json['productName'],
      userImageUrl: json['userImageUrl'],
      userName: json['userName'],
      diamondType: json['diamondType'],
      diamondShape: json['diamondShape'],
      status: json['status'],
      firstType: json['firstType'],
      secondType: json['secondType'],
      thirdType: json['thirdType'],
      firstGram: json['firstGram'],
      secondGram: json['secondGram'],
      thirdGram: json['thirdGram'],
      numberOfProduct: json['numberOfProduct'],
    );
  }
}