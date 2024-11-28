import 'package:kgk/kgk.dart';

class KgkCoutureDetails {
  KgkCoutureDetails({
    required this.id,
    required this.suid,
    required this.businessCategoryCode,
    required this.businessCategoryName,
    required this.businessCategoryRefSuid,
    required this.businessCategorySuid,
    required this.cscCode,
    required this.cscId,
    required this.cscName,
    required this.contractNoSkuNo,
    required this.countryCode,
    required this.customerCode,
    required this.customerAliasName,
    required this.customerGroupName,
    required this.customerSuid,
    required this.defaultMetalValueName,
    required this.defaultMetalValueRefSuid,
    required this.defaultMetalValueSuid,
    required this.exclusive,
    required this.jewelleryTypeCode,
    required this.jewelleryTypeName,
    required this.jewelleryTypeRefSuid,
    required this.jewelleryTypeSuid,
    required this.kgkCollection,
    required this.kgkCollectionRefSuid,
    required this.kgkCollectionSuid,
    required this.metalColor1,
    required this.metalColor2,
    required this.metalColor3,
    required this.multipleFinishedViewImage,
    required this.productDescription,
    required this.productPriceIntCurrency,
    required this.productPriceLocalCurrency,
    required this.receivedDateTime,
    required this.subareaCode,
    required this.subareaId,
    required this.subareaName,
    required this.referenceId,
    required this.customerRefSuid,
    required this.currency,
    required this.customerScopeRefSuid,
    required this.guestUser,
    required this.customerScope,
    required this.componentDetails,
    required this.finalPrice,
    required this.discountPrice,
  });

  final String? id;
  final String? suid;
  final String? businessCategoryCode;
  final String? businessCategoryName;
  final int? businessCategoryRefSuid;
  final String? businessCategorySuid;
  final String? cscCode;
  final int? cscId;
  final String? cscName;
  final String? contractNoSkuNo;
  final dynamic countryCode;
  final String? customerCode;
  final String? customerAliasName;
  final String? customerGroupName;
  final String? customerSuid;
  final String? defaultMetalValueName;
  final int? defaultMetalValueRefSuid;
  final String? defaultMetalValueSuid;
  final String? exclusive;
  final String? jewelleryTypeCode;
  final String? jewelleryTypeName;
  final int? jewelleryTypeRefSuid;
  final String? jewelleryTypeSuid;
  final String? kgkCollection;
  final int? kgkCollectionRefSuid;
  final String? kgkCollectionSuid;
  final String? metalColor1;
  final dynamic metalColor2;
  final dynamic metalColor3;
  final String? multipleFinishedViewImage;
  final String? productDescription;
  final String? productPriceIntCurrency;
  final String? productPriceLocalCurrency;
  final DateTime? receivedDateTime;
  final String? subareaCode;
  final int? subareaId;
  final String? subareaName;
  final String? referenceId;
  final int? customerRefSuid;
  final String? currency;
  final dynamic customerScopeRefSuid;
  final String? guestUser;
  final dynamic customerScope;
  final List<ComponentDetail> componentDetails;
  final double? finalPrice;
  final double? discountPrice;

