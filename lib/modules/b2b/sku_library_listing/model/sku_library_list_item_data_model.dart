import 'package:kgk/kgk.dart';

class SkuLibraryListItemDataModel {
  SkuLibraryListItemDataModel({
    required this.id,
    required this.bestSeller,
    required this.collection1,
    required this.collectionGroupName,
    required this.combination,
    required this.componentDetails,
    required this.contractNumber,
    required this.coordinatorSalesman,
    required this.createdAt,
    required this.cscCode,
    required this.currency,
    required this.customer,
    required this.customerAliasName,
    required this.exclusive,
    required this.goodsOrigin,
    required this.headSalesman,
    required this.jewelleryType,
    required this.locationName,
    required this.market,
    required this.metalColor,
    required this.metalCommodity,
    required this.metalKt,
    required this.multipleCadViewImage,
    required this.multipleFinishedViewImage,
    required this.newArrival,
    required this.productDescription,
    required this.productPriceIntCurrency,
    required this.qty,
    required this.skuNo,
    required this.styleNo,
    required this.subareaName,
    required this.subareaCode,
    required this.businessCategoryCode,
    required this.suid,
    required this.updatedAt,
    required this.diamondWeight,
    required this.gemstoneWeight,
    required this.metalWeight,
    required this.diamondColor,
    required this.internationalQuality,
    required this.internalQualityName,
    required this.isOrderPlaced,
    required this.sortIndex,
    required this.businessCategory,
    required this.kgkCollectionName,
    required this.crt,
    required this.gms,
    required this.metalColor1,
    required this.metalColor1HexCode,
    required this.businessCategoryName,
    required this.jewelleryTypeName,
    required this.kgkCollection,
    required this.finalPrice,
    required this.discountPrice,
    required this.originalPrice,
    required this.images,
    required this.isAddedToCart,
    required this.productSize,
    this.components,
  });

  final String? id;
  final String? bestSeller;
  final String? collection1;
  final String? collectionGroupName;
  final String? combination;
  final List<SkuComponentDetail> componentDetails;
  final String? contractNumber;
  final String? coordinatorSalesman;
  final DateTime? createdAt;
  final String? cscCode;
  final String? currency;
  final String? customer;
  final String? customerAliasName;
  final String? exclusive;
  final String? goodsOrigin;
  final String? headSalesman;
  final String? jewelleryType;
  final String? locationName;
  final String? market;
  final List<String?>? metalColor;
  final String? metalCommodity;
  final String? metalKt;
  final List<dynamic> multipleCadViewImage;
  final List<MultipleFinishedViewImage> multipleFinishedViewImage;
  final String? newArrival;
  final String? productDescription;
  final double? productPriceIntCurrency;
  final int? qty;
  final String? skuNo;
  final String? styleNo;
  final String? subareaName;
  final String? subareaCode;
  final String? businessCategoryCode;
  final String? suid;
  final DateTime? updatedAt;
  final int? diamondWeight;
  final int? gemstoneWeight;
  final double? metalWeight;
  final List<dynamic> diamondColor;
  final List<String> internationalQuality;
  final List<dynamic> internalQualityName;
  final bool? isOrderPlaced;
  final int? sortIndex;
  final String? businessCategory;
  final String? kgkCollectionName;
  final String? crt;
  final String? gms;
  final String? metalColor1;
  final String? metalColor1HexCode;
  final String? businessCategoryName;
  final String? jewelleryTypeName;
  final String? kgkCollection;
  final String? finalPrice;
  final String? discountPrice;
  final double? originalPrice;
  final List<String> images;
  final bool? isAddedToCart;
  final String? productSize;
  List<Component>? components;

