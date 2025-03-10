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
    required this.components,
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
    this.isAddedToCart = false,
    this.businessCategoryCode,
    this.countryCode,
    this.customerCode,
    this.defaultMetalValueName,
    this.defaultMetalValueRefSuid,
    this.defaultMetalValueSuid,
    this.jewelleryTypeCode,
    this.subareaCode,
    this.subareaId,
    this.subareaName,
    this.customerScopeRefSuid,
    this.customerScope,
    this.kgkCoutureImage,
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
  List<Component> components;
  bool isAddedToCart;
  dynamic businessCategoryCode;
  dynamic countryCode;
  String? customerCode;
  String? defaultMetalValueName;
  int? defaultMetalValueRefSuid;
  String? defaultMetalValueSuid;
  String? jewelleryTypeCode;
  String? subareaCode;
  int? subareaId;
  String? subareaName;
  dynamic customerScopeRefSuid;
  dynamic customerScope;
  String? kgkCoutureImage;

  factory JewelleryDataModel.fromJson(Map<String, dynamic> json) {
    return JewelleryDataModel(
      metalColor3RefSuid: json["metal_color_3_ref_suid"]?.toString(),
      tagPriceLocalCurrency: json["tag_price_local_currency"]?.toString(),
      settingType: json["setting_type"]?.toString(),
      customerCollectionRefSuid: json["customer_collection_ref_suid"]?.toString(),
      metalColor1Suid: json["metal_color_1_suid"]?.toString(),
      ageRange: json["age_range"]?.toString(),
      productPriceLocalCurrency:
          json["product_price_local_currency"] != null ? json["product_price_local_currency"]?.toString().toDouble : 0.0,
      setName: json["set_name"]?.toString(),
      manufactureDate: DateTime.tryParse(json["manufacture_date"] ?? ""),
      exclusive: json["exclusive"]?.toString(),
      styleNo: json["style_no"]?.toString(),
      id: json["id"] ?? json["_id"]?.toString(),
      huidNo2: json["huid_no_2"]?.toString(),
      productDescription: json["product_description"]?.toString(),
      coordinatorSalesmanSuid: json["coordinator_salesman_suid"]?.toString(),
      huidNo1: json["huid_no_1"]?.toString(),
      lspRateIntlCurrency: json["lsp_rate_intl_currency"]?.toString(),
      ageDays: json["age_days"],
      businessCategory: json["business_category"]?.toString(),
      marketSuid: json["market_suid"]?.toString(),
      bestSellerQuantity: json["best_seller_quantity"],
      businessCategoryRefSuid: json["business_category_ref_suid"],
      goodOrigin: json["good_origin"]?.toString(),
      kgkCollection3RefSuid: json["kgk_collection_3_ref_suid"]?.toString(),
      jewelleryTypeGroupSuid: json["jewellery_type_group_suid"]?.toString(),
      productSize: json["product_size"]?.toString(),
      metalColor2RefSuid: json["metal_color_2_ref_suid"]?.toString(),
      kgkCollection2RefSuid: json["kgk_collection_2_ref_suid"]?.toString(),
      productPriceIntCurrency: json["product_price_int_currency"] != null ? json["product_price_int_currency"]?.toString().toDouble : 0.0,
      stockTypeRefSuid: json["stock_type_ref_suid"],
      customerAliasName: json["customer_alias_name"]?.toString(),
      mspRateIntlCurrency: json["msp_rate_intl_currency"]?.toString(),
      metalCommodity: json["metal_commodity"]?.toString(),
      jewelleryTypeSuid: json["jewellery_type_suid"]?.toString(),
      binGroup: json["bin_group"]?.toString(),
      metalColor1: json["metal_color_1"]?.toString(),
      metalColor2: json["metal_color_2"]?.toString(),
      cut: json["cut"]?.toString(),
      metalColor3: json["metal_color_3"]?.toString(),
      customization: json["customization"]?.toString(),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedDateTime: json["updated_date_time"]?.toString(),
      metalCommoditySuid: json["metal_commodity_suid"]?.toString(),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      lspRateLocalCurrency: json["lsp_rate_local_currency"]?.toString(),
      currency: json["currency"]?.toString(),
      collectionGroupNameRefSuid: json["collection_group_name_ref_suid"]?.toString(),
      marketRefSuid: json["market_ref_suid"]?.toString(),
      metalCommodityRefSuid: json["metal_commodity_ref_suid"]?.toString(),
      supplierName: json["supplier_name"]?.toString(),
      metalColor3Suid: json["metal_color_3_suid"]?.toString(),
      metalKtRefSuid: json["metal_kt_ref_suid"]?.toString(),
      cscCode: json["csc_code"]?.toString(),
      grossPriceLocalCurrency: json["gross_price_local_currency"],
      subAreaName: json["sub_area_name"]?.toString(),
      kgkCollection3Suid: json["kgk_collection_3_suid"]?.toString(),
      stockType: json["stock_type"]?.toString(),
      kgkCollectionSuid: json["kgk_collection_suid"]?.toString(),
      subJewelleryType: json["sub_jewellery_type"]?.toString(),
      deleted: json["deleted"],
      ctsOrGms: json["cts_or_gms"]?.toString(),
      customerCollectionSuid: json["customer_collection_suid"]?.toString(),
      jewelleryTypeGroup: json["jewellery_type_group"]?.toString(),
      certificateNo: json["certificate_no"]?.toString(),
      diamondGrade: json["diamond_grade"]?.toString(),
      viewCount: json["view_count"],
      coordinatorSalesman: json["coordinator_salesman"]?.toString(),
      newArrival: json["new_arrival"]?.toString(),
      bestSeller: json["best_seller"]?.toString(),
      singleStone: json["single_stone"]?.toString(),
      customerSuid: json["customer_suid"]?.toString(),
      referenceId: json["reference_id"]?.toString(),
      customerPoNo: json["customer_po_no"]?.toString(),
      cscName: json["csc_name"]?.toString(),
      tagPriceIntlCurrency: json["tag_price_intl_currency"]?.toString(),
      grossPriceIntlCurrency: json["gross_price_intl_currency"],
      collectionGroupName: json["collection_group_name"]?.toString(),
      contractNoSkuNo: json["contract_no_sku_no"]?.toString(),
      metalKt: json["metal_kt"]?.toString(),
      styleSuid: json["style_suid"]?.toString(),
      customerSku: json["customer_sku"]?.toString(),
      jewelleryTypeRefSuid: json["jewellery_type_ref_suid"],
      cscId: json["csc_id"],
      styleRefSuid: json["style_ref_suid"]?.toString(),
      headSalesmanSuid: json["head_salesman_suid"]?.toString(),
      subAreaId: json["sub_area_id"],
      combination: json["combination"]?.toString(),
      businessCategorySuid: json["business_category_suid"]?.toString(),
      stockTypeSuid: json["stock_type_suid"]?.toString(),
      customerRefSuid: json["customer_ref_suid"],
      guestUser: json["guest_user"]?.toString(),
      importedFrom: json["imported_from"]?.toString(),
      brandName: json["brand_name"]?.toString(),
      productName: json["product_name"]?.toString(),
      market: json["market"]?.toString(),
      multipleFinishedViewImage: (json["multiple_finished_view_image"] == null ||
              json["multiple_finished_view_image"].runtimeType == String)
          ? []
          : List<MultipleFinishedViewImage>.from(json["multiple_finished_view_image"]!.map((x) => MultipleFinishedViewImage.fromJson(x))),
      kgkCoutureImage: json["multiple_finished_view_image"],
      setsPart: json["sets_part"]?.toString(),
      kgkCollection2Name: json["kgk_collection_2_name"]?.toString(),
      refSuid: json["ref_suid"],
      qty: json["qty"],
      metalKtSuid: json["metal_kt_suid"]?.toString(),
      metalColor1RefSuid: json["metal_color_1_ref_suid"],
      setNo: json["set_no"]?.toString(),
      componentDetails: json["component_details"] == null
          ? []
          : List<ComponentDetail>.from(json["component_details"]!.map((x) => ComponentDetail.fromJson(x))),
      supplierCode: json["supplier_code"]?.toString(),
      mspRateLocalCurrency: json["msp_rate_local_currency"]?.toInt() ?? 0,
      kgkCollection2Suid: json["kgk_collection_2_suid"]?.toString(),
      kgkCollection3Name: json["kgk_collection_3_name"]?.toString(),
      receivedDateTime: DateTime.tryParse(json["received_date_time"] ?? ""),
      suid: json["suid"]?.toString(),
      customerCollectionName: json["customer_collection_name"]?.toString(),
      jewelleryType: json["jewellery_type"]?.toString(),
      headSalesman: json["head_salesman"]?.toString(),
      headSalesmanRefSuid: json["head_salesman_ref_suid"],
      kgkCollectionRefSuid: json["kgk_collection_ref_suid"]?.toString(),
      coordinatorSalesmanRefSuid: json["coordinator_salesman_ref_suid"],
      customerGroupName: json["customer_group_name"]?.toString(),
      kgkCollection: json["kgk_collection"]?.toString(),
      metalColor2Suid: json["metal_color_2_suid"]?.toString(),
      location: json["location"]?.toString(),
      customer: json["customer"]?.toString(),
      crt: json["crt"]?.toString(),
      gms: json["gms"]?.toString(),
      rating: json["rating"]?.toString().toDouble ?? 0.0,
      reviewCount: json["review_count"],
      metalColor1HexCode: json["metal_color_1_hex_code"]?.toString(),
      metalColor2HexCode: json["metal_color_2_hex_code"]?.toString(),
      metalColor3HexCode: json["metal_color_3_hex_code"]?.toString(),
      discountPercentage: double.tryParse(json["discount_percentage"]?.toString() ?? ""),
      businessCategoryName: json["business_category_name"]?.toString(),
      jewelleryTypeName: json["jewellery_type_name"]?.toString(),
      finalPrice: json["final_price"]?.toString(),
      discountPrice: json["discount_price"]?.toString(),
      isFavorite: (json["is_favorite"] != null && (json["is_favorite"]?.toString() ?? '').isNotEmpty) ? true : false,
      wishlistID: json["is_favorite"]?.toString(),
      components: json["components"] == null ? [] : List<Component>.from(json["components"]!.map((x) => Component.fromJson(x))),
      isAddedToCart: json["isAddedToCart"] ?? false,
      businessCategoryCode: json["business_category_code"],
      countryCode: json["country_code"],
      customerCode: json["customer_code"],
      defaultMetalValueName: json["default_metal_value_name"],
      defaultMetalValueRefSuid: json["default_metal_value_ref_suid"],
      defaultMetalValueSuid: json["default_metal_value_suid"],
      jewelleryTypeCode: json["jewellery_type_code"],
      subareaCode: json["subarea_code"],
      subareaId: json["subarea_id"],
      subareaName: json["subarea_name"],
      customerScopeRefSuid: json["customer_scope_ref_suid"],
      customerScope: json["customer_scope"],
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
        "isAddedToCart": isAddedToCart,
        "business_category_code": businessCategoryCode,
        "country_code": countryCode,
        "customer_code": customerCode,
        "default_metal_value_name": defaultMetalValueName,
        "default_metal_value_ref_suid": defaultMetalValueRefSuid,
        "default_metal_value_suid": defaultMetalValueSuid,
        "jewellery_type_code": jewelleryTypeCode,
        "subarea_code": subareaCode,
        "subarea_id": subareaId,
        "subarea_name": subareaName,
        "customer_scope_ref_suid": customerScopeRefSuid,
        "customer_scope": customerScope,
      };

  @override
  String toString() {
    return "$metalColor3RefSuid, $tagPriceLocalCurrency, $settingType, $customerCollectionRefSuid, $metalColor1Suid, $ageRange, $productPriceLocalCurrency, $setName, $manufactureDate, $exclusive, $styleNo, $id, $huidNo2, $productDescription, $coordinatorSalesmanSuid, $huidNo1, $lspRateIntlCurrency, $ageDays, $businessCategory, $marketSuid, $bestSellerQuantity, $businessCategoryRefSuid, $goodOrigin, $kgkCollection3RefSuid, $jewelleryTypeGroupSuid, $productSize, $metalColor2RefSuid, $kgkCollection2RefSuid, $productPriceIntCurrency, $stockTypeRefSuid, $customerAliasName, $mspRateIntlCurrency, $metalCommodity, $jewelleryTypeSuid, $binGroup, $metalColor1, $metalColor2, $cut, $metalColor3, $customization, $createdAt, $updatedDateTime, $metalCommoditySuid, $updatedAt, $lspRateLocalCurrency, $currency, $collectionGroupNameRefSuid, $marketRefSuid, $metalCommodityRefSuid, $supplierName, $metalColor3Suid, $metalKtRefSuid, $cscCode, $grossPriceLocalCurrency, $subAreaName, $kgkCollection3Suid, $stockType, $kgkCollectionSuid, $subJewelleryType, $deleted, $ctsOrGms, $customerCollectionSuid, $jewelleryTypeGroup, $certificateNo, $diamondGrade, $viewCount, $coordinatorSalesman, $newArrival, $bestSeller, $singleStone, $customerSuid, $referenceId, $customerPoNo, $cscName, $tagPriceIntlCurrency, $grossPriceIntlCurrency, $collectionGroupName, $contractNoSkuNo, $metalKt, $styleSuid, $customerSku, $jewelleryTypeRefSuid, $cscId, $styleRefSuid, $headSalesmanSuid, $subAreaId, $combination, $businessCategorySuid, $stockTypeSuid, $customerRefSuid, $guestUser, $importedFrom, $brandName, $productName, $market, $multipleFinishedViewImage, $setsPart, $kgkCollection2Name, $refSuid, $qty, $metalKtSuid, $metalColor1RefSuid, $setNo, $componentDetails, $supplierCode, $mspRateLocalCurrency, $kgkCollection2Suid, $kgkCollection3Name, $receivedDateTime, $suid, $customerCollectionName, $jewelleryType, $headSalesman, $headSalesmanRefSuid, $kgkCollectionRefSuid, $coordinatorSalesmanRefSuid, $customerGroupName, $kgkCollection, $metalColor2Suid, $location, $customer, $crt, $gms, $rating, $reviewCount, $metalColor1HexCode, $metalColor2HexCode, $metalColor3HexCode, $discountPercentage, $businessCategoryName, $jewelleryTypeName, $finalPrice, $discountPrice, $isAddedToCart, ";
  }
}

