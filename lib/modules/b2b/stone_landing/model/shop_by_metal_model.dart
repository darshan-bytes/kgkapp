import 'package:kgk/kgk.dart';

class NewLaunchedModel {
  NewLaunchedModel({
    required this.totalRecords,
    required this.filteredRecords,
    required this.data,
  });

  final int? totalRecords;
  final int? filteredRecords;
  final List<ShopByMetalDatum> data;

  NewLaunchedModel copyWith({
    int? totalRecords,
    int? filteredRecords,
    List<ShopByMetalDatum>? data,
  }) {
    return NewLaunchedModel(
      totalRecords: totalRecords ?? this.totalRecords,
      filteredRecords: filteredRecords ?? this.filteredRecords,
      data: data ?? this.data,
    );
  }

  factory NewLaunchedModel.fromJson(Map<String, dynamic> json) {
    return NewLaunchedModel(
      totalRecords: json["totalRecords"],
      filteredRecords: json["filteredRecords"],
      data: json["data"] == null ? [] : List<ShopByMetalDatum>.from(json["data"]!.map((x) => ShopByMetalDatum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "totalRecords": totalRecords,
        "filteredRecords": filteredRecords,
        "data": data.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$totalRecords, $filteredRecords, $data, ";
  }
}

class ShopByMetalDatum {
  ShopByMetalDatum({
    required this.id,
    required this.suid,
    required this.exclusive,
    required this.businessCategory,
    required this.contractNoSkuNo,
    required this.guestUser,
    required this.jewellleryTypeCode,
    required this.styleNo,
    required this.kgkCollection,
    required this.cscName,
    required this.productPriceIntCurrency,
    required this.subareaName,
    required this.cscCode,
    required this.customerCode,
    required this.productDescription,
    required this.componentDetails,
    required this.multipleFinishedViewImage,
    required this.finalPrice,
    required this.discountPrice,
  });

  final String? id;
  final String? suid;
  final String? exclusive;
  final String? businessCategory;
  final String? contractNoSkuNo;
  final String? guestUser;
  final String? jewellleryTypeCode;
  final String? styleNo;
  final String? kgkCollection;
  final String? cscName;
  final String? productPriceIntCurrency;
  final String? subareaName;
  final String? cscCode;
  final String? customerCode;
  final String? productDescription;
  final List<ComponentDetailShopByMetal> componentDetails;
  final List<MultipleFinishedViewImageShopByMetal> multipleFinishedViewImage;
  final double? finalPrice;
  final double? discountPrice;

  ShopByMetalDatum copyWith({
    String? id,
    String? suid,
    String? exclusive,
    String? businessCategory,
    String? contractNoSkuNo,
    String? guestUser,
    String? jewellleryTypeCode,
    String? styleNo,
    String? kgkCollection,
    String? cscName,
    String? productPriceIntCurrency,
    String? subareaName,
    String? cscCode,
    String? customerCode,
    String? productDescription,
    List<ComponentDetailShopByMetal>? componentDetails,
    List<MultipleFinishedViewImageShopByMetal>? multipleFinishedViewImage,
    double? finalPrice,
    double? discountPrice,
  }) {
    return ShopByMetalDatum(
      id: id ?? this.id,
      suid: suid ?? this.suid,
      exclusive: exclusive ?? this.exclusive,
      businessCategory: businessCategory ?? this.businessCategory,
      contractNoSkuNo: contractNoSkuNo ?? this.contractNoSkuNo,
      guestUser: guestUser ?? this.guestUser,
      jewellleryTypeCode: jewellleryTypeCode ?? this.jewellleryTypeCode,
      styleNo: styleNo ?? this.styleNo,
      kgkCollection: kgkCollection ?? this.kgkCollection,
      cscName: cscName ?? this.cscName,
      productPriceIntCurrency: productPriceIntCurrency ?? this.productPriceIntCurrency,
      subareaName: subareaName ?? this.subareaName,
      cscCode: cscCode ?? this.cscCode,
      customerCode: customerCode ?? this.customerCode,
      productDescription: productDescription ?? this.productDescription,
      componentDetails: componentDetails ?? this.componentDetails,
      multipleFinishedViewImage: multipleFinishedViewImage ?? this.multipleFinishedViewImage,
      finalPrice: finalPrice ?? this.finalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
    );
  }

  factory ShopByMetalDatum.fromJson(Map<String, dynamic> json) {
    return ShopByMetalDatum(
      id: json["_id"],
      suid: json["suid"],
      exclusive: json["exclusive"],
      businessCategory: json["business_category"],
      contractNoSkuNo: json["contract_no_sku_no"],
      guestUser: json["guest_user"],
      jewellleryTypeCode: json["jewelllery_type-code"],
      styleNo: json["style_no"],
      kgkCollection: json["kgk_collection"],
      cscName: json["csc_name"],
      productPriceIntCurrency: json["product_price_int_currency"],
      subareaName: json["subarea_name"],
      cscCode: json["csc_code"],
      customerCode: json["customer_code"],
      productDescription: json["product_description"],
      componentDetails: json["component_details"] == null
          ? []
          : List<ComponentDetailShopByMetal>.from(json["component_details"]!.map((x) => ComponentDetailShopByMetal.fromJson(x))),
      multipleFinishedViewImage: json["multiple_finished_view_image"] == null
          ? []
          : List<MultipleFinishedViewImageShopByMetal>.from(
              json["multiple_finished_view_image"]!.map((x) => MultipleFinishedViewImageShopByMetal.fromJson(x))),
      finalPrice: json["final_price"],
      discountPrice: json["discount_price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "suid": suid,
        "exclusive": exclusive,
        "business_category": businessCategory,
        "contract_no_sku_no": contractNoSkuNo,
        "guest_user": guestUser,
        "jewelllery_type-code": jewellleryTypeCode,
        "style_no": styleNo,
        "kgk_collection": kgkCollection,
        "csc_name": cscName,
        "product_price_int_currency": productPriceIntCurrency,
        "subarea_name": subareaName,
        "csc_code": cscCode,
        "customer_code": customerCode,
        "product_description": productDescription,
        "component_details": componentDetails.map((x) => x.toJson()).toList(),
        "multiple_finished_view_image": multipleFinishedViewImage.map((x) => x.toJson()).toList(),
        "final_price": finalPrice,
        "discount_price": discountPrice,
      };

  @override
  String toString() {
    return "$id, $suid, $exclusive, $businessCategory, $contractNoSkuNo, $guestUser, $jewellleryTypeCode, $styleNo, $kgkCollection, $cscName, $productPriceIntCurrency, $subareaName, $cscCode, $customerCode, $productDescription, $componentDetails, $multipleFinishedViewImage, $finalPrice, $discountPrice, ";
  }
}

class ComponentDetailShopByMetal {
  ComponentDetailShopByMetal({
    required this.brokenQty1,
    required this.commodity,
    required this.commodityNameRefSuid,
    required this.commodityNameSuid,
    required this.consumedQty1,
    required this.consumedQty2,
    required this.lossQty1,
    required this.lotCode,
    required this.lotId,
    required this.rmName,
    required this.rmNameRefSuid,
    required this.rmNameSuid,
    required this.shape,
    required this.shapeRefSuid,
    required this.shapeSuid,
    required this.totalQty1,
    required this.totalQty2,
    required this.uom1,
    required this.uom2,
    required this.karatage,
  });

  final double? brokenQty1;
  final String? commodity;
  final int? commodityNameRefSuid;
  final String? commodityNameSuid;
  final int? consumedQty1;
  final int? consumedQty2;
  final int? lossQty1;
  final String? lotCode;
  final String? lotId;
  final String? rmName;
  final int? rmNameRefSuid;
  final String? rmNameSuid;
  final String? shape;
  final int? shapeRefSuid;
  final String? shapeSuid;
  final int? totalQty1;
  final int? totalQty2;
  final String? uom1;
  final String? uom2;
  final String? karatage;

  ComponentDetailShopByMetal copyWith({
    double? brokenQty1,
    String? commodity,
    int? commodityNameRefSuid,
    String? commodityNameSuid,
    int? consumedQty1,
    int? consumedQty2,
    int? lossQty1,
    String? lotCode,
    String? lotId,
    String? rmName,
    int? rmNameRefSuid,
    String? rmNameSuid,
    String? shape,
    int? shapeRefSuid,
    String? shapeSuid,
    int? totalQty1,
    int? totalQty2,
    String? uom1,
    String? uom2,
    String? karatage,
  }) {
    return ComponentDetailShopByMetal(
      brokenQty1: brokenQty1 ?? this.brokenQty1,
      commodity: commodity ?? this.commodity,
      commodityNameRefSuid: commodityNameRefSuid ?? this.commodityNameRefSuid,
      commodityNameSuid: commodityNameSuid ?? this.commodityNameSuid,
      consumedQty1: consumedQty1 ?? this.consumedQty1,
      consumedQty2: consumedQty2 ?? this.consumedQty2,
      lossQty1: lossQty1 ?? this.lossQty1,
      lotCode: lotCode ?? this.lotCode,
      lotId: lotId ?? this.lotId,
      rmName: rmName ?? this.rmName,
      rmNameRefSuid: rmNameRefSuid ?? this.rmNameRefSuid,
      rmNameSuid: rmNameSuid ?? this.rmNameSuid,
      shape: shape ?? this.shape,
      shapeRefSuid: shapeRefSuid ?? this.shapeRefSuid,
      shapeSuid: shapeSuid ?? this.shapeSuid,
      totalQty1: totalQty1 ?? this.totalQty1,
      totalQty2: totalQty2 ?? this.totalQty2,
      uom1: uom1 ?? this.uom1,
      uom2: uom2 ?? this.uom2,
      karatage: karatage ?? this.karatage,
    );
  }

  factory ComponentDetailShopByMetal.fromJson(Map<String, dynamic> json) {
    return ComponentDetailShopByMetal(
      brokenQty1: json["BrokenQty1"]?.toString().toDouble,
      commodity: json["Commodity"],
      commodityNameRefSuid: json["CommodityNameRefSuid"],
      commodityNameSuid: json["CommodityNameSuid"],
      consumedQty1: json["ConsumedQty1"]?.toString().toInt,
      consumedQty2: json["ConsumedQty2"]?.toString().toInt,
      lossQty1: json["LossQty1"]?.toString().toInt,
      lotCode: json["LotCode"],
      lotId: json["LotId"]?.toString(),
      rmName: json["RMName"],
      rmNameRefSuid: json["RMNameRefSuid"],
      rmNameSuid: json["RMNameSuid"],
      shape: json["Shape"],
      shapeRefSuid: json["ShapeRefSuid"],
      shapeSuid: json["ShapeSuid"],
      totalQty1: json["TotalQty1"]?.toString().toInt,
      totalQty2: json["TotalQty2"]?.toString().toInt,
      uom1: json["UOM1"],
      uom2: json["UOM2"],
      karatage: json["Karatage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "BrokenQty1": brokenQty1,
        "Commodity": commodity,
        "CommodityNameRefSuid": commodityNameRefSuid,
        "CommodityNameSuid": commodityNameSuid,
        "ConsumedQty1": consumedQty1,
        "ConsumedQty2": consumedQty2,
        "LossQty1": lossQty1,
        "LotCode": lotCode,
        "LotId": lotId,
        "RMName": rmName,
        "RMNameRefSuid": rmNameRefSuid,
        "RMNameSuid": rmNameSuid,
        "Shape": shape,
        "ShapeRefSuid": shapeRefSuid,
        "ShapeSuid": shapeSuid,
        "TotalQty1": totalQty1,
        "TotalQty2": totalQty2,
        "UOM1": uom1,
        "UOM2": uom2,
        "Karatage": karatage,
      };

  @override
  String toString() {
    return "$brokenQty1, $commodity, $commodityNameRefSuid, $commodityNameSuid, $consumedQty1, $consumedQty2, $lossQty1, $lotCode, $lotId, $rmName, $rmNameRefSuid, $rmNameSuid, $shape, $shapeRefSuid, $shapeSuid, $totalQty1, $totalQty2, $uom1, $uom2, $karatage, ";
  }
}

class MultipleFinishedViewImageShopByMetal {
  MultipleFinishedViewImageShopByMetal({
    required this.contractNo,
    required this.contractImage,
    required this.styleImage,
    required this.imageAvailable,
    required this.imageAvailableMa,
    required this.imageUrl,
    required this.highRes1,
    required this.highRes2,
    required this.highRes3,
    required this.highRes4,
    required this.multiAngleUrl,
  });

  final String? contractNo;
  final String? contractImage;
  final String? styleImage;
  final String? imageAvailable;
  final String? imageAvailableMa;
  final String? imageUrl;
  final String? highRes1;
  final String? highRes2;
  final String? highRes3;
  final String? highRes4;
  final List<MultiAngleUrlShopByMetal> multiAngleUrl;

  MultipleFinishedViewImageShopByMetal copyWith({
    String? contractNo,
    String? contractImage,
    String? styleImage,
    String? imageAvailable,
    String? imageAvailableMa,
    String? imageUrl,
    String? highRes1,
    String? highRes2,
    String? highRes3,
    String? highRes4,
    List<MultiAngleUrlShopByMetal>? multiAngleUrl,
  }) {
    return MultipleFinishedViewImageShopByMetal(
      contractNo: contractNo ?? this.contractNo,
      contractImage: contractImage ?? this.contractImage,
      styleImage: styleImage ?? this.styleImage,
      imageAvailable: imageAvailable ?? this.imageAvailable,
      imageAvailableMa: imageAvailableMa ?? this.imageAvailableMa,
      imageUrl: imageUrl ?? this.imageUrl,
      highRes1: highRes1 ?? this.highRes1,
      highRes2: highRes2 ?? this.highRes2,
      highRes3: highRes3 ?? this.highRes3,
      highRes4: highRes4 ?? this.highRes4,
      multiAngleUrl: multiAngleUrl ?? this.multiAngleUrl,
    );
  }

  factory MultipleFinishedViewImageShopByMetal.fromJson(Map<String, dynamic> json) {
    return MultipleFinishedViewImageShopByMetal(
      contractNo: json["ContractNo"],
      contractImage: json["ContractImage"],
      styleImage: json["StyleImage"],
      imageAvailable: json["IMAGE_AVAILABLE"],
      imageAvailableMa: json["IMAGE_AVAILABLE_MA"],
      imageUrl: json["IMAGE_URL"],
      highRes1: json["high_res1"],
      highRes2: json["high_res2"],
      highRes3: json["high_res3"],
      highRes4: json["high_res4"],
      multiAngleUrl: json["MULTI_ANGLE_URL"] == null
          ? []
          : List<MultiAngleUrlShopByMetal>.from(json["MULTI_ANGLE_URL"]!.map((x) => MultiAngleUrlShopByMetal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "ContractNo": contractNo,
        "ContractImage": contractImage,
        "StyleImage": styleImage,
        "IMAGE_AVAILABLE": imageAvailable,
        "IMAGE_AVAILABLE_MA": imageAvailableMa,
        "IMAGE_URL": imageUrl,
        "high_res1": highRes1,
        "high_res2": highRes2,
        "high_res3": highRes3,
        "high_res4": highRes4,
        "MULTI_ANGLE_URL": multiAngleUrl.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$contractNo, $contractImage, $styleImage, $imageAvailable, $imageAvailableMa, $imageUrl, $highRes1, $highRes2, $highRes3, $highRes4, $multiAngleUrl, ";
  }
}

class MultiAngleUrlShopByMetal {
  MultiAngleUrlShopByMetal({
    required this.url,
  });

  final String? url;

  MultiAngleUrlShopByMetal copyWith({
    String? url,
  }) {
    return MultiAngleUrlShopByMetal(
      url: url ?? this.url,
    );
  }

  factory MultiAngleUrlShopByMetal.fromJson(Map<String, dynamic> json) {
    return MultiAngleUrlShopByMetal(
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };

  @override
  String toString() {
    return "$url, ";
  }
}
