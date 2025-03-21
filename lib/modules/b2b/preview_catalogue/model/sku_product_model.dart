import 'package:kgk/kgk.dart';

class SkuProductModel {
  String? sId;
  String? contractNumber;
  List<MultipleFinishedViewImageShopByMetal>? multipleFinishedViewImage;
  String? productDescription;
  double? productPriceIntCurrency;
  String? businessCategoryCode;
  String? suid;
  String? crt;
  String? gms;
  String? metalColor1HexCode;
  String? businessCategoryName;
  String? jewelleryTypeName;
  String? kgkCollection;
  String? finalPrice;
  String? discountPrice;
  double? originalPrice;
  List<String>? images;

  SkuProductModel(
      {this.sId,
      this.contractNumber,
      this.multipleFinishedViewImage,
      this.productDescription,
      this.productPriceIntCurrency,
      this.businessCategoryCode,
      this.suid,
      this.crt,
      this.gms,
      this.metalColor1HexCode,
      this.businessCategoryName,
      this.jewelleryTypeName,
      this.kgkCollection,
      this.finalPrice,
      this.discountPrice,
      this.originalPrice,
      this.images});

  SkuProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contractNumber = json['contract_number'];
    if (json['multiple_finished_view_image'] != null) {
      multipleFinishedViewImage = <MultipleFinishedViewImageShopByMetal>[];
      json['multiple_finished_view_image'].forEach((v) {
        multipleFinishedViewImage!.add(MultipleFinishedViewImageShopByMetal.fromJson(v));
      });
    }
    productDescription = json['product_description'];
    productPriceIntCurrency = json['product_price_int_currency'];
    businessCategoryCode = json['business_category_code'];
    suid = json['suid'];
    crt = json['crt'];
    gms = json['gms'];
    metalColor1HexCode = json['metal_color_1_hex_code'];
    businessCategoryName = json['business_category_name'];
    jewelleryTypeName = json['jewellery_type_name'];
    kgkCollection = json['kgk_collection'];
    finalPrice = json['final_price'];
    discountPrice = json['discount_price'];
    originalPrice = json['original_price'];
    images = json['images']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['contract_number'] = contractNumber;
    if (multipleFinishedViewImage != null) {
      data['multiple_finished_view_image'] = multipleFinishedViewImage!.map((v) => v.toJson()).toList();
    }
    data['product_description'] = productDescription;
    data['product_price_int_currency'] = productPriceIntCurrency;
    data['business_category_code'] = businessCategoryCode;
    data['suid'] = suid;
    data['crt'] = crt;
    data['gms'] = gms;
    data['metal_color_1_hex_code'] = metalColor1HexCode;
    data['business_category_name'] = businessCategoryName;
    data['jewellery_type_name'] = jewelleryTypeName;
    data['kgk_collection'] = kgkCollection;
    data['final_price'] = finalPrice;
    data['discount_price'] = discountPrice;
    data['original_price'] = originalPrice;
    data['images'] = images;
    return data;
  }
}