  KgkCoutureDetails copyWith({
    String? id,
    String? suid,
    String? businessCategoryCode,
    String? businessCategoryName,
    int? businessCategoryRefSuid,
    String? businessCategorySuid,
    String? cscCode,
    int? cscId,
    String? cscName,
    String? contractNoSkuNo,
    dynamic countryCode,
    String? customerCode,
    String? customerAliasName,
    String? customerGroupName,
    String? customerSuid,
    String? defaultMetalValueName,
    int? defaultMetalValueRefSuid,
    String? defaultMetalValueSuid,
    String? exclusive,
    String? jewelleryTypeCode,
    String? jewelleryTypeName,
    int? jewelleryTypeRefSuid,
    String? jewelleryTypeSuid,
    String? kgkCollection,
    int? kgkCollectionRefSuid,
    String? kgkCollectionSuid,
    String? metalColor1,
    dynamic metalColor2,
    dynamic metalColor3,
    String? multipleFinishedViewImage,
    String? productDescription,
    String? productPriceIntCurrency,
    String? productPriceLocalCurrency,
    DateTime? receivedDateTime,
    String? subareaCode,
    int? subareaId,
    String? subareaName,
    String? referenceId,
    int? customerRefSuid,
    String? currency,
    dynamic customerScopeRefSuid,
    String? guestUser,
    dynamic customerScope,
    List<ComponentDetail>? componentDetails,
    double? finalPrice,
    double? discountPrice,
  }) {
    return KgkCoutureDetails(
      id: id ?? this.id,
      suid: suid ?? this.suid,
      businessCategoryCode: businessCategoryCode ?? this.businessCategoryCode,
      businessCategoryName: businessCategoryName ?? this.businessCategoryName,
      businessCategoryRefSuid: businessCategoryRefSuid ?? this.businessCategoryRefSuid,
      businessCategorySuid: businessCategorySuid ?? this.businessCategorySuid,
      cscCode: cscCode ?? this.cscCode,
      cscId: cscId ?? this.cscId,
      cscName: cscName ?? this.cscName,
      contractNoSkuNo: contractNoSkuNo ?? this.contractNoSkuNo,
      countryCode: countryCode ?? this.countryCode,
      customerCode: customerCode ?? this.customerCode,
      customerAliasName: customerAliasName ?? this.customerAliasName,
      customerGroupName: customerGroupName ?? this.customerGroupName,
      customerSuid: customerSuid ?? this.customerSuid,
      defaultMetalValueName: defaultMetalValueName ?? this.defaultMetalValueName,
      defaultMetalValueRefSuid: defaultMetalValueRefSuid ?? this.defaultMetalValueRefSuid,
      defaultMetalValueSuid: defaultMetalValueSuid ?? this.defaultMetalValueSuid,
      exclusive: exclusive ?? this.exclusive,
      jewelleryTypeCode: jewelleryTypeCode ?? this.jewelleryTypeCode,
      jewelleryTypeName: jewelleryTypeName ?? this.jewelleryTypeName,
      jewelleryTypeRefSuid: jewelleryTypeRefSuid ?? this.jewelleryTypeRefSuid,
      jewelleryTypeSuid: jewelleryTypeSuid ?? this.jewelleryTypeSuid,
      kgkCollection: kgkCollection ?? this.kgkCollection,
      kgkCollectionRefSuid: kgkCollectionRefSuid ?? this.kgkCollectionRefSuid,
      kgkCollectionSuid: kgkCollectionSuid ?? this.kgkCollectionSuid,
      metalColor1: metalColor1 ?? this.metalColor1,
      metalColor2: metalColor2 ?? this.metalColor2,
      metalColor3: metalColor3 ?? this.metalColor3,
      multipleFinishedViewImage: multipleFinishedViewImage ?? this.multipleFinishedViewImage,
      productDescription: productDescription ?? this.productDescription,
      productPriceIntCurrency: productPriceIntCurrency ?? this.productPriceIntCurrency,
      productPriceLocalCurrency: productPriceLocalCurrency ?? this.productPriceLocalCurrency,
      receivedDateTime: receivedDateTime ?? this.receivedDateTime,
      subareaCode: subareaCode ?? this.subareaCode,
      subareaId: subareaId ?? this.subareaId,
      subareaName: subareaName ?? this.subareaName,
      referenceId: referenceId ?? this.referenceId,
      customerRefSuid: customerRefSuid ?? this.customerRefSuid,
      currency: currency ?? this.currency,
      customerScopeRefSuid: customerScopeRefSuid ?? this.customerScopeRefSuid,
      guestUser: guestUser ?? this.guestUser,
      customerScope: customerScope ?? this.customerScope,
      componentDetails: componentDetails ?? this.componentDetails,
      finalPrice: finalPrice ?? this.finalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
    );
  }

