import 'package:kgk/kgk.dart';

class JewelleryListingModel {
  JewelleryListingModel({
    required this.data,
    required this.filteredRecords,
    required this.pagination,
    required this.totalRecords,
  });

  List<JewelleryDataModel> data;
  int? filteredRecords;
  Pagination? pagination;
  int? totalRecords;

  factory JewelleryListingModel.fromJson(Map<String, dynamic> json) {
    return JewelleryListingModel(
      data: json["data"] == null ? [] : List<JewelleryDataModel>.from(json["data"]?.map((x) => JewelleryDataModel.fromJson(x))),
      filteredRecords: json["filteredRecords"],
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      totalRecords: json["totalRecords"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "filteredRecords": filteredRecords,
        "pagination": pagination?.toJson(),
        "totalRecords": totalRecords,
      };

  @override
  String toString() {
    return "$data, $filteredRecords, $pagination, $totalRecords, ";
  }
}

class JewelleryDataModel {
  JewelleryDataModel({
    required this.metalColor3RefSuid,
    required this.tagPriceLocalCurrency,
    required this.settingType,
    required this.customerCollectionRefSuid,
    required this.metalColor1Suid,
    required this.ageRange,
    required this.productPriceLocalCurrency,
    required this.setName,
    required this.manufactureDate,
    required this.exclusive,
    required this.styleNo,
    required this.id,
    required this.huidNo2,
    required this.productDescription,
    required this.coordinatorSalesmanSuid,
    required this.huidNo1,
    required this.lspRateIntlCurrency,
    required this.ageDays,
    required this.businessCategory,
    required this.marketSuid,
    required this.bestSellerQuantity,
    required this.businessCategoryRefSuid,
    required this.goodOrigin,
    required this.kgkCollection3RefSuid,
    required this.jewelleryTypeGroupSuid,
    required this.productSize,
    required this.metalColor2RefSuid,
    required this.kgkCollection2RefSuid,
    required this.productPriceIntCurrency,
    required this.stockTypeRefSuid,
    required this.customerAliasName,
    required this.mspRateIntlCurrency,
    required this.metalCommodity,
    required this.jewelleryTypeSuid,
    required this.binGroup,
    required this.metalColor1,
    required this.metalColor2,
    required this.cut,
    required this.metalColor3,
    required this.customization,
    required this.createdAt,
    required this.updatedDateTime,
    required this.metalCommoditySuid,
    required this.updatedAt,
    required this.lspRateLocalCurrency,
    required this.currency,
    required this.collectionGroupNameRefSuid,
    required this.marketRefSuid,
    required this.metalCommodityRefSuid,
    required this.supplierName,
    required this.metalColor3Suid,
    required this.metalKtRefSuid,
    required this.cscCode,
    required this.grossPriceLocalCurrency,
    required this.subAreaName,
    required this.kgkCollection3Suid,
    required this.stockType,
    required this.kgkCollectionSuid,
    required this.subJewelleryType,
    required this.deleted,
    required this.ctsOrGms,
    required this.customerCollectionSuid,
    required this.jewelleryTypeGroup,
    required this.certificateNo,
    required this.diamondGrade,
    required this.viewCount,
    required this.coordinatorSalesman,
    required this.newArrival,
    required this.bestSeller,
    required this.singleStone,
    required this.customerSuid,
    required this.referenceId,
    required this.customerPoNo,
    required this.cscName,
    required this.tagPriceIntlCurrency,
    required this.grossPriceIntlCurrency,
    required this.collectionGroupName,
    required this.contractNoSkuNo,
    required this.metalKt,
    required this.styleSuid,
    required this.customerSku,
    required this.jewelleryTypeRefSuid,
    required this.cscId,
    required this.styleRefSuid,
    required this.headSalesmanSuid,
    required this.subAreaId,
    required this.combination,
    required this.businessCategorySuid,
    required this.stockTypeSuid,
    required this.customerRefSuid,
    required this.guestUser,
    required this.importedFrom,
    required this.brandName,
    required this.productName,
    required this.market,
    required this.multipleFinishedViewImage,
    required this.setsPart,
    required this.kgkCollection2Name,
    required this.refSuid,
    required this.qty,
    required this.metalKtSuid,
    required this.metalColor1RefSuid,
    required this.setNo,
    required this.componentDetails,
    required this.supplierCode,
    required this.mspRateLocalCurrency,
    required this.kgkCollection2Suid,
    required this.kgkCollection3Name,
    required this.receivedDateTime,
    required this.suid,
    required this.customerCollectionName,
    required this.jewelleryType,
    required this.headSalesman,
    required this.headSalesmanRefSuid,
    required this.kgkCollectionRefSuid,
    required this.coordinatorSalesmanRefSuid,
    required this.customerGroupName,
    required this.kgkCollection,
    required this.metalColor2Suid,
    required this.location,
    required this.customer,
    required this.crt,
    required this.gms,
    required this.rating,
    required this.reviewCount,
    required this.metalColor1HexCode,
    required this.metalColor2HexCode,
    required this.metalColor3HexCode,
    required this.discountPercentage,
    required this.businessCategoryName,
    required this.jewelleryTypeName,
    required this.finalPrice,
    required this.discountPrice,
    this.isFavorite = false,
    required this.wishlistID,
  });

  dynamic metalColor3RefSuid;
  String? tagPriceLocalCurrency;
  dynamic settingType;
  dynamic customerCollectionRefSuid;
  String? metalColor1Suid;
  String? ageRange;
  double? productPriceLocalCurrency;
  dynamic setName;
  DateTime? manufactureDate;
  String? exclusive;
  String? styleNo;
  String? id;
  dynamic huidNo2;
  String? productDescription;
  String? coordinatorSalesmanSuid;
  dynamic huidNo1;
  String? lspRateIntlCurrency;
  int? ageDays;
  String? businessCategory;
  String? marketSuid;
  int? bestSellerQuantity;
  int? businessCategoryRefSuid;
  dynamic goodOrigin;
  dynamic kgkCollection3RefSuid;
  String? jewelleryTypeGroupSuid;
  String? productSize;
  String? metalColor2RefSuid;
  dynamic kgkCollection2RefSuid;
  double? productPriceIntCurrency;
  int? stockTypeRefSuid;
  String? customerAliasName;
  String? mspRateIntlCurrency;
  String? metalCommodity;
  String? jewelleryTypeSuid;
  String? binGroup;
  String? metalColor1;
  String? metalColor2;
  dynamic cut;
  dynamic metalColor3;
  dynamic customization;
  DateTime? createdAt;
  dynamic updatedDateTime;
  dynamic metalCommoditySuid;
  DateTime? updatedAt;
  String? lspRateLocalCurrency;
  String? currency;
  dynamic collectionGroupNameRefSuid;
  String? marketRefSuid;
  dynamic metalCommodityRefSuid;
  dynamic supplierName;
  String? metalColor3Suid;
  String? metalKtRefSuid;
  String? cscCode;
  int? grossPriceLocalCurrency;
  String? subAreaName;
  dynamic kgkCollection3Suid;
  String? stockType;
  String? kgkCollectionSuid;
  dynamic subJewelleryType;
  bool? deleted;
  dynamic ctsOrGms;
  String? customerCollectionSuid;
  String? jewelleryTypeGroup;
  dynamic certificateNo;
  dynamic diamondGrade;
  int? viewCount;
  String? coordinatorSalesman;
  String? newArrival;
  String? bestSeller;
  String? singleStone;
  String? customerSuid;
  String? referenceId;
  dynamic customerPoNo;
  String? cscName;
  String? tagPriceIntlCurrency;
  int? grossPriceIntlCurrency;
  dynamic collectionGroupName;
  String? contractNoSkuNo;
  String? metalKt;
  String? styleSuid;
  String? customerSku;
  int? jewelleryTypeRefSuid;
  int? cscId;
  String? styleRefSuid;
  String? headSalesmanSuid;
  int? subAreaId;
  String? combination;
  String? businessCategorySuid;
  String? stockTypeSuid;
  int? customerRefSuid;
  String? guestUser;
  String? importedFrom;
  String? brandName;
  dynamic productName;
  String? market;
  List<MultipleFinishedViewImage> multipleFinishedViewImage;
  dynamic setsPart;
  dynamic kgkCollection2Name;
  int? refSuid;
  int? qty;
  String? metalKtSuid;
  int? metalColor1RefSuid;
  dynamic setNo;
  List<ComponentDetail> componentDetails;
  dynamic supplierCode;
  int? mspRateLocalCurrency;
  dynamic kgkCollection2Suid;
  dynamic kgkCollection3Name;
  DateTime? receivedDateTime;
  String? suid;
  dynamic customerCollectionName;
  String? jewelleryType;
  String? headSalesman;
  int? headSalesmanRefSuid;
  String? kgkCollectionRefSuid;
  int? coordinatorSalesmanRefSuid;
  String? customerGroupName;
  String? kgkCollection;
  String? metalColor2Suid;
  String? location;
  String? customer;
  String? crt;
  String? gms;
  double? rating;
  int? reviewCount;
  String? metalColor1HexCode;
  String? metalColor2HexCode;
  String? metalColor3HexCode;
  double? discountPercentage;
  String? businessCategoryName;
  String? jewelleryTypeName;
  String? finalPrice;
  String? discountPrice;
  bool isFavorite;
  String? wishlistID;

  factory JewelleryDataModel.fromJson(Map<String, dynamic> json) {
    return JewelleryDataModel(
      metalColor3RefSuid: json["metal_color_3_ref_suid"],
      tagPriceLocalCurrency: json["tag_price_local_currency"],
      settingType: json["setting_type"],
      customerCollectionRefSuid: json["customer_collection_ref_suid"],
      metalColor1Suid: json["metal_color_1_suid"],
      ageRange: json["age_range"],
      productPriceLocalCurrency:
          json["product_price_local_currency"] != null ? json["product_price_local_currency"]?.toString().toDouble : 0.0,
      setName: json["set_name"],
      manufactureDate: DateTime.tryParse(json["manufacture_date"] ?? ""),
      exclusive: json["exclusive"],
      styleNo: json["style_no"],
      id: json["id"] ?? json["_id"],
      huidNo2: json["huid_no_2"],
      productDescription: json["product_description"],
      coordinatorSalesmanSuid: json["coordinator_salesman_suid"],
      huidNo1: json["huid_no_1"],
      lspRateIntlCurrency: json["lsp_rate_intl_currency"],
      ageDays: json["age_days"],
      businessCategory: json["business_category"],
      marketSuid: json["market_suid"],
      bestSellerQuantity: json["best_seller_quantity"],
      businessCategoryRefSuid: json["business_category_ref_suid"],
      goodOrigin: json["good_origin"],
      kgkCollection3RefSuid: json["kgk_collection_3_ref_suid"],
      jewelleryTypeGroupSuid: json["jewellery_type_group_suid"],
      productSize: json["product_size"],
      metalColor2RefSuid: json["metal_color_2_ref_suid"],
      kgkCollection2RefSuid: json["kgk_collection_2_ref_suid"],
      productPriceIntCurrency: json["product_price_int_currency"] != null ? json["product_price_int_currency"]?.toString().toDouble : 0.0,
      stockTypeRefSuid: json["stock_type_ref_suid"],
      customerAliasName: json["customer_alias_name"],
      mspRateIntlCurrency: json["msp_rate_intl_currency"]?.toString(),
      metalCommodity: json["metal_commodity"],
      jewelleryTypeSuid: json["jewellery_type_suid"],
      binGroup: json["bin_group"],
      metalColor1: json["metal_color_1"],
      metalColor2: json["metal_color_2"],
      cut: json["cut"],
      metalColor3: json["metal_color_3"],
      customization: json["customization"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedDateTime: json["updated_date_time"],
      metalCommoditySuid: json["metal_commodity_suid"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      lspRateLocalCurrency: json["lsp_rate_local_currency"],
      currency: json["currency"],
      collectionGroupNameRefSuid: json["collection_group_name_ref_suid"],
      marketRefSuid: json["market_ref_suid"],
      metalCommodityRefSuid: json["metal_commodity_ref_suid"],
      supplierName: json["supplier_name"],
      metalColor3Suid: json["metal_color_3_suid"],
      metalKtRefSuid: json["metal_kt_ref_suid"],
      cscCode: json["csc_code"],
      grossPriceLocalCurrency: json["gross_price_local_currency"],
      subAreaName: json["sub_area_name"],
      kgkCollection3Suid: json["kgk_collection_3_suid"],
      stockType: json["stock_type"],
      kgkCollectionSuid: json["kgk_collection_suid"],
      subJewelleryType: json["sub_jewellery_type"],
      deleted: json["deleted"],
      ctsOrGms: json["cts_or_gms"],
      customerCollectionSuid: json["customer_collection_suid"],
      jewelleryTypeGroup: json["jewellery_type_group"],
      certificateNo: json["certificate_no"],
      diamondGrade: json["diamond_grade"],
      viewCount: json["view_count"],
      coordinatorSalesman: json["coordinator_salesman"],
      newArrival: json["new_arrival"],
      bestSeller: json["best_seller"],
      singleStone: json["single_stone"],
      customerSuid: json["customer_suid"],
      referenceId: json["reference_id"],
      customerPoNo: json["customer_po_no"],
      cscName: json["csc_name"],
      tagPriceIntlCurrency: json["tag_price_intl_currency"],
      grossPriceIntlCurrency: json["gross_price_intl_currency"],
      collectionGroupName: json["collection_group_name"],
      contractNoSkuNo: json["contract_no_sku_no"],
      metalKt: json["metal_kt"],
      styleSuid: json["style_suid"],
      customerSku: json["customer_sku"],
      jewelleryTypeRefSuid: json["jewellery_type_ref_suid"],
      cscId: json["csc_id"],
      styleRefSuid: json["style_ref_suid"],
      headSalesmanSuid: json["head_salesman_suid"],
      subAreaId: json["sub_area_id"],
      combination: json["combination"],
      businessCategorySuid: json["business_category_suid"],
      stockTypeSuid: json["stock_type_suid"],
      customerRefSuid: json["customer_ref_suid"],
      guestUser: json["guest_user"],
      importedFrom: json["imported_from"],
      brandName: json["brand_name"],
      productName: json["product_name"],
      market: json["market"],
      multipleFinishedViewImage: json["multiple_finished_view_image"] == null
          ? []
          : List<MultipleFinishedViewImage>.from(json["multiple_finished_view_image"]!.map((x) => MultipleFinishedViewImage.fromJson(x))),
      setsPart: json["sets_part"],
      kgkCollection2Name: json["kgk_collection_2_name"],
      refSuid: json["ref_suid"],
      qty: json["qty"],
      metalKtSuid: json["metal_kt_suid"],
      metalColor1RefSuid: json["metal_color_1_ref_suid"],
      setNo: json["set_no"],
      componentDetails: json["component_details"] == null
          ? []
          : List<ComponentDetail>.from(json["component_details"]!.map((x) => ComponentDetail.fromJson(x))),
      supplierCode: json["supplier_code"],
      mspRateLocalCurrency: json["msp_rate_local_currency"]?.toInt() ?? 0,
      kgkCollection2Suid: json["kgk_collection_2_suid"],
      kgkCollection3Name: json["kgk_collection_3_name"],
      receivedDateTime: DateTime.tryParse(json["received_date_time"] ?? ""),
      suid: json["suid"],
      customerCollectionName: json["customer_collection_name"],
      jewelleryType: json["jewellery_type"],
      headSalesman: json["head_salesman"],
      headSalesmanRefSuid: json["head_salesman_ref_suid"],
      kgkCollectionRefSuid: json["kgk_collection_ref_suid"],
      coordinatorSalesmanRefSuid: json["coordinator_salesman_ref_suid"],
      customerGroupName: json["customer_group_name"],
      kgkCollection: json["kgk_collection"],
      metalColor2Suid: json["metal_color_2_suid"],
      location: json["location"],
      customer: json["customer"],
      crt: json["crt"]?.toString(),
      gms: json["gms"]?.toString(),
      rating: json["rating"]?.toString().toDouble ?? 0.0,
      reviewCount: json["review_count"],
      metalColor1HexCode: json["metal_color_1_hex_code"],
      metalColor2HexCode: json["metal_color_2_hex_code"],
      metalColor3HexCode: json["metal_color_3_hex_code"],
      discountPercentage: double.tryParse(json["discount_percentage"]?.toString() ?? ""),
      businessCategoryName: json["business_category_name"],
      jewelleryTypeName: json["jewellery_type_name"],
      finalPrice: json["final_price"]?.toString(),
      discountPrice: json["discount_price"]?.toString(),
      isFavorite: (json["is_favorite"] != null && (json["is_favorite"]?.toString() ?? '').isNotEmpty) ? true : false,
      wishlistID: json["is_favorite"],
    );
  }

  Map<String, dynamic> toJson() => {
        "metal_color_3_ref_suid": metalColor3RefSuid,
        "tag_price_local_currency": tagPriceLocalCurrency,
        "setting_type": settingType,
        "customer_collection_ref_suid": customerCollectionRefSuid,
        "metal_color_1_suid": metalColor1Suid,
        "age_range": ageRange,
        "product_price_local_currency": productPriceLocalCurrency,
        "set_name": setName,
        "manufacture_date": manufactureDate?.toIso8601String(),
        "exclusive": exclusive,
        "style_no": styleNo,
        "id": id,
        "huid_no_2": huidNo2,
        "product_description": productDescription,
        "coordinator_salesman_suid": coordinatorSalesmanSuid,
        "huid_no_1": huidNo1,
        "lsp_rate_intl_currency": lspRateIntlCurrency,
        "age_days": ageDays,
        "business_category": businessCategory,
        "market_suid": marketSuid,
        "best_seller_quantity": bestSellerQuantity,
        "business_category_ref_suid": businessCategoryRefSuid,
        "good_origin": goodOrigin,
        "kgk_collection_3_ref_suid": kgkCollection3RefSuid,
        "jewellery_type_group_suid": jewelleryTypeGroupSuid,
        "product_size": productSize,
        "metal_color_2_ref_suid": metalColor2RefSuid,
        "kgk_collection_2_ref_suid": kgkCollection2RefSuid,
        "product_price_int_currency": productPriceIntCurrency,
        "stock_type_ref_suid": stockTypeRefSuid,
        "customer_alias_name": customerAliasName,
        "msp_rate_intl_currency": mspRateIntlCurrency,
        "metal_commodity": metalCommodity,
        "jewellery_type_suid": jewelleryTypeSuid,
        "bin_group": binGroup,
        "metal_color_1": metalColor1,
        "metal_color_2": metalColor2,
        "cut": cut,
        "metal_color_3": metalColor3,
        "customization": customization,
        "created_at": createdAt?.toIso8601String(),
        "updated_date_time": updatedDateTime,
        "metal_commodity_suid": metalCommoditySuid,
        "updated_at": updatedAt?.toIso8601String(),
        "lsp_rate_local_currency": lspRateLocalCurrency,
        "currency": currency,
        "collection_group_name_ref_suid": collectionGroupNameRefSuid,
        "market_ref_suid": marketRefSuid,
        "metal_commodity_ref_suid": metalCommodityRefSuid,
        "supplier_name": supplierName,
        "metal_color_3_suid": metalColor3Suid,
        "metal_kt_ref_suid": metalKtRefSuid,
        "csc_code": cscCode,
        "gross_price_local_currency": grossPriceLocalCurrency,
        "sub_area_name": subAreaName,
        "kgk_collection_3_suid": kgkCollection3Suid,
        "stock_type": stockType,
        "kgk_collection_suid": kgkCollectionSuid,
        "sub_jewellery_type": subJewelleryType,
        "deleted": deleted,
        "cts_or_gms": ctsOrGms,
        "customer_collection_suid": customerCollectionSuid,
        "jewellery_type_group": jewelleryTypeGroup,
        "certificate_no": certificateNo,
        "diamond_grade": diamondGrade,
        "view_count": viewCount,
        "coordinator_salesman": coordinatorSalesman,
        "new_arrival": newArrival,
        "best_seller": bestSeller,
        "single_stone": singleStone,
        "customer_suid": customerSuid,
        "reference_id": referenceId,
        "customer_po_no": customerPoNo,
        "csc_name": cscName,
        "tag_price_intl_currency": tagPriceIntlCurrency,
        "gross_price_intl_currency": grossPriceIntlCurrency,
        "collection_group_name": collectionGroupName,
        "contract_no_sku_no": contractNoSkuNo,
        "metal_kt": metalKt,
        "style_suid": styleSuid,
        "customer_sku": customerSku,
        "jewellery_type_ref_suid": jewelleryTypeRefSuid,
        "csc_id": cscId,
        "style_ref_suid": styleRefSuid,
        "head_salesman_suid": headSalesmanSuid,
        "sub_area_id": subAreaId,
        "combination": combination,
        "business_category_suid": businessCategorySuid,
        "stock_type_suid": stockTypeSuid,
        "customer_ref_suid": customerRefSuid,
        "guest_user": guestUser,
        "imported_from": importedFrom,
        "brand_name": brandName,
        "product_name": productName,
        "market": market,
        "multiple_finished_view_image": multipleFinishedViewImage.map((x) => x.toJson()).toList(),
        "sets_part": setsPart,
        "kgk_collection_2_name": kgkCollection2Name,
        "ref_suid": refSuid,
        "qty": qty,
        "metal_kt_suid": metalKtSuid,
        "metal_color_1_ref_suid": metalColor1RefSuid,
        "set_no": setNo,
        "component_details": componentDetails.map((x) => x.toJson()).toList(),
        "supplier_code": supplierCode,
        "msp_rate_local_currency": mspRateLocalCurrency,
        "kgk_collection_2_suid": kgkCollection2Suid,
        "kgk_collection_3_name": kgkCollection3Name,
        "received_date_time": receivedDateTime?.toIso8601String(),
        "suid": suid,
        "customer_collection_name": customerCollectionName,
        "jewellery_type": jewelleryType,
        "head_salesman": headSalesman,
        "head_salesman_ref_suid": headSalesmanRefSuid,
        "kgk_collection_ref_suid": kgkCollectionRefSuid,
        "coordinator_salesman_ref_suid": coordinatorSalesmanRefSuid,
        "customer_group_name": customerGroupName,
        "kgk_collection": kgkCollection,
        "metal_color_2_suid": metalColor2Suid,
        "location": location,
        "customer": customer,
        "crt": crt,
        "gms": gms,
        "rating": rating,
        "review_count": reviewCount,
        "metal_color_1_hex_code": metalColor1HexCode,
        "metal_color_2_hex_code": metalColor2HexCode,
        "metal_color_3_hex_code": metalColor3HexCode,
        "discount_percentage": discountPercentage,
        "business_category_name": businessCategoryName,
        "jewellery_type_name": jewelleryTypeName,
        "final_price": finalPrice,
        "discount_price": discountPrice,
      };

  @override
  String toString() {
    return "$metalColor3RefSuid, $tagPriceLocalCurrency, $settingType, $customerCollectionRefSuid, $metalColor1Suid, $ageRange, $productPriceLocalCurrency, $setName, $manufactureDate, $exclusive, $styleNo, $id, $huidNo2, $productDescription, $coordinatorSalesmanSuid, $huidNo1, $lspRateIntlCurrency, $ageDays, $businessCategory, $marketSuid, $bestSellerQuantity, $businessCategoryRefSuid, $goodOrigin, $kgkCollection3RefSuid, $jewelleryTypeGroupSuid, $productSize, $metalColor2RefSuid, $kgkCollection2RefSuid, $productPriceIntCurrency, $stockTypeRefSuid, $customerAliasName, $mspRateIntlCurrency, $metalCommodity, $jewelleryTypeSuid, $binGroup, $metalColor1, $metalColor2, $cut, $metalColor3, $customization, $createdAt, $updatedDateTime, $metalCommoditySuid, $updatedAt, $lspRateLocalCurrency, $currency, $collectionGroupNameRefSuid, $marketRefSuid, $metalCommodityRefSuid, $supplierName, $metalColor3Suid, $metalKtRefSuid, $cscCode, $grossPriceLocalCurrency, $subAreaName, $kgkCollection3Suid, $stockType, $kgkCollectionSuid, $subJewelleryType, $deleted, $ctsOrGms, $customerCollectionSuid, $jewelleryTypeGroup, $certificateNo, $diamondGrade, $viewCount, $coordinatorSalesman, $newArrival, $bestSeller, $singleStone, $customerSuid, $referenceId, $customerPoNo, $cscName, $tagPriceIntlCurrency, $grossPriceIntlCurrency, $collectionGroupName, $contractNoSkuNo, $metalKt, $styleSuid, $customerSku, $jewelleryTypeRefSuid, $cscId, $styleRefSuid, $headSalesmanSuid, $subAreaId, $combination, $businessCategorySuid, $stockTypeSuid, $customerRefSuid, $guestUser, $importedFrom, $brandName, $productName, $market, $multipleFinishedViewImage, $setsPart, $kgkCollection2Name, $refSuid, $qty, $metalKtSuid, $metalColor1RefSuid, $setNo, $componentDetails, $supplierCode, $mspRateLocalCurrency, $kgkCollection2Suid, $kgkCollection3Name, $receivedDateTime, $suid, $customerCollectionName, $jewelleryType, $headSalesman, $headSalesmanRefSuid, $kgkCollectionRefSuid, $coordinatorSalesmanRefSuid, $customerGroupName, $kgkCollection, $metalColor2Suid, $location, $customer, $crt, $gms, $rating, $reviewCount, $metalColor1HexCode, $metalColor2HexCode, $metalColor3HexCode, $discountPercentage, $businessCategoryName, $jewelleryTypeName, $finalPrice, $discountPrice, ";
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
    required this.multiAngleUrl,
  });

  dynamic highRes3;
  dynamic highRes4;
  String? contractNo;
  String? imageAvailable;
  String? imageAvailableMa;
  dynamic highRes1;
  dynamic highRes2;
  String? imageUrl;
  final List<MultiAngleUrl> multiAngleUrl;

  factory MultipleFinishedViewImage.fromJson(Map<String, dynamic> json) {
    return MultipleFinishedViewImage(
      highRes3: json["high_res3"],
      highRes4: json["high_res4"],
      contractNo: json["ContractNo"],
      imageAvailable: json["IMAGE_AVAILABLE"],
      imageAvailableMa: json["IMAGE_AVAILABLE_MA"],
      highRes1: json["high_res1"],
      highRes2: json["high_res2"],
      imageUrl: json["IMAGE_URL"],
      multiAngleUrl:
          json["MULTI_ANGLE_URL"] == null ? [] : List<MultiAngleUrl>.from(json["MULTI_ANGLE_URL"]!.map((x) => MultiAngleUrl.fromJson(x))),
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
        "MULTI_ANGLE_URL": multiAngleUrl
      };
}

class MultiAngleUrl {
  MultiAngleUrl({
    required this.url,
  });

  final String? url;

  factory MultiAngleUrl.fromJson(Map<String, dynamic> json) {
    return MultiAngleUrl(
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
      };
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

  String? consumedQty2;
  double? brokenQty1;
  String? shape;
  String? consumedQty1;
  String? mmSize;
  double? totalQty2;
  List<dynamic> certificateFile;
  String? sieveSize;
  String? lotId;
  String? commodityNameRefSuid;
  double? localCurrencyAmount;
  dynamic internalQualitySuid;
  String? commodity;
  dynamic internalQualityRefSuid;
  String? shapeRefSuid;
  String? internationalQuality;
  int? colorRefSuid;
  String? internalQualityName;
  String? shapeSuid;
  dynamic cut;
  String? colorSuid;
  String? color;
  String? intCurrencyAmount;
  String? rmName;
  String? rmNameSuid;
  String? claritySuid;
  String? commodityNameSuid;
  String? rmNameRefSuid;
  int? internationalQualityRefSuid;
  String? clarity;
  String? internationalQualitySuid;
  String? localCurrencyRate;
  String? intCurrencyRate;
  String? totalQty1;
  String? lotCode;
  String? uom2;
  String? uom1;
  int? clarityRefSuid;
  String? karatage;
  String? lossQty1;
  String? id;

  factory ComponentDetail.fromJson(Map<String, dynamic> json) {
    return ComponentDetail(
      consumedQty2: json["ConsumedQty2"]?.toString() ?? "0",
      brokenQty1: json["BrokenQty1"]?.toString().toDouble,
      shape: json["Shape"],
      consumedQty1: json["ConsumedQty1"]?.toString() ?? "0",
      mmSize: json["MMSize"],
      totalQty2: json["TotalQty2"]?.toString().toDouble,
      certificateFile: json["CertificateFile"] == null ? [] : List<dynamic>.from(json["CertificateFile"]!.map((x) => x)),
      sieveSize: json["SieveSize"],
      lotId: json["LotId"]?.toString(),
      commodityNameRefSuid: json["CommodityNameRefSuid"]?.toString() ?? "0",
      localCurrencyAmount: json["LocalCurrencyAmount"]?.toString().toDouble,
      internalQualitySuid: json["InternalQualitySuid"],
      commodity: json["Commodity"],
      internalQualityRefSuid: json["InternalQualityRefSuid"],
      shapeRefSuid: json["ShapeRefSuid"]?.toString() ?? "0",
      internationalQuality: json["InternationalQuality"],
      colorRefSuid: json["ColorRefSuid"],
      internalQualityName: json["InternalQualityName"],
      shapeSuid: json["ShapeSuid"],
      cut: json["Cut"],
      colorSuid: json["ColorSuid"],
      color: json["Color"],
      intCurrencyAmount: json["IntCurrencyAmount"]?.toString() ?? "0",
      rmName: json["RMName"],
      rmNameSuid: json["RMNameSuid"],
      claritySuid: json["ClaritySuid"],
      commodityNameSuid: json["CommodityNameSuid"],
      rmNameRefSuid: json["RMNameRefSuid"]?.toString() ?? "0",
      internationalQualityRefSuid: json["InternationalQualityRefSuid"],
      clarity: json["Clarity"],
      internationalQualitySuid: json["InternationalQualitySuid"],
      localCurrencyRate: json["LocalCurrencyRate"]?.toString() ?? "0",
      intCurrencyRate: json["IntCurrencyRate"]?.toString() ?? "0",
      totalQty1: json["TotalQty1"]?.toString() ?? "0",
      lotCode: json["LotCode"],
      uom2: json["UOM2"],
      uom1: json["UOM1"],
      clarityRefSuid: json["ClarityRefSuid"],
      karatage: json["Karatage"],
      lossQty1: json["LossQty1"]?.toString() ?? "0",
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
  String toString() {
    return "$consumedQty2, $brokenQty1, $shape, $consumedQty1, $mmSize, $totalQty2, $certificateFile, $sieveSize, $lotId, $commodityNameRefSuid, $localCurrencyAmount, $internalQualitySuid, $commodity, $internalQualityRefSuid, $shapeRefSuid, $internationalQuality, $colorRefSuid, $internalQualityName, $shapeSuid, $cut, $colorSuid, $color, $intCurrencyAmount, $rmName, $rmNameSuid, $claritySuid, $commodityNameSuid, $rmNameRefSuid, $internationalQualityRefSuid, $clarity, $internationalQualitySuid, $localCurrencyRate, $intCurrencyRate, $totalQty1, $lotCode, $uom2, $uom1, $clarityRefSuid, $karatage, $lossQty1, $id, ";
  }
}

class Pagination {
  Pagination({
    required this.limit,
    required this.page,
  });

  String? limit;
  String? page;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      limit: json["limit"]?.toString(),
      page: json["page"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "page": page,
      };

  @override
  String toString() {
    return "$limit, $page, ";
  }
}
