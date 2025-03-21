import 'package:kgk/kgk.dart';

class DesignLibraryListItemDataModel {
  String? sId;
  String? approximateModelWeight;
  String? bestSeller;
  String? businessCategoryCode;
  String? concept;
  String? conceptNo;
  String? conceptRefSuid;
  String? conceptSuid;
  String? createdAt;
  String? customerCode;
  String? defaultDiamondQuality;
  String? designBriefFormNumber;
  String? designComplexity;
  String? designCreatedDate;
  String? designDescription;
  String? designNumber;
  int? designerId;
  String? designerName;
  String? exclusiveCustomer;
  String? imageSketch;
  String? importedFrom;
  String? isCadCreated;
  String? isDesignUsed;
  String? isExclusive;
  String? jewelleryGroup;
  int? jewelleryGroupRefSuid;
  String? jewelleryGroupSuid;
  String? jewelleryType;
  String? kgkCollection;
  String? market;
  String? newArrival;
  String? receivedDateTime;
  int? refSuid;
  int? refSuidCustomerCode;
  String? referenceId;
  List<StoneCardDetails>? stoneCardDetails;
  String? subareaCode;
  int? subareaId;
  String? subareaName;
  String? suid;
  String? suidCustomerCode;
  String? updatedAt;
  String? updatedDateTime;
  String? businessCategory;
  String? contractNoSkuNo;
  String? crt;
  String? gms;
  String? businessCategoryName;
  String? jewelleryTypeName;
  List<String>? images;
  String? productDescription;
  bool? isAddedToCart;
  bool? isCommented;

  DesignLibraryListItemDataModel(
      {this.sId,
      this.approximateModelWeight,
      this.bestSeller,
      this.businessCategoryCode,
      this.concept,
      this.conceptNo,
      this.conceptRefSuid,
      this.conceptSuid,
      this.createdAt,
      this.customerCode,
      this.defaultDiamondQuality,
      this.designBriefFormNumber,
      this.designComplexity,
      this.designCreatedDate,
      this.designDescription,
      this.designNumber,
      this.designerId,
      this.designerName,
      this.exclusiveCustomer,
      this.imageSketch,
      this.importedFrom,
      this.isCadCreated,
      this.isDesignUsed,
      this.isExclusive,
      this.jewelleryGroup,
      this.jewelleryGroupRefSuid,
      this.jewelleryGroupSuid,
      this.jewelleryType,
      this.kgkCollection,
      this.market,
      this.newArrival,
      this.receivedDateTime,
      this.refSuid,
      this.refSuidCustomerCode,
      this.referenceId,
      this.stoneCardDetails,
      this.subareaCode,
      this.subareaId,
      this.subareaName,
      this.suid,
      this.suidCustomerCode,
      this.updatedAt,
      this.updatedDateTime,
      this.businessCategory,
      this.contractNoSkuNo,
      this.crt,
      this.gms,
      this.businessCategoryName,
      this.jewelleryTypeName,
      this.images,
      this.productDescription,
      this.isCommented = false,
      this.isAddedToCart});

  DesignLibraryListItemDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    approximateModelWeight = json['approximate_model_weight'];
    bestSeller = json['best_seller'];
    businessCategoryCode = json['business_category_code'];
    concept = json['concept'];
    conceptNo = json['concept_no'];
    conceptRefSuid = json['concept_ref_suid'];
    conceptSuid = json['concept_suid'];
    createdAt = json['created_at'];
    customerCode = json['customer_code'];
    defaultDiamondQuality = json['default_diamond_quality'];
    designBriefFormNumber = json['design_brief_form_number'];
    designComplexity = json['design_complexity'];
    designCreatedDate = json['design_created_date'];
    designDescription = json['design_description'];
    designNumber = json['design_number'];
    designerId = json['designer_id'];
    designerName = json['designer_name'];
    exclusiveCustomer = json['exclusive_customer'];
    imageSketch = json['image_sketch'];
    importedFrom = json['imported_from'];
    isCadCreated = json['is_cad_created'];
    isDesignUsed = json['is_design_used'];
    isExclusive = json['is_exclusive'];
    jewelleryGroup = json['jewellery_group'];
    jewelleryGroupRefSuid = json['jewellery_group_ref_suid'];
    jewelleryGroupSuid = json['jewellery_group_suid'];
    jewelleryType = json['jewellery_type'];
    kgkCollection = json['kgk_collection'];
    market = json['market'];
    newArrival = json['new_arrival'];
    receivedDateTime = json['received_date_time'];
    refSuid = json['ref_suid'];
    refSuidCustomerCode = json['ref_suid_customer_code'];
    referenceId = json['reference_id'];
    if (json['stone_card_details'] != null) {
      stoneCardDetails = <StoneCardDetails>[];
      json['stone_card_details'].forEach((v) {
        stoneCardDetails?.add(StoneCardDetails.fromJson(v));
      });
    }
    subareaCode = json['subarea_code'];
    subareaId = json['subarea_id'];
    subareaName = json['subarea_name'];
    suid = json['suid'];
    suidCustomerCode = json['suid_customer_code'];
    updatedAt = json['updated_at'];
    updatedDateTime = json['updated_date_time'];
    businessCategory = json['business_category'];
    contractNoSkuNo = json['contract_no_sku_no'];
    crt = json['crt']?.toString();
    gms = json['gms']?.toString();
    businessCategoryName = json['business_category_name'];
    jewelleryTypeName = json['jewellery_type_name'];
    if (json['images'] != null) {
      images = [];
      for (var e in (json['images'] as List<dynamic>)) {
        if (e != null) {
          images!.add(e.toString());
        }
      }
    } else {
      images = null;
    }
    productDescription = json['product_description'];
    isAddedToCart = json['isAddedToCart'];
    isCommented = json['is_commented'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['approximate_model_weight'] = approximateModelWeight;
    data['best_seller'] = bestSeller;
    data['business_category_code'] = businessCategoryCode;
    data['concept'] = concept;
    data['concept_no'] = conceptNo;
    data['concept_ref_suid'] = conceptRefSuid;
    data['concept_suid'] = conceptSuid;
    data['created_at'] = createdAt;
    data['customer_code'] = customerCode;
    data['default_diamond_quality'] = defaultDiamondQuality;
    data['design_brief_form_number'] = designBriefFormNumber;
    data['design_complexity'] = designComplexity;
    data['design_created_date'] = designCreatedDate;
    data['design_description'] = designDescription;
    data['design_number'] = designNumber;
    data['designer_id'] = designerId;
    data['designer_name'] = designerName;
    data['exclusive_customer'] = exclusiveCustomer;
    data['image_sketch'] = imageSketch;
    data['imported_from'] = importedFrom;
    data['is_cad_created'] = isCadCreated;
    data['is_design_used'] = isDesignUsed;
    data['is_exclusive'] = isExclusive;
    data['jewellery_group'] = jewelleryGroup;
    data['jewellery_group_ref_suid'] = jewelleryGroupRefSuid;
    data['jewellery_group_suid'] = jewelleryGroupSuid;
    data['jewellery_type'] = jewelleryType;
    data['kgk_collection'] = kgkCollection;
    data['market'] = market;
    data['new_arrival'] = newArrival;
    data['received_date_time'] = receivedDateTime;
    data['ref_suid'] = refSuid;
    data['ref_suid_customer_code'] = refSuidCustomerCode;
    data['reference_id'] = referenceId;
    if (stoneCardDetails != null) {
      data['stone_card_details'] = stoneCardDetails?.map((v) => v.toJson()).toList();
    }
    data['subarea_code'] = subareaCode;
    data['subarea_id'] = subareaId;
    data['subarea_name'] = subareaName;
    data['suid'] = suid;
    data['suid_customer_code'] = suidCustomerCode;
    data['updated_at'] = updatedAt;
    data['updated_date_time'] = updatedDateTime;

    data['business_category'] = businessCategory;
    data['contract_no_sku_no'] = contractNoSkuNo;
    data['crt'] = crt;
    data['gms'] = gms;
    data['business_category_name'] = businessCategoryName;
    data['jewellery_type_name'] = jewelleryTypeName;
    data['images'] = images;
    data['product_description'] = productDescription;
    data['isAddedToCart'] = isAddedToCart;
    return data;
  }
}