  factory SkuLibraryListItemDataModel.fromJson(Map<String, dynamic> json) {
    List<String>? images;
    if (json['images'] != null) {
      images = [];
      for (var e in (json['images'] as List<dynamic>)) {
        if (e != null) {
          images.add(e.toString());
        }
      }
    } else {
      images = null;
    }
    return SkuLibraryListItemDataModel(
      id: json["_id"],
      bestSeller: json["best_seller"],
      collection1: json["collection_1"],
      collectionGroupName: json["collection_group_name"],
      combination: json["combination"],
      componentDetails:
          json["component_details"] == null
              ? []
              : List<SkuComponentDetail>.from(json["component_details"]!.map((x) => SkuComponentDetail.fromJson(x))),
      contractNumber: json["contract_number"],
      coordinatorSalesman: json["coordinator_salesman"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      cscCode: json["csc_code"],
      currency: json["currency"],
      customer: json["customer"],
      customerAliasName: json["customer_alias_name"],
      exclusive: json["exclusive"],
      goodsOrigin: json["goods_origin"],
      headSalesman: json["head_salesman"],
      jewelleryType: json["jewellery_type"],
      locationName: json["location_name"],
      market: json["market"],
      metalColor: json["metal_color"] == null ? [] : List<String?>.from(json["metal_color"]!.map((x) => x)),
      metalCommodity: json["metal_commodity"],
      metalKt: json["metal_kt"],
      multipleCadViewImage:
          json["multiple_cad_view_image"] == null ? [] : List<dynamic>.from(json["multiple_cad_view_image"]!.map((x) => x)),
      multipleFinishedViewImage:
          json["multiple_finished_view_image"] == null
              ? []
              : List<MultipleFinishedViewImage>.from(
                json["multiple_finished_view_image"]!.map((x) => MultipleFinishedViewImage.fromJson(x)),
              ),
      newArrival: json["new_arrival"],
      productDescription: json["product_description"],
      productPriceIntCurrency: json["product_price_int_currency"]?.toString().toDouble,
      qty: json["qty"],
      skuNo: json["sku_no"],
      styleNo: json["style_no"],
      subareaName: json["subarea_name"],
      subareaCode: json["subarea_code"],
      businessCategoryCode: json["business_category_code"],
      suid: json["suid"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      diamondWeight: json["diamond_weight"]?.toString().toInt,
      gemstoneWeight: json["gemstone_weight"],
      metalWeight: json["metal_weight"]?.toString().toDouble,
      diamondColor: json["diamond_color"] == null ? [] : List<dynamic>.from(json["diamond_color"]!.map((x) => x)),
      internationalQuality: json["international_quality"] == null ? [] : List<String>.from(json["international_quality"]!.map((x) => x)),
      internalQualityName: json["internal_quality_name"] == null ? [] : List<dynamic>.from(json["internal_quality_name"]!.map((x) => x)),
      isOrderPlaced: json["is_order_placed"],
      sortIndex: json["sortIndex"],
      businessCategory: json["business_category"],
      kgkCollectionName: json["kgk_collection_name"],
      crt: json["crt"],
      gms: json["gms"],
      metalColor1: json["metal_color_1"],
      metalColor1HexCode: json["metal_color_1_hex_code"],
      businessCategoryName: json["business_category_name"],
      jewelleryTypeName: json["jewellery_type_name"],
      kgkCollection: json["kgk_collection"],
      finalPrice: json["final_price"],
      discountPrice: json["discount_price"],
      originalPrice: json["original_price"]?.toString().toDouble,
      images: images ?? [],
      isAddedToCart: json["isAddedToCart"],
      productSize: json["product_size"],
      components: json["components"] != null ? List<Component>.from(json["components"]!.map((x) => Component.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "best_seller": bestSeller,
    "collection_1": collection1,
    "collection_group_name": collectionGroupName,
    "combination": combination,
    "component_details": componentDetails.map((x) => x.toJson()).toList(),
    "contract_number": contractNumber,
    "coordinator_salesman": coordinatorSalesman,
    "created_at": createdAt?.toIso8601String(),
    "csc_code": cscCode,
    "currency": currency,
    "customer": customer,
    "customer_alias_name": customerAliasName,
    "exclusive": exclusive,
    "goods_origin": goodsOrigin,
    "head_salesman": headSalesman,
    "jewellery_type": jewelleryType,
    "location_name": locationName,
    "market": market,
    "metal_color": metalColor?.map((x) => x).toList(),
    "metal_commodity": metalCommodity,
    "metal_kt": metalKt,
    "multiple_cad_view_image": multipleCadViewImage.map((x) => x).toList(),
    "multiple_finished_view_image": multipleFinishedViewImage.map((x) => x.toJson()).toList(),
    "new_arrival": newArrival,
    "product_description": productDescription,
    "product_price_int_currency": productPriceIntCurrency,
    "qty": qty,
    "sku_no": skuNo,
    "style_no": styleNo,
    "subarea_name": subareaName,
    "subarea_code": subareaCode,
    "business_category_code": businessCategoryCode,
    "suid": suid,
    "updated_at": updatedAt?.toIso8601String(),
    "diamond_weight": diamondWeight,
    "gemstone_weight": gemstoneWeight,
    "metal_weight": metalWeight,
    "diamond_color": diamondColor.map((x) => x).toList(),
    "international_quality": internationalQuality.map((x) => x).toList(),
    "internal_quality_name": internalQualityName.map((x) => x).toList(),
    "is_order_placed": isOrderPlaced,
    "sortIndex": sortIndex,
    "business_category": businessCategory,
    "kgk_collection_name": kgkCollectionName,
    "crt": crt,
    "gms": gms,
    "metal_color_1": metalColor1,
    "metal_color_1_hex_code": metalColor1HexCode,
    "business_category_name": businessCategoryName,
    "jewellery_type_name": jewelleryTypeName,
    "kgk_collection": kgkCollection,
    "final_price": finalPrice,
    "discount_price": discountPrice,
    "original_price": originalPrice,
    "images": images.map((x) => x).toList(),
    "isAddedToCart": isAddedToCart,
    "product_size": productSize,
  };

  @override
  String toString() {
    return "$id, $bestSeller, $collection1, $collectionGroupName, $combination, $componentDetails, $contractNumber, $coordinatorSalesman, $createdAt, $cscCode, $currency, $customer, $customerAliasName, $exclusive, $goodsOrigin, $headSalesman, $jewelleryType, $locationName, $market, $metalColor, $metalCommodity, $metalKt, $multipleCadViewImage, $multipleFinishedViewImage, $newArrival, $productDescription, $productPriceIntCurrency, $qty, $skuNo, $styleNo, $subareaName, $subareaCode, $businessCategoryCode, $suid, $updatedAt, $diamondWeight, $gemstoneWeight, $metalWeight, $diamondColor, $internationalQuality, $internalQualityName, $isOrderPlaced, $sortIndex, $businessCategory, $kgkCollectionName, $crt, $gms, $metalColor1, $metalColor1HexCode, $businessCategoryName, $jewelleryTypeName, $kgkCollection, $finalPrice, $discountPrice, $originalPrice, $images, $isAddedToCart, $productSize, ";
  }
}

class SkuComponentDetail {
  SkuComponentDetail({
    required this.lotCode,
    required this.rmName,
    required this.commodityName,
    required this.shape,
    required this.color,
    required this.cut,
    required this.clarity,
    required this.internationalQuality,
    required this.sieveSize,
    required this.mmSize,
    required this.consumedQty1,
    required this.consumedQty2,
    required this.totalQty1,
    required this.totalQty2,
    required this.uom1,
    required this.uom2,
    required this.localCurrencyRate,
    required this.localCurrencyAmount,
    required this.intCurrencyRate,
    required this.intCurrencyAmount,
    required this.certificateFile,
    required this.commodity,
    required this.rmGroup,
  });

  final String? lotCode;
  final String? rmName;
  final String? commodityName;
  final String? shape;
  final String? color;
  final String? cut;
  final String? clarity;
  final String? internationalQuality;
  final String? sieveSize;
  final String? mmSize;
  final double? consumedQty1;
  final int? consumedQty2;
  final double? totalQty1;
  final int? totalQty2;
  final String? uom1;
  final String? uom2;
  final double? localCurrencyRate;
  final double? localCurrencyAmount;
  final double? intCurrencyRate;
  final double? intCurrencyAmount;
  final List<dynamic> certificateFile;
  final String? commodity;
  final String? rmGroup;

  factory SkuComponentDetail.fromJson(Map<String, dynamic> json) {
    return SkuComponentDetail(
      lotCode: json["LotCode"],
      rmName: json["RMName"],
      commodityName: json["CommodityName"],
      shape: json["Shape"],
      color: json["Color"],
      cut: json["Cut"],
      clarity: json["Clarity"],
      internationalQuality: json["InternationalQuality"],
      sieveSize: json["SieveSize"],
      mmSize: json["MMSize"],
      consumedQty1: json["ConsumedQty1"]?.toString().toDouble,
      consumedQty2: json["ConsumedQty2"],
      totalQty1: json["TotalQty1"]?.toString().toDouble,
      totalQty2: json["TotalQty2"],
      uom1: json["UOM1"],
      uom2: json["UOM2"],
      localCurrencyRate: json["LocalCurrencyRate"]?.toString().toDouble,
      localCurrencyAmount: json["LocalCurrencyAmount"]?.toString().toDouble,
      intCurrencyRate: json["IntCurrencyRate"]?.toString().toDouble,
      intCurrencyAmount: json["IntCurrencyAmount"]?.toString().toDouble,
      certificateFile: json["CertificateFile"] == null ? [] : List<dynamic>.from(json["CertificateFile"]!.map((x) => x)),
      commodity: json["Commodity"],
      rmGroup: json["RmGroup"],
    );
  }

  Map<String, dynamic> toJson() => {
    "LotCode": lotCode,
    "RMName": rmName,
    "CommodityName": commodityName,
    "Shape": shape,
    "Color": color,
    "Cut": cut,
    "Clarity": clarity,
    "InternationalQuality": internationalQuality,
    "SieveSize": sieveSize,
    "MMSize": mmSize,
    "ConsumedQty1": consumedQty1,
    "ConsumedQty2": consumedQty2,
    "TotalQty1": totalQty1,
    "TotalQty2": totalQty2,
    "UOM1": uom1,
    "UOM2": uom2,
    "LocalCurrencyRate": localCurrencyRate,
    "LocalCurrencyAmount": localCurrencyAmount,
    "IntCurrencyRate": intCurrencyRate,
    "IntCurrencyAmount": intCurrencyAmount,
    "CertificateFile": certificateFile.map((x) => x).toList(),
  };

  @override
  String toString() {
    return "$lotCode, $rmName, $commodityName, $shape, $color, $cut, $clarity, $internationalQuality, $sieveSize, $mmSize, $consumedQty1, $consumedQty2, $totalQty1, $totalQty2, $uom1, $uom2, $localCurrencyRate, $localCurrencyAmount, $intCurrencyRate, $intCurrencyAmount, $certificateFile, ";
  }
}