extension JewelleryListingModelExtension on JewelleryDataModel {
  String? get discountEXT {
    if ((discountPercentage ?? 0) > 0) {
      return APPStrings.percentageOffInterpolating.tr.interpolate([discountPercentage]);
    }
    return null;
  }

  String? get crtEXT {
    final crtValue = double.tryParse(crt ?? '0') ?? 0.0;
    return crtValue > 0 ? crt : null;
  }
}

class MultipleFinishedViewImage {
  MultipleFinishedViewImage({
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
    required this.the3DFile,
    required this.videoUrl,
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
  final List<MultiAngleUrl> multiAngleUrl;
  final String? the3DFile;
  final String? videoUrl;

  factory MultipleFinishedViewImage.fromJson(Map<String, dynamic> json) {
    return MultipleFinishedViewImage(
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
      multiAngleUrl:
          json["MULTI_ANGLE_URL"] == null ? [] : List<MultiAngleUrl>.from(json["MULTI_ANGLE_URL"]!.map((x) => MultiAngleUrl.fromJson(x))),
      the3DFile: json["3dFile"],
      videoUrl: json["VideoUrl"],
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
        "3dFile": the3DFile,
        "VideoUrl": videoUrl,
      };

  @override
  String toString() {
    return "$contractNo, $contractImage, $styleImage, $imageAvailable, $imageAvailableMa, $imageUrl, $highRes1, $highRes2, $highRes3, $highRes4, $multiAngleUrl, $the3DFile, $videoUrl, ";
  }
}

class MultiAngleUrl {
  MultiAngleUrl({
    required this.url,
  });

  final String? url;

  factory MultiAngleUrl.fromJson(Map<String, dynamic> json) {
    return MultiAngleUrl(
      url: json["url"]?.toString(),
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
      shape: json["Shape"]?.toString(),
      consumedQty1: json["ConsumedQty1"]?.toString() ?? "0",
      mmSize: json["MMSize"]?.toString(),
      totalQty2: json["TotalQty2"]?.toString().toDouble,
      certificateFile: json["CertificateFile"] == null ? [] : List<dynamic>.from(json["CertificateFile"]!.map((x) => x)),
      sieveSize: json["SieveSize"]?.toString(),
      lotId: json["LotId"]?.toString(),
      commodityNameRefSuid: json["CommodityNameRefSuid"]?.toString() ?? "0",
      localCurrencyAmount: json["LocalCurrencyAmount"]?.toString().toDouble,
      internalQualitySuid: json["InternalQualitySuid"]?.toString(),
      commodity: json["Commodity"]?.toString(),
      internalQualityRefSuid: json["InternalQualityRefSuid"]?.toString(),
      shapeRefSuid: json["ShapeRefSuid"]?.toString() ?? "0",
      internationalQuality: json["InternationalQuality"]?.toString(),
      colorRefSuid: json["ColorRefSuid"],
      internalQualityName: json["InternalQualityName"]?.toString(),
      shapeSuid: json["ShapeSuid"]?.toString(),
      cut: json["Cut"]?.toString(),
      colorSuid: json["ColorSuid"]?.toString(),
      color: json["Color"]?.toString(),
      intCurrencyAmount: json["IntCurrencyAmount"]?.toString() ?? "0",
      rmName: json["RMName"]?.toString(),
      rmNameSuid: json["RMNameSuid"]?.toString(),
      claritySuid: json["ClaritySuid"]?.toString(),
      commodityNameSuid: json["CommodityNameSuid"]?.toString(),
      rmNameRefSuid: json["RMNameRefSuid"]?.toString() ?? "0",
      internationalQualityRefSuid: json["InternationalQualityRefSuid"],
      clarity: json["Clarity"]?.toString(),
      internationalQualitySuid: json["InternationalQualitySuid"]?.toString(),
      localCurrencyRate: json["LocalCurrencyRate"]?.toString() ?? "0",
      intCurrencyRate: json["IntCurrencyRate"]?.toString() ?? "0",
      totalQty1: json["TotalQty1"]?.toString() ?? "0",
      lotCode: json["LotCode"]?.toString(),
      uom2: json["UOM2"]?.toString(),
      uom1: json["UOM1"]?.toString(),
      clarityRefSuid: json["ClarityRefSuid"],
      karatage: json["Karatage"]?.toString(),
      lossQty1: json["LossQty1"]?.toString() ?? "0",
      id: json["_id"]?.toString(),
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

class Component extends Equatable {
  const Component({
    required this.title,
    required this.values,
  });

  final String? title;
  final List<List<ValueElement>> values;

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      title: json["title"]?.toString(),
      values: json["values"] == null
          ? []
          : List<List<ValueElement>>.from(
              json["values"]!.map((x) => x == null ? [] : List<ValueElement>.from(x!.map((x) => ValueElement.fromJson(x))))),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "values": values.map((x) => x.map((x) => x.toJson()).toList()).toList(),
      };

  @override
  List<Object?> get props => [
        title,
        values,
      ];
}

class ValueElement extends Equatable {
  const ValueElement({
    required this.title,
    required this.value,
  });

  final String? title;
  final String? value;

  factory ValueElement.fromJson(Map<String, dynamic> json) {
    return ValueElement(
      title: json["title"]?.toString(),
      value: json["value"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };

  @override
  List<Object?> get props => [
        title,
        value,
      ];
}

class StoneElement {
  const StoneElement({
    required this.title,
    required this.value,
  });

  final String? title;
  final String? value;

  factory StoneElement.fromJson(Map<String, dynamic> json) {
    return StoneElement(
      title: json["label"]?.toString(),
      value: json["value"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
      };
}
