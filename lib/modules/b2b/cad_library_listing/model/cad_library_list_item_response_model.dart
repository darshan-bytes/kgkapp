class CadLibraryListItemDataModel {
  String? sId;
  double? approximateModelWeight;
  String? businessCategoryCode;
  String? cancelHoldStatus;
  String? customerCode;
  String? customerCodeRefSuid;
  String? customerCodeSuid;
  String? customerCollection;
  String? customerCollectionSuid;
  String? customerStyleReferenceNumber;
  String? designCreatedDt;
  String? designNumber;
  String? designerName;
  String? imageSketch;
  String? isExclusive;
  String? isFindingRequired;
  String? isHighend;
  String? isModelApproved;
  String? isStoneCardLocked;
  String? isVariation;
  String? jewelleryGroup;
  int? jewelleryGroupRefSuid;
  String? jewelleryGroupSuid;
  String? jewelleryType;
  int? kgkCollectionRefSuid;
  String? kgkCollectionSuid;
  int? linksCount;
  int? msrp;
  String? market;
  int? marketRefSuid;
  String? marketSuid;
  String? miraclePlate;
  int? modelPartsCount;
  String? receivedDateTime;
  int? refSuid;
  int? refSuidStyleNumber;
  int? salesPrice;
  String? software;
  String? styleCreatedDate;
  String? subareaCode;
  int? subareaId;
  String? suid;
  String? suidStyleNumber;
  String? uom;
  String? updatedDateTime;
  String? referenceId;
  String? createdAt;
  String? updatedAt;
  List<FindingDetails>? findingDetails;
  List<String>? imageCadRender;
  List<StoneCardDetails>? stoneCardDetails;
  String? imageCad;
  String? businessCategory;
  String? kgkCollectionName;
  String? crt;
  String? gms;
  String? businessCategoryName;
  String? jewelleryTypeName;
  String? kgkCollection;
  List<String>? images;
  bool? isAddedToCart;
  String? autoDescription;
  String? styleNumber;
  double? diamondWeight;
  double? metalWeight;
  String? contractNoSkuNo;
  String? productDescription;

  CadLibraryListItemDataModel({
    this.sId,
    this.approximateModelWeight,
    this.businessCategoryCode,
    this.cancelHoldStatus,
    this.customerCode,
    this.customerCodeRefSuid,
    this.customerCodeSuid,
    this.customerCollection,
    this.customerCollectionSuid,
    this.customerStyleReferenceNumber,
    this.designCreatedDt,
    this.designNumber,
    this.designerName,
    this.imageSketch,
    this.isExclusive,
    this.isFindingRequired,
    this.isHighend,
    this.isModelApproved,
    this.isStoneCardLocked,
    this.isVariation,
    this.jewelleryGroup,
    this.jewelleryGroupRefSuid,
    this.jewelleryGroupSuid,
    this.jewelleryType,
    this.kgkCollectionRefSuid,
    this.kgkCollectionSuid,
    this.linksCount,
    this.msrp,
    this.market,
    this.marketRefSuid,
    this.marketSuid,
    this.miraclePlate,
    this.modelPartsCount,
    this.receivedDateTime,
    this.refSuid,
    this.refSuidStyleNumber,
    this.salesPrice,
    this.software,
    this.styleCreatedDate,
    this.subareaCode,
    this.subareaId,
    this.suid,
    this.suidStyleNumber,
    this.uom,
    this.updatedDateTime,
    this.referenceId,
    this.createdAt,
    this.updatedAt,
    this.findingDetails,
    this.imageCadRender,
    this.stoneCardDetails,
    this.imageCad,
    this.businessCategory,
    this.kgkCollectionName,
    this.crt,
    this.gms,
    this.businessCategoryName,
    this.jewelleryTypeName,
    this.kgkCollection,
    this.images,
    this.isAddedToCart,
    this.autoDescription,
    this.styleNumber,
    this.diamondWeight,
    this.metalWeight,
    this.contractNoSkuNo,
    this.productDescription,
  });

  CadLibraryListItemDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    approximateModelWeight = json['approximate_model_weight']?.toDouble();
    businessCategoryCode = json['business_category_code'];
    cancelHoldStatus = json['cancel_hold_status'];
    customerCode = json['customer_code'];
    customerCodeRefSuid = json['customer_code_ref_suid'];
    customerCodeSuid = json['customer_code_suid'];
    customerCollection = json['customer_collection'];
    customerCollectionSuid = json['customer_collection_suid'];
    customerStyleReferenceNumber = json['customer_style_reference_number'];
    designCreatedDt = json['design_created_dt'];
    designNumber = json['design_number'];
    designerName = json['designer_name'];
    imageSketch = json['image_sketch'];
    isExclusive = json['is_exclusive'];
    isFindingRequired = json['is_finding_required'];
    isHighend = json['is_highend'];
    isModelApproved = json['is_model_approved'];
    isStoneCardLocked = json['is_stone_card_locked'];
    isVariation = json['is_variation'];
    jewelleryGroup = json['jewellery_group'];
    jewelleryGroupRefSuid = json['jewellery_group_ref_suid'];
    jewelleryGroupSuid = json['jewellery_group_suid'];
    jewelleryType = json['jewellery_type'];
    kgkCollectionRefSuid = json['kgk_collection_ref_suid'];
    kgkCollectionSuid = json['kgk_collection_suid'];
    linksCount = json['links_count'];
    msrp = json['msrp'];
    market = json['market'];
    marketRefSuid = json['market_ref_suid'];
    marketSuid = json['market_suid'];
    miraclePlate = json['miracle_plate'];
    modelPartsCount = json['model_parts_count'];
    receivedDateTime = json['received_date_time'];
    refSuid = json['ref_suid'];
    refSuidStyleNumber = json['ref_suid_style_number'];
    salesPrice = json['sales_price'];
    software = json['software'];
    styleCreatedDate = json['style_created_date'];
    subareaCode = json['subarea_code'];
    subareaId = json['subarea_id'];
    suid = json['suid'];
    suidStyleNumber = json['suid_style_number'];
    uom = json['uom'];
    updatedDateTime = json['updated_date_time'];
    referenceId = json['reference_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['finding_details'] != null) {
      findingDetails = <FindingDetails>[];
      json['finding_details'].forEach((v) {
        findingDetails!.add(FindingDetails.fromJson(v));
      });
    }
    imageCadRender = json['image_cad_render'].cast<String>();
    if (json['stone_card_details'] != null) {
      stoneCardDetails = <StoneCardDetails>[];
      json['stone_card_details'].forEach((v) {
        stoneCardDetails!.add(StoneCardDetails.fromJson(v));
      });
    }
    imageCad = json['image_cad'];
    businessCategory = json['business_category'];
    kgkCollectionName = json['kgk_collection_name'];
    crt = json['crt']?.toString();
    gms = json['gms']?.toString();
    businessCategoryName = json['business_category_name'];
    jewelleryTypeName = json['jewellery_type_name'];
    kgkCollection = json['kgk_collection'];
    images = json['images'].cast<String>();
    isAddedToCart = json['isAddedToCart'];
    autoDescription = json['auto_description'];
    styleNumber = json['style_number'];
    diamondWeight = json['diamond_weight']?.toDouble();
    metalWeight = json['metal_weight']?.toDouble();
    contractNoSkuNo = json['contract_no_sku_no'];
    productDescription = json['product_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['approximate_model_weight'] = approximateModelWeight;
    data['business_category_code'] = businessCategoryCode;
    data['cancel_hold_status'] = cancelHoldStatus;
    data['customer_code'] = customerCode;
    data['customer_code_ref_suid'] = customerCodeRefSuid;
    data['customer_code_suid'] = customerCodeSuid;
    data['customer_collection'] = customerCollection;
    data['customer_collection_suid'] = customerCollectionSuid;
    data['customer_style_reference_number'] = customerStyleReferenceNumber;
    data['design_created_dt'] = designCreatedDt;
    data['design_number'] = designNumber;
    data['designer_name'] = designerName;
    data['image_sketch'] = imageSketch;
    data['is_exclusive'] = isExclusive;
    data['is_finding_required'] = isFindingRequired;
    data['is_highend'] = isHighend;
    data['is_model_approved'] = isModelApproved;
    data['is_stone_card_locked'] = isStoneCardLocked;
    data['is_variation'] = isVariation;
    data['jewellery_group'] = jewelleryGroup;
    data['jewellery_group_ref_suid'] = jewelleryGroupRefSuid;
    data['jewellery_group_suid'] = jewelleryGroupSuid;
    data['jewellery_type'] = jewelleryType;
    data['kgk_collection_ref_suid'] = kgkCollectionRefSuid;
    data['kgk_collection_suid'] = kgkCollectionSuid;
    data['links_count'] = linksCount;
    data['msrp'] = msrp;
    data['market'] = market;
    data['market_ref_suid'] = marketRefSuid;
    data['market_suid'] = marketSuid;
    data['miracle_plate'] = miraclePlate;
    data['model_parts_count'] = modelPartsCount;
    data['received_date_time'] = receivedDateTime;
    data['ref_suid'] = refSuid;
    data['ref_suid_style_number'] = refSuidStyleNumber;
    data['sales_price'] = salesPrice;
    data['software'] = software;
    data['style_created_date'] = styleCreatedDate;
    data['subarea_code'] = subareaCode;
    data['subarea_id'] = subareaId;
    data['suid'] = suid;
    data['suid_style_number'] = suidStyleNumber;
    data['uom'] = uom;
    data['updated_date_time'] = updatedDateTime;
    data['reference_id'] = referenceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['finding_details'] = findingDetails;
    data['image_cad_render'] = imageCadRender;
    if (stoneCardDetails != null) {
      data['stone_card_details'] = stoneCardDetails!.map((v) => v.toJson()).toList();
    }
    data['image_cad'] = imageCad;
    data['business_category'] = businessCategory;
    data['kgk_collection_name'] = kgkCollectionName;
    data['crt'] = crt;
    data['gms'] = gms;
    data['business_category_name'] = businessCategoryName;
    data['jewellery_type_name'] = jewelleryTypeName;
    data['kgk_collection'] = kgkCollection;
    data['images'] = images;
    data['isAddedToCart'] = isAddedToCart;
    return data;
  }
}

class FindingDetails {
  String? findingName;
  String? findingDescription;
  String? findingWeight;
  String? sizeLength;
  String? laserLinking;
  String? tourchShoulder;
  String? remarks;
  String? sId;

  FindingDetails(
      {this.findingName,
      this.findingDescription,
      this.findingWeight,
      this.sizeLength,
      this.laserLinking,
      this.tourchShoulder,
      this.remarks,
      this.sId});

  FindingDetails.fromJson(Map<String, dynamic> json) {
    findingName = json['FindingName'];
    findingDescription = json['FindingDescription'];
    findingWeight = json['FindingWeight'];
    sizeLength = json['SizeLength'];
    laserLinking = json['LaserLinking'];
    tourchShoulder = json['TourchShoulder'];
    remarks = json['Remarks'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FindingName'] = findingName;
    data['FindingDescription'] = findingDescription;
    data['FindingWeight'] = findingWeight;
    data['SizeLength'] = sizeLength;
    data['LaserLinking'] = laserLinking;
    data['TourchShoulder'] = tourchShoulder;
    data['Remarks'] = remarks;
    data['_id'] = sId;
    return data;
  }
}

class StoneCardDetails {
  String? stoneCardSuid;
  int? stoneCardRefSuid;
  String? stoneCardNumber;
  String? styleSkuNumber;
  List<String>? image;
  List<ComponentDetails>? componentDetails;
  String? sId;
  String? cADRenderImageAvailable;