  factory KgkCoutureDetails.fromJson(Map<String, dynamic> json) {
    return KgkCoutureDetails(
      id: json["_id"],
      suid: json["suid"],
      businessCategoryCode: json["business_category_code"],
      businessCategoryName: json["business_category_name"],
      businessCategoryRefSuid: json["business_category_ref_suid"],
      businessCategorySuid: json["business_category_suid"],
      cscCode: json["csc_code"],
      cscId: json["csc_id"],
      cscName: json["csc_name"],
      contractNoSkuNo: json["contract_no_sku_no"],
      countryCode: json["country_code"],
      customerCode: json["customer_code"],
      customerAliasName: json["customer_alias_name"],
      customerGroupName: json["customer_group_name"],
      customerSuid: json["customer_suid"],
      defaultMetalValueName: json["default_metal_value_name"],
      defaultMetalValueRefSuid: json["default_metal_value_ref_suid"],
      defaultMetalValueSuid: json["default_metal_value_suid"],
      exclusive: json["exclusive"],
      jewelleryTypeCode: json["jewellery_type_code"],
      jewelleryTypeName: json["jewellery_type_name"],
      jewelleryTypeRefSuid: json["jewellery_type_ref_suid"],
      jewelleryTypeSuid: json["jewellery_type_suid"],
      kgkCollection: json["kgk_collection"],
      kgkCollectionRefSuid: json["kgk_collection_ref_suid"],
      kgkCollectionSuid: json["kgk_collection_suid"],
      metalColor1: json["metal_color_1"],
      metalColor2: json["metal_color_2"],
      metalColor3: json["metal_color_3"],
      multipleFinishedViewImage: json["multiple_finished_view_image"],
      productDescription: json["product_description"],
      productPriceIntCurrency: json["product_price_int_currency"],
      productPriceLocalCurrency: json["product_price_local_currency"],
      receivedDateTime: DateTime.tryParse(json["received_date_time"] ?? ""),
      subareaCode: json["subarea_code"],
      subareaId: json["subarea_id"],
      subareaName: json["subarea_name"],
      referenceId: json["reference_id"],
      customerRefSuid: json["customer_ref_suid"],
      currency: json["currency"],
      customerScopeRefSuid: json["customer_scope_ref_suid"],
      guestUser: json["guest_user"],
      customerScope: json["customer_scope"],
      componentDetails: json["component_details"] == null
          ? []
          : List<ComponentDetail>.from(json["component_details"]!.map((x) => ComponentDetail.fromJson(x))),
      finalPrice: json["final_price"]?.toString().toDouble,
      discountPrice: json["discount_price"]?.toString().toDouble,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "business_category_code": businessCategoryCode,
        "business_category_name": businessCategoryName,
        "business_category_ref_suid": businessCategoryRefSuid,
        "business_category_suid": businessCategorySuid,
        "csc_code": cscCode,
        "csc_id": cscId,
        "csc_name": cscName,
        "contract_no_sku_no": contractNoSkuNo,
        "country_code": countryCode,
        "customer_code": customerCode,
        "customer_alias_name": customerAliasName,
        "customer_group_name": customerGroupName,
        "customer_suid": customerSuid,
        "default_metal_value_name": defaultMetalValueName,
        "default_metal_value_ref_suid": defaultMetalValueRefSuid,
        "default_metal_value_suid": defaultMetalValueSuid,
        "exclusive": exclusive,
        "jewellery_type_code": jewelleryTypeCode,
        "jewellery_type_name": jewelleryTypeName,
        "jewellery_type_ref_suid": jewelleryTypeRefSuid,
        "jewellery_type_suid": jewelleryTypeSuid,
        "kgk_collection": kgkCollection,
        "kgk_collection_ref_suid": kgkCollectionRefSuid,
        "kgk_collection_suid": kgkCollectionSuid,
        "metal_color_1": metalColor1,
        "metal_color_2": metalColor2,
        "metal_color_3": metalColor3,
        "multiple_finished_view_image": multipleFinishedViewImage,
        "product_description": productDescription,
        "product_price_int_currency": productPriceIntCurrency,
        "product_price_local_currency": productPriceLocalCurrency,
        "received_date_time": receivedDateTime?.toIso8601String(),
        "subarea_code": subareaCode,
        "subarea_id": subareaId,
        "subarea_name": subareaName,
        "reference_id": referenceId,
        "customer_ref_suid": customerRefSuid,
        "currency": currency,
        "customer_scope_ref_suid": customerScopeRefSuid,
        "guest_user": guestUser,
        "customer_scope": customerScope,
        "component_details": componentDetails.map((x) => x.toJson()).toList(),
        "final_price": finalPrice,
        "discount_price": discountPrice,
      };
}
