import 'package:kgk/kgk.dart';

class WishlistModel {
  WishlistModel({required this.filteredRecords, required this.totalRecords, required this.data, required this.page, required this.limit});

  int? filteredRecords;
  int? totalRecords;
  List<WishlistDatum> data;
  int? page;
  int? limit;

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
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
  String toString() {
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
    this.isAddedToCart = false,
  });

  String? productId;
  String? listingName;
  int? customerId;
  String? id;
  ProductData? productData;
  bool isAddedToCart;

  factory WishlistDatum.fromJson(Map<String, dynamic> json) {
    return WishlistDatum(
      productId: json["product_id"],
      listingName: json["listing_name"],
      customerId: json["customer_id"],
      id: json["id"],
      productData: json["productData"] == null ? null : ProductData.fromJson(json["productData"]),
      isAddedToCart: json["isAddedToCart"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "listing_name": listingName,
    "customer_id": customerId,
    "id": id,
    "productData": productData?.toJson(),
    "isAddedToCart": isAddedToCart,
  };

  @override
  String toString() {
    return "$productId, $listingName, $customerId, $id, $productData, $isAddedToCart";
  }
}

extension WishlistDatumExtension on WishlistDatum {
  Commodity get displayCommodity =>
      Commodity.values.firstWhereOrNull((element) => element.value == listingName?.toLowerCase()) ?? Commodity.diamond;
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
    this.isFavorite = true,
    required this.finalPrice,
    required this.wishlistId,
    required this.rmDescription,
    required this.lotCode,
    required this.productImages,
    this.isAuction = false,
    this.contractNoSkuNo,
  });

  String? exclusive;
  String? id;
  String? productDescription;
  String? binGroup;
  String? metalColor1;
  String? currency;
  String? cscCode;
  String? certificateNo;
  dynamic diamondGrade;
  String? newArrival;
  String? bestSeller;
  String? metalKt;
  dynamic brandName;
  String? market;
  List<MultipleFinishedViewImageShopByMetal> multipleFinishedViewImage;
  List<ComponentDetailShopByMetal> componentDetails;
  String? suid;
  String? crt;
  String? gms;
  double? rating;
  int? reviewCount;
  String? metalColor1HexCode;
  double? discountPercentage;
  String? discountPrice;
  bool isFavorite;
  String? finalPrice;
  String? wishlistId;
  String? rmDescription;
  String? lotCode;
  List<ProductImages>? productImages;
  bool isAuction;
  String? contractNoSkuNo;

  factory ProductData.fromJson(Map<String, dynamic> json) {
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
      multipleFinishedViewImage:
          json["multiple_finished_view_image"] == null
              ? []
              : List<MultipleFinishedViewImageShopByMetal>.from(
                json["multiple_finished_view_image"]!.map((x) => MultipleFinishedViewImageShopByMetal.fromJson(x)),
              ),
      componentDetails:
          json["component_details"] == null
              ? []
              : List<ComponentDetailShopByMetal>.from(json["component_details"]!.map((x) => ComponentDetailShopByMetal.fromJson(x))),
      suid: json["suid"],
      crt: json["crt"].toString(),
      gms: json["gms"].toString(),
      rating: json["rating"]?.toString().toDouble ?? 0.0,
      reviewCount: json["review_count"],
      metalColor1HexCode: json["metal_color_1_hex_code"],
      discountPercentage: json["discount_percentage"]?.toString().toDouble ?? 0.0,
      discountPrice: json["discount_price"],
      isFavorite: (json["is_favorite"] != null && json["is_favorite"].toString().isNotEmpty) ? true : false,
      finalPrice: json["final_price"],
      wishlistId: json["is_favorite"],
      lotCode: json["lot_code"],
      rmDescription: json["rm_description"],
      productImages: json["image"] == null ? [] : List<ProductImages>.from(json["image"]!.map((x) => ProductImages.fromJson(x))),
      isAuction: json["is_auction"] ?? false,
      contractNoSkuNo: json["contract_no_sku_no"],
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
    "multiple_finished_view_image": multipleFinishedViewImage.map((x) => x.toJson()).toList(),
    "component_details": componentDetails.map((x) => x.toJson()).toList(),
    "suid": suid,
    "crt": crt,
    "gms": gms,
    "rating": rating,
    "review_count": reviewCount,
    "metal_color_1_hex_code": metalColor1HexCode,
    "discount_percentage": discountPercentage,
    "discount_price": discountPrice,
    "is_favorite": wishlistId,
    "final_price": finalPrice,
  };

  @override
  String toString() {
    return "$exclusive, $id, $productDescription, $binGroup, $metalColor1, $currency, $cscCode, $certificateNo, $diamondGrade, $newArrival, $bestSeller, $metalKt, $brandName, $market, $multipleFinishedViewImage, $componentDetails, $suid, $crt, $gms, $rating, $reviewCount, $metalColor1HexCode, $discountPercentage, $discountPrice, $isFavorite, $finalPrice, ";
  }
}

class ProductImages {
  String? uRL;

  ProductImages({this.uRL});

  ProductImages.fromJson(Map<String, dynamic> json) {
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['URL'] = uRL;
    return data;
  }
}