  StoneCardDetails(
      {this.stoneCardSuid,
      this.stoneCardRefSuid,
      this.stoneCardNumber,
      this.styleSkuNumber,
      this.image,
      this.componentDetails,
      this.sId,
      this.cADRenderImageAvailable});

  StoneCardDetails.fromJson(Map<String, dynamic> json) {
    stoneCardSuid = json['StoneCardSuid'];
    stoneCardRefSuid = json['StoneCardRefSuid'];
    stoneCardNumber = json['StoneCardNumber'];
    styleSkuNumber = json['StyleSkuNumber'];
    image = json['Image'].cast<String>();
    if (json['ComponentDetails'] != null) {
      componentDetails = <ComponentDetails>[];
      json['ComponentDetails'].forEach((v) {
        componentDetails!.add(ComponentDetails.fromJson(v));
      });
    }
    sId = json['_id'];
    cADRenderImageAvailable = json['CADRenderImageAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StoneCardSuid'] = stoneCardSuid;
    data['StoneCardRefSuid'] = stoneCardRefSuid;
    data['StoneCardNumber'] = stoneCardNumber;
    data['StyleSkuNumber'] = styleSkuNumber;
    data['Image'] = image;
    if (componentDetails != null) {
      data['ComponentDetails'] = componentDetails!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['CADRenderImageAvailable'] = cADRenderImageAvailable;
    return data;
  }
}

class ComponentDetails {
  String? rM;
  String? commodity;
  String? origin;
  String? shape;
  String? color;
  String? cut;
  String? sieve;
  String? mMSize;
  double? pPWt;
  int? pcs;
  double? minWt;
  double? maxWt;
  String? settingType;
  String? method;
  String? centerStone;
  String? clientStone;
  String? sId;

  ComponentDetails(
      {this.rM,
      this.commodity,
      this.origin,
      this.shape,
      this.color,
      this.cut,
      this.sieve,
      this.mMSize,
      this.pPWt,
      this.pcs,
      this.minWt,
      this.maxWt,
      this.settingType,
      this.method,
      this.centerStone,
      this.clientStone,
      this.sId});

  ComponentDetails.fromJson(Map<String, dynamic> json) {
    rM = json['RM'];
    commodity = json['Commodity'];
    origin = json['Origin'];
    shape = json['Shape'];
    color = json['Color'];
    cut = json['cut'];
    sieve = json['Sieve'];
    mMSize = json['MMSize'];
    pPWt = json['PPWt']?.toDouble();
    pcs = json['Pcs'];
    minWt = json['MinWt']?.toDouble();
    maxWt = json['MaxWt']?.toDouble();
    settingType = json['SettingType'];
    method = json['Method'];
    centerStone = json['CenterStone'];
    clientStone = json['ClientStone'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['RM'] = rM;
    data['Commodity'] = commodity;
    data['Origin'] = origin;
    data['Shape'] = shape;
    data['Color'] = color;
    data['cut'] = cut;
    data['Sieve'] = sieve;
    data['MMSize'] = mMSize;
    data['PPWt'] = pPWt;
    data['Pcs'] = pcs;
    data['MinWt'] = minWt;
    data['MaxWt'] = maxWt;
    data['SettingType'] = settingType;
    data['Method'] = method;
    data['CenterStone'] = centerStone;
    data['ClientStone'] = clientStone;
    data['_id'] = sId;
    return data;
  }
}
