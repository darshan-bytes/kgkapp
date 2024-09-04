class WishlistModel {
  WishlistModel({
    required this.filteredRecords,
    required this.totalRecords,
    required this.data,
    required this.page,
    required this.limit,
  });

  final int? filteredRecords;
  final int? totalRecords;
  final List<WishlistDatum> data;
  final int? page;
  final int? limit;

  factory WishlistModel.fromJson(Map<String, dynamic> json){
    return WishlistModel(
      filteredRecords: json["filteredRecords"],
      totalRecords: json["totalRecords"],
      data: json["data"] == null ? [] : List<WishlistDatum>.from(json["data"]!.map((x) => WishlistDatum.fromJson(x))),
      page: json["page"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
    "filteredRecords": filteredRecords,
    "totalRecords": totalRecords,
    "data": data.map((x) => x.toJson()).toList(),
    "page": page,
    "limit": limit,
  };

  @override
  String toString(){
    return "$filteredRecords, $totalRecords, $data, $page, $limit, ";
  }
}

class WishlistDatum {
  WishlistDatum({
    required this.productId,
    required this.listingName,
    required this.customerId,
    required this.id,
    required this.productData,
  });

  final String? productId;
  final String? listingName;
  final int? customerId;
  final String? id;
  final ProductData? productData;

  factory WishlistDatum.fromJson(Map<String, dynamic> json){
    return WishlistDatum(
      productId: json["product_id"],
      listingName: json["listing_name"],
      customerId: json["customer_id"],
      id: json["id"],
      productData: json["productData"] == null ? null : ProductData.fromJson(json["productData"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "listing_name": listingName,
    "customer_id": customerId,
    "id": id,
    "productData": productData?.toJson(),
  };

  @override
  String toString(){
    return "$productId, $listingName, $customerId, $id, $productData, ";
  }
}

class ProductData {
  ProductData({
    required this.exclusive,
    required this.id,
    required this.productDescription,
    required this.binGroup,
    required this.metalColor1,
    required this.currency,
    required this.cscCode,
    required this.certificateNo,
    required this.diamondGrade,
    required this.newArrival,
    required this.bestSeller,
    required this.metalKt,
    required this.brandName,
    required this.market,
    required this.multipleFinishedViewImage,
    required this.componentDetails,
    required this.suid,
    required this.crt,
    required this.gms,
    required this.rating,
    required this.reviewCount,
    required this.metalColor1HexCode,
    required this.discountPercentage,
    required this.discountPrice,
    required this.isFavorite,
    required this.finalPrice,
  });

  final String? exclusive;
  final String? id;
  final String? productDescription;
  final String? binGroup;
  final String? metalColor1;
  final String? currency;
  final String? cscCode;
  final String? certificateNo;
  final dynamic diamondGrade;
  final String? newArrival;
  final String? bestSeller;
  final String? metalKt;
  final dynamic brandName;
  final String? market;
  final List<MultipleFinishedViewImage> multipleFinishedViewImage;
  final List<ComponentDetail> componentDetails;
  final String? suid;
  final String? crt;
  final String? gms;
  final int? rating;
  final int? reviewCount;
  final String? metalColor1HexCode;
  final int? discountPercentage;
  final String? discountPrice;
  final dynamic isFavorite;
  final String? finalPrice;

  factory ProductData.fromJson(Map<String, dynamic> json){
    return ProductData(
      exclusive: json["exclusive"],
      id: json["id"],
      productDescription: json["product_description"],
      binGroup: json["bin_group"],
      metalColor1: json["metal_color_1"],
      currency: json["currency"],
      cscCode: json["csc_code"],
      certificateNo: json["certificate_no"],
      diamondGrade: json["diamond_grade"],
      newArrival: json["new_arrival"],
      bestSeller: json["best_seller"],
      metalKt: json["metal_kt"],
      brandName: json["brand_name"],
      market: json["market"],
      multipleFinishedViewImage: json["multiple_finished_view_image"] == null ? [] : List<MultipleFinishedViewImage>.from(json["multiple_finished_view_image"]!.map((x) => MultipleFinishedViewImage.fromJson(x))),
      componentDetails: json["component_details"] == null ? [] : List<ComponentDetail>.from(json["component_details"]!.map((x) => ComponentDetail.fromJson(x))),
      suid: json["suid"],
      crt: json["crt"],
      gms: json["gms"],
      rating: json["rating"],
      reviewCount: json["review_count"],
      metalColor1HexCode: json["metal_color_1_hex_code"],
      discountPercentage: json["discount_percentage"],
      discountPrice: json["discount_price"],
      isFavorite: json["is_favorite"],
      finalPrice: json["final_price"],
    );
  }

  Map<String, dynamic> toJson() => {
    "exclusive": exclusive,
    "id": id,
    "product_description": productDescription,
    "bin_group": binGroup,
    "metal_color_1": metalColor1,
    "currency": currency,
    "csc_code": cscCode,
    "certificate_no": certificateNo,
    "diamond_grade": diamondGrade,
    "new_arrival": newArrival,
    "best_seller": bestSeller,
    "metal_kt": metalKt,
    "brand_name": brandName,
    "market": market,
    "multiple_finished_view_image": multipleFinishedViewImage.map((x) => x?.toJson()).toList(),
    "component_details": componentDetails.map((x) => x?.toJson()).toList(),
    "suid": suid,
    "crt": crt,
    "gms": gms,
    "rating": rating,
    "review_count": reviewCount,
    "metal_color_1_hex_code": metalColor1HexCode,
    "discount_percentage": discountPercentage,
    "discount_price": discountPrice,
    "is_favorite": isFavorite,
    "final_price": finalPrice,
  };

  @override
  String toString(){
    return "$exclusive, $id, $productDescription, $binGroup, $metalColor1, $currency, $cscCode, $certificateNo, $diamondGrade, $newArrival, $bestSeller, $metalKt, $brandName, $market, $multipleFinishedViewImage, $componentDetails, $suid, $crt, $gms, $rating, $reviewCount, $metalColor1HexCode, $discountPercentage, $discountPrice, $isFavorite, $finalPrice, ";
  }
}

class ComponentDetail {
  ComponentDetail({
    required this.consumedQty2,
    required this.brokenQty1,
    required this.shape,
    required this.consumedQty1,
    required this.mmSize,
    required this.totalQty2,
    required this.certificateFile,
    required this.sieveSize,
    required this.lotId,
    required this.commodityNameRefSuid,
    required this.localCurrencyAmount,
    required this.internalQualitySuid,
    required this.commodity,
    required this.internalQualityRefSuid,
    required this.shapeRefSuid,
    required this.internationalQuality,
    required this.colorRefSuid,
    required this.internalQualityName,
    required this.shapeSuid,
    required this.cut,
    required this.colorSuid,
    required this.color,
    required this.intCurrencyAmount,
    required this.rmName,
    required this.rmNameSuid,
    required this.claritySuid,
    required this.commodityNameSuid,
    required this.rmNameRefSuid,
    required this.internationalQualityRefSuid,
    required this.clarity,
    required this.internationalQualitySuid,
    required this.localCurrencyRate,
    required this.intCurrencyRate,
    required this.totalQty1,
    required this.lotCode,
    required this.uom2,
    required this.uom1,
    required this.clarityRefSuid,
    required this.karatage,
    required this.lossQty1,
    required this.id,
  });

  final String? consumedQty2;
  final int? brokenQty1;
  final String? shape;
  final String? consumedQty1;
  final String? mmSize;
  final double? totalQty2;
  final List<dynamic> certificateFile;
  final String? sieveSize;
  final String? lotId;
  final String? commodityNameRefSuid;
  final double? localCurrencyAmount;
  final dynamic internalQualitySuid;
  final String? commodity;
  final dynamic internalQualityRefSuid;
  final String? shapeRefSuid;
  final String? internationalQuality;
  final int? colorRefSuid;
  final String? internalQualityName;
  final String? shapeSuid;
  final dynamic cut;
  final String? colorSuid;
  final String? color;
  final String? intCurrencyAmount;
  final String? rmName;
  final String? rmNameSuid;
  final String? claritySuid;
  final String? commodityNameSuid;
  final String? rmNameRefSuid;
  final int? internationalQualityRefSuid;
  final String? clarity;
  final String? internationalQualitySuid;
  final String? localCurrencyRate;
  final String? intCurrencyRate;
  final String? totalQty1;
  final String? lotCode;
  final String? uom2;
  final String? uom1;
  final int? clarityRefSuid;
  final String? karatage;
  final String? lossQty1;
  final String? id;

  factory ComponentDetail.fromJson(Map<String, dynamic> json){
    return ComponentDetail(
      consumedQty2: json["ConsumedQty2"],
      brokenQty1: json["BrokenQty1"],
      shape: json["Shape"],
      consumedQty1: json["ConsumedQty1"],
      mmSize: json["MMSize"],
      totalQty2: json["TotalQty2"].toDouble(),
      certificateFile: json["CertificateFile"] == null ? [] : List<dynamic>.from(json["CertificateFile"]!.map((x) => x)),
      sieveSize: json["SieveSize"],
      lotId: json["LotId"],
      commodityNameRefSuid: json["CommodityNameRefSuid"],
      localCurrencyAmount: json["LocalCurrencyAmount"].toDouble(),
      internalQualitySuid: json["InternalQualitySuid"],
      commodity: json["Commodity"],
      internalQualityRefSuid: json["InternalQualityRefSuid"],
      shapeRefSuid: json["ShapeRefSuid"],
      internationalQuality: json["InternationalQuality"],
      colorRefSuid: json["ColorRefSuid"],
      internalQualityName: json["InternalQualityName"],
      shapeSuid: json["ShapeSuid"],
      cut: json["Cut"],
      colorSuid: json["ColorSuid"],
      color: json["Color"],
      intCurrencyAmount: json["IntCurrencyAmount"],
      rmName: json["RMName"],
      rmNameSuid: json["RMNameSuid"],
      claritySuid: json["ClaritySuid"],
      commodityNameSuid: json["CommodityNameSuid"],
      rmNameRefSuid: json["RMNameRefSuid"],
      internationalQualityRefSuid: json["InternationalQualityRefSuid"],
      clarity: json["Clarity"],
      internationalQualitySuid: json["InternationalQualitySuid"],
      localCurrencyRate: json["LocalCurrencyRate"],
      intCurrencyRate: json["IntCurrencyRate"],
      totalQty1: json["TotalQty1"],
      lotCode: json["LotCode"],
      uom2: json["UOM2"],
      uom1: json["UOM1"],
      clarityRefSuid: json["ClarityRefSuid"],
      karatage: json["Karatage"],
      lossQty1: json["LossQty1"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ConsumedQty2": consumedQty2,
    "BrokenQty1": brokenQty1,
    "Shape": shape,
    "ConsumedQty1": consumedQty1,
    "MMSize": mmSize,
    "TotalQty2": totalQty2,
    "CertificateFile": certificateFile.map((x) => x).toList(),
    "SieveSize": sieveSize,
    "LotId": lotId,
    "CommodityNameRefSuid": commodityNameRefSuid,
    "LocalCurrencyAmount": localCurrencyAmount,
    "InternalQualitySuid": internalQualitySuid,
    "Commodity": commodity,
    "InternalQualityRefSuid": internalQualityRefSuid,
    "ShapeRefSuid": shapeRefSuid,
    "InternationalQuality": internationalQuality,
    "ColorRefSuid": colorRefSuid,
    "InternalQualityName": internalQualityName,
    "ShapeSuid": shapeSuid,
    "Cut": cut,
    "ColorSuid": colorSuid,
    "Color": color,
    "IntCurrencyAmount": intCurrencyAmount,
    "RMName": rmName,
    "RMNameSuid": rmNameSuid,
    "ClaritySuid": claritySuid,
    "CommodityNameSuid": commodityNameSuid,
    "RMNameRefSuid": rmNameRefSuid,
    "InternationalQualityRefSuid": internationalQualityRefSuid,
    "Clarity": clarity,
    "InternationalQualitySuid": internationalQualitySuid,
    "LocalCurrencyRate": localCurrencyRate,
    "IntCurrencyRate": intCurrencyRate,
    "TotalQty1": totalQty1,
    "LotCode": lotCode,
    "UOM2": uom2,
    "UOM1": uom1,
    "ClarityRefSuid": clarityRefSuid,
    "Karatage": karatage,
    "LossQty1": lossQty1,
    "_id": id,
  };

  @override
  String toString(){
    return "$consumedQty2, $brokenQty1, $shape, $consumedQty1, $mmSize, $totalQty2, $certificateFile, $sieveSize, $lotId, $commodityNameRefSuid, $localCurrencyAmount, $internalQualitySuid, $commodity, $internalQualityRefSuid, $shapeRefSuid, $internationalQuality, $colorRefSuid, $internalQualityName, $shapeSuid, $cut, $colorSuid, $color, $intCurrencyAmount, $rmName, $rmNameSuid, $claritySuid, $commodityNameSuid, $rmNameRefSuid, $internationalQualityRefSuid, $clarity, $internationalQualitySuid, $localCurrencyRate, $intCurrencyRate, $totalQty1, $lotCode, $uom2, $uom1, $clarityRefSuid, $karatage, $lossQty1, $id, ";
  }
}

class MultipleFinishedViewImage {
  MultipleFinishedViewImage({
    required this.highRes3,
    required this.highRes4,
    required this.contractNo,
    required this.imageAvailable,
    required this.imageAvailableMa,
    required this.highRes1,
    required this.highRes2,
    required this.imageUrl,
  });

  final dynamic highRes3;
  final dynamic highRes4;
  final String? contractNo;
  final String? imageAvailable;
  final String? imageAvailableMa;
  final dynamic highRes1;
  final dynamic highRes2;
  final String? imageUrl;

  factory MultipleFinishedViewImage.fromJson(Map<String, dynamic> json){
    return MultipleFinishedViewImage(
      highRes3: json["high_res3"],
      highRes4: json["high_res4"],
      contractNo: json["ContractNo"],
      imageAvailable: json["IMAGE_AVAILABLE"],
      imageAvailableMa: json["IMAGE_AVAILABLE_MA"],
      highRes1: json["high_res1"],
      highRes2: json["high_res2"],
      imageUrl: json["IMAGE_URL"],
    );
  }

  Map<String, dynamic> toJson() => {
    "high_res3": highRes3,
    "high_res4": highRes4,
    "ContractNo": contractNo,
    "IMAGE_AVAILABLE": imageAvailable,
    "IMAGE_AVAILABLE_MA": imageAvailableMa,
    "high_res1": highRes1,
    "high_res2": highRes2,
    "IMAGE_URL": imageUrl,
  };

  @override
  String toString(){
    return "$highRes3, $highRes4, $contractNo, $imageAvailable, $imageAvailableMa, $highRes1, $highRes2, $imageUrl, ";
  }
}