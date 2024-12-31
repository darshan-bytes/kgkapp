class SkuLibraryListItemDataModel {
  SkuLibraryListItemDataModel({
    required this.id,
    required this.bestSeller,
    required this.collection1,
    required this.collectionGroupName,
    required this.combination,
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
    required this.metalCommodity,
    required this.metalKt,
    required this.newArrival,
    required this.productDescription,
    required this.productPriceIntCurrency,
    required this.productSize,
    required this.qty,
    required this.skuNo,
    required this.styleNo,
    required this.subareaName,
    required this.subareaCode,
    required this.businessCategoryCode,
    required this.suid,
    required this.updatedAt,
    required this.isOrderPlaced,
    required this.businessCategory,
    required this.kgkCollectionName,
    required this.crt,
    required this.gms,
    required this.metalColor1HexCode,
    required this.businessCategoryName,
    required this.jewelleryTypeName,
    required this.kgkCollection,
    required this.finalPrice,
    required this.discountPrice,
    required this.originalPrice,
    required this.isAddedToCart,
  });

  final String? id;
  final String? bestSeller;
  final String? collection1;
  final dynamic collectionGroupName;
  final String? combination;
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
  final String? metalCommodity;
  final String? metalKt;
  final String? newArrival;
  final String? productDescription;
  final double? productPriceIntCurrency;
  final String? productSize;
  final int? qty;
  final String? skuNo;
  final String? styleNo;
  final String? subareaName;
  final String? subareaCode;
  final String? businessCategoryCode;
  final String? suid;
  final DateTime? updatedAt;
  final bool? isOrderPlaced;
  final String? businessCategory;
  final String? kgkCollectionName;
  final int? crt;
  final int? gms;
  final String? metalColor1HexCode;
  final String? businessCategoryName;
  final String? jewelleryTypeName;
  final String? kgkCollection;
  final String? finalPrice;
  final String? discountPrice;
  final double? originalPrice;
  final bool? isAddedToCart;

  factory SkuLibraryListItemDataModel.fromJson(Map<String, dynamic> json){
    return SkuLibraryListItemDataModel(
      id: json["_id"],
      bestSeller: json["best_seller"],
      collection1: json["collection_1"],
      collectionGroupName: json["collection_group_name"],
      combination: json["combination"],
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
      metalCommodity: json["metal_commodity"],
      metalKt: json["metal_kt"],
      newArrival: json["new_arrival"],
      productDescription: json["product_description"],
      productPriceIntCurrency: json["product_price_int_currency"],
      productSize: json["product_size"],
      qty: json["qty"],
      skuNo: json["sku_no"],
      styleNo: json["style_no"],
      subareaName: json["subarea_name"],
      subareaCode: json["subarea_code"],
      businessCategoryCode: json["business_category_code"],
      suid: json["suid"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      isOrderPlaced: json["is_order_placed"],
      businessCategory: json["business_category"],
      kgkCollectionName: json["kgk_collection_name"],
      crt: json["crt"],
      gms: json["gms"],
      metalColor1HexCode: json["metal_color_1_hex_code"],
      businessCategoryName: json["business_category_name"],
      jewelleryTypeName: json["jewellery_type_name"],
      kgkCollection: json["kgk_collection"],
      finalPrice: json["final_price"],
      discountPrice: json["discount_price"],
      originalPrice: json["original_price"],
      isAddedToCart: json["isAddedToCart"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "best_seller": bestSeller,
    "collection_1": collection1,
    "collection_group_name": collectionGroupName,
    "combination": combination,
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
    "metal_commodity": metalCommodity,
    "metal_kt": metalKt,
    "new_arrival": newArrival,
    "product_description": productDescription,
    "product_price_int_currency": productPriceIntCurrency,
    "product_size": productSize,
    "qty": qty,
    "sku_no": skuNo,
    "style_no": styleNo,
    "subarea_name": subareaName,
    "subarea_code": subareaCode,
    "business_category_code": businessCategoryCode,
    "suid": suid,
    "updated_at": updatedAt?.toIso8601String(),
    "is_order_placed": isOrderPlaced,
    "business_category": businessCategory,
    "kgk_collection_name": kgkCollectionName,
    "crt": crt,
    "gms": gms,
    "metal_color_1_hex_code": metalColor1HexCode,
    "business_category_name": businessCategoryName,
    "jewellery_type_name": jewelleryTypeName,
    "kgk_collection": kgkCollection,
    "final_price": finalPrice,
    "discount_price": discountPrice,
    "original_price": originalPrice,
    "isAddedToCart": isAddedToCart,
  };

  @override
  String toString(){
    return "$id, $bestSeller, $collection1, $collectionGroupName, $combination, $contractNumber, $coordinatorSalesman, $createdAt, $cscCode, $currency, $customer, $customerAliasName, $exclusive, $goodsOrigin, $headSalesman, $jewelleryType, $locationName, $market, $metalCommodity, $metalKt, $newArrival, $productDescription, $productPriceIntCurrency, $productSize, $qty, $skuNo, $styleNo, $subareaName, $subareaCode, $businessCategoryCode, $suid, $updatedAt, $isOrderPlaced, $businessCategory, $kgkCollectionName, $crt, $gms, $metalColor1HexCode, $businessCategoryName, $jewelleryTypeName, $kgkCollection, $finalPrice, $discountPrice, $originalPrice, $isAddedToCart, ";
  }
}
