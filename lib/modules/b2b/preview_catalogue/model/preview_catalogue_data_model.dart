import 'package:kgk/kgk.dart';

class PreviewCatalogueDataModel {
  String? sId;
  String? name;
  String? catalogueType;
  String? cscCode;
  String? validFrom;
  String? validTo;
  bool? isPublic;
  int? createdBy;
  int? updatedBy;
  bool? status;
  String? templateId;
  List<JewelleryDataModel>? jewelleryDataList;
  List<DiamondDataModel>? diamondDataList;
  List<GemstoneDatum>? gemstoneDataList;
  List<CadLibraryListItemDataModel>? cadLibraryListItemDataList;
  List<DesignLibraryListItemDataModel>? designLibraryListItemDataList;
  List<CadLibraryListItemDataModel>? styleLibraryListItemDataList;
  List<SkuProductModel>? skuProductList;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  List<String>? sharedWith;
  int? iV;
  String? catalogueCoverImage;
  CatalogueTemplate? catalogueTemplate;
  bool? priceAccess;
  String? title;
  String? description;

  PreviewCatalogueDataModel({
    this.sId,
    this.name,
    this.catalogueType,
    this.cscCode,
    this.validFrom,
    this.validTo,
    this.isPublic,
    this.createdBy,
    this.updatedBy,
    this.status,
    this.templateId,
    this.diamondDataList,
    this.gemstoneDataList,
    this.jewelleryDataList,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.sharedWith,
    this.iV,
    this.catalogueCoverImage,
    this.catalogueTemplate,
    this.priceAccess,
    this.title,
    this.description,
  });

  /// Parse the product list based on catalogue type and populate the respective typed list.
  void _populateProductList(String catalogueType, List<dynamic>? jsonList) {
    if (jsonList == null) return;
    switch (catalogueType) {
      case "diamond":
        diamondDataList = jsonList.map((v) => DiamondDataModel.fromJson(v)).toList();
        break;
      case "jewellery":
        jewelleryDataList = jsonList.map((v) => JewelleryDataModel.fromJson(v)).toList();
        break;
      case "gemstone":
        gemstoneDataList = jsonList.map((v) => GemstoneDatum.fromJson(v)).toList();
        break;
      case "cad_library":
        cadLibraryListItemDataList = jsonList.map((v) => CadLibraryListItemDataModel.fromJson(v)).toList();
        break;
      case "design_library":
        designLibraryListItemDataList = jsonList.map((v) => DesignLibraryListItemDataModel.fromJson(v)).toList();
        break;
      case "style_library":
        styleLibraryListItemDataList = jsonList.map((v) => CadLibraryListItemDataModel.fromJson(v)).toList();
        break;
      case "sku_library":
        skuProductList = jsonList.map((v) => SkuProductModel.fromJson(v)).toList();
        break;
      default:
        break;
    }
  }

  PreviewCatalogueDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    catalogueType = json['catalogue_type'];
    cscCode = json['csc_code'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    isPublic = json['is_public'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    status = json['status'];
    templateId = json['template_id'];
    if (json['products'] != null && json['catalogue_type'] != null) {
      _populateProductList(json['catalogue_type'], json['products']);
    }
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sharedWith = json['shared_with'].cast<String>();
    iV = json['__v'];
    catalogueCoverImage = json['catalogue_cover_image'];
    catalogueTemplate = json['catalogue_template'] != null ? CatalogueTemplate.fromJson(json['catalogue_template']) : null;
    priceAccess = json['price_access'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['catalogue_type'] = catalogueType;
    data['csc_code'] = cscCode;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['is_public'] = isPublic;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['status'] = status;
    data['template_id'] = templateId;
    if (catalogueType == "diamond" && diamondDataList != null) {
      data['products'] = diamondDataList!.map((v) => v.toJson()).toList();
    } else if (catalogueType == "jewellery" && jewelleryDataList != null) {
      data['products'] = jewelleryDataList!.map((v) => v.toJson()).toList();
    } else if (catalogueType == "gemstone" && gemstoneDataList != null) {
      data['products'] = gemstoneDataList!.map((v) => v.toJson()).toList();
    }
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['shared_with'] = sharedWith;
    data['__v'] = iV;
    data['catalogue_cover_image'] = catalogueCoverImage;
    if (catalogueTemplate != null) {
      data['catalogue_template'] = catalogueTemplate!.toJson();
    }
    data['price_access'] = priceAccess;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class Products {
  String? sId;
  String? bestSeller;
  String? collection1;
  String? collectionGroupName;
  String? combination;
  List<ComponentDetails>? componentDetails;
  String? contractNumber;
  String? coordinatorSalesman;
  String? createdAt;
  String? cscCode;
  String? currency;
  String? customer;
  String? customerAliasName;
  String? exclusive;
  String? goodsOrigin;
  String? jewelleryType;
  String? locationName;
  String? market;
  List<String>? metalColor;
  String? metalCommodity;
  String? metalKt;
  List<String>? multipleCadViewImage;
  List<PreviewCatalogueMultipleFinishedViewImage>? multipleFinishedViewImage;
  String? newArrival;
  double? productPriceIntCurrency;
  int? qty;
  String? skuNo;
  String? subareaName;
  String? subareaCode;
  String? businessCategoryCode;
  String? suid;
  String? updatedAt;
  int? gemstoneWeight;
  List<String>? diamondColor;
  List<String>? internationalQuality;
  List<String>? internalQualityName;
  String? businessCategory;
  String? kgkCollectionName;
  int? crt;
  int? gms;
  String? metalColor1;
  String? metalColor1HexCode;

  Products(
      {this.sId,
      this.bestSeller,
      this.collection1,
      this.collectionGroupName,
      this.combination,
      this.componentDetails,
      this.contractNumber,
      this.coordinatorSalesman,
      this.createdAt,
      this.cscCode,
      this.currency,
      this.customer,
      this.customerAliasName,
      this.exclusive,
      this.goodsOrigin,
      this.jewelleryType,
      this.locationName,
      this.market,
      this.metalColor,
      this.metalCommodity,
      this.metalKt,
      this.multipleCadViewImage,
      this.multipleFinishedViewImage,
      this.newArrival,
      this.productPriceIntCurrency,
      this.qty,
      this.skuNo,
      this.subareaName,
      this.subareaCode,
      this.businessCategoryCode,
      this.suid,
      this.updatedAt,
      this.gemstoneWeight,
      this.diamondColor,
      this.internationalQuality,
      this.internalQualityName,
      this.businessCategory,
      this.kgkCollectionName,
      this.crt,
      this.gms,
      this.metalColor1,
      this.metalColor1HexCode});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bestSeller = json['best_seller'];
    collection1 = json['collection_1'];
    collectionGroupName = json['collection_group_name'];
    combination = json['combination'];
    if (json['component_details'] != null) {
      componentDetails = <ComponentDetails>[];
      json['component_details'].forEach((v) {
        componentDetails!.add(ComponentDetails.fromJson(v));
      });
    }
    contractNumber = json['contract_number'];
    coordinatorSalesman = json['coordinator_salesman'];
    createdAt = json['created_at'];
    cscCode = json['csc_code'];
    currency = json['currency'];
    customer = json['customer'];
    customerAliasName = json['customer_alias_name'];
    exclusive = json['exclusive'];
    goodsOrigin = json['goods_origin'];
    jewelleryType = json['jewellery_type'];
    locationName = json['location_name'];
    market = json['market'];
    metalColor = json['metal_color'].cast<String>();
    metalCommodity = json['metal_commodity'];
    metalKt = json['metal_kt'];
    multipleCadViewImage = json['multiple_cad_view_image'].cast<String>();
    if (json['multiple_finished_view_image'] != null) {
      multipleFinishedViewImage = <PreviewCatalogueMultipleFinishedViewImage>[];
      json['multiple_finished_view_image'].forEach((v) {
        multipleFinishedViewImage!.add(PreviewCatalogueMultipleFinishedViewImage.fromJson(v));
      });
    }
    newArrival = json['new_arrival'];
    productPriceIntCurrency = json['product_price_int_currency'];
    qty = json['qty'];
    skuNo = json['sku_no'];
    subareaName = json['subarea_name'];
    subareaCode = json['subarea_code'];
    businessCategoryCode = json['business_category_code'];
    suid = json['suid'];
    updatedAt = json['updated_at'];
    gemstoneWeight = json['gemstone_weight'];
    diamondColor = json['diamond_color'].cast<String>();
    internationalQuality = json['international_quality'].cast<String>();
    internalQualityName = json['internal_quality_name'].cast<String>();
    businessCategory = json['business_category'];
    kgkCollectionName = json['kgk_collection_name'];
    crt = json['crt'];
    gms = json['gms'];
    metalColor1 = json['metal_color_1'];
    metalColor1HexCode = json['metal_color_1_hex_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['best_seller'] = bestSeller;
    data['collection_1'] = collection1;
    data['collection_group_name'] = collectionGroupName;
    data['combination'] = combination;
    if (componentDetails != null) {
      data['component_details'] = componentDetails!.map((v) => v.toJson()).toList();
    }
    data['contract_number'] = contractNumber;
    data['coordinator_salesman'] = coordinatorSalesman;
    data['created_at'] = createdAt;
    data['csc_code'] = cscCode;
    data['currency'] = currency;
    data['customer'] = customer;
    data['customer_alias_name'] = customerAliasName;
    data['exclusive'] = exclusive;
    data['goods_origin'] = goodsOrigin;
    data['jewellery_type'] = jewelleryType;
    data['location_name'] = locationName;
    data['market'] = market;
    data['metal_color'] = metalColor;
    data['metal_commodity'] = metalCommodity;
    data['metal_kt'] = metalKt;
    data['multiple_cad_view_image'] = multipleCadViewImage;
    if (multipleFinishedViewImage != null) {
      data['multiple_finished_view_image'] = multipleFinishedViewImage!.map((v) => v.toJson()).toList();
    }
    data['new_arrival'] = newArrival;
    data['product_price_int_currency'] = productPriceIntCurrency;
    data['qty'] = qty;
    data['sku_no'] = skuNo;
    data['subarea_name'] = subareaName;
    data['subarea_code'] = subareaCode;
    data['business_category_code'] = businessCategoryCode;
    data['suid'] = suid;
    data['updated_at'] = updatedAt;
    data['gemstone_weight'] = gemstoneWeight;
    data['diamond_color'] = diamondColor;
    data['international_quality'] = internationalQuality;
    data['internal_quality_name'] = internalQualityName;
    data['business_category'] = businessCategory;
    data['kgk_collection_name'] = kgkCollectionName;
    data['crt'] = crt;
    data['gms'] = gms;
    data['metal_color_1'] = metalColor1;
    data['metal_color_1_hex_code'] = metalColor1HexCode;
    return data;
  }
}

class ComponentDetails {
  String? lotCode;
  String? rMName;
  String? commodityName;
  String? shape;
  String? color;
  String? cut;
  String? clarity;
  String? internationalQuality;
  String? sieveSize;
  String? mMSize;
  double? consumedQty1;
  double? consumedQty2;
  double? totalQty1;
  double? totalQty2;
  String? uOM1;
  String? uOM2;
  double? localCurrencyRate;
  double? localCurrencyAmount;
  double? intCurrencyRate;
  double? intCurrencyAmount;
  List<String>? certificateFile;

  ComponentDetails(
      {this.lotCode,
      this.rMName,
      this.commodityName,
      this.shape,
      this.color,
      this.cut,
      this.clarity,
      this.internationalQuality,
      this.sieveSize,
      this.mMSize,
      this.consumedQty1,
      this.consumedQty2,
      this.totalQty1,
      this.totalQty2,
      this.uOM1,
      this.uOM2,
      this.localCurrencyRate,
      this.localCurrencyAmount,
      this.intCurrencyRate,
      this.intCurrencyAmount,
      this.certificateFile});

  ComponentDetails.fromJson(Map<String, dynamic> json) {
    lotCode = json['LotCode'];
    rMName = json['RMName'];
    commodityName = json['CommodityName'];
    shape = json['Shape'];
    color = json['Color'];
    cut = json['Cut'];
    clarity = json['Clarity'];
    internationalQuality = json['InternationalQuality'];
    sieveSize = json['SieveSize'];
    mMSize = json['MMSize'];
    consumedQty1 = json['ConsumedQty1']?.toDouble();
    consumedQty2 = json['ConsumedQty2']?.toDouble();
    totalQty1 = json['TotalQty1']?.toDouble();
    totalQty2 = json['TotalQty2']?.toDouble();
    uOM1 = json['UOM1'];
    uOM2 = json['UOM2'];
    localCurrencyRate = json['LocalCurrencyRate'];
    localCurrencyAmount = json['LocalCurrencyAmount'];
    intCurrencyRate = json['IntCurrencyRate'];
    intCurrencyAmount = json['IntCurrencyAmount'];
    certificateFile = json['CertificateFile'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LotCode'] = lotCode;
    data['RMName'] = rMName;
    data['CommodityName'] = commodityName;
    data['Shape'] = shape;
    data['Color'] = color;
    data['Cut'] = cut;
    data['Clarity'] = clarity;
    data['InternationalQuality'] = internationalQuality;
    data['SieveSize'] = sieveSize;
    data['MMSize'] = mMSize;
    data['ConsumedQty1'] = consumedQty1;
    data['ConsumedQty2'] = consumedQty2;
    data['TotalQty1'] = totalQty1;
    data['TotalQty2'] = totalQty2;
    data['UOM1'] = uOM1;
    data['UOM2'] = uOM2;
    data['LocalCurrencyRate'] = localCurrencyRate;
    data['LocalCurrencyAmount'] = localCurrencyAmount;
    data['IntCurrencyRate'] = intCurrencyRate;
    data['IntCurrencyAmount'] = intCurrencyAmount;
    data['CertificateFile'] = certificateFile;
    return data;
  }
}

class PreviewCatalogueMultipleFinishedViewImage {
  int? contId;
  String? contractNo;
  String? contractImage;
  String? styleImage;
  String? iMAGEAVAILABLE;
  String? iMAGEAVAILABLEMA;
  String? iMAGEURL;
  String? highRes1;
  String? highRes2;
  String? highRes3;
  String? highRes4;

  PreviewCatalogueMultipleFinishedViewImage(
      {this.contId,
      this.contractNo,
      this.contractImage,
      this.styleImage,
      this.iMAGEAVAILABLE,
      this.iMAGEAVAILABLEMA,
      this.iMAGEURL,
      this.highRes1,
      this.highRes2,
      this.highRes3,
      this.highRes4});

  PreviewCatalogueMultipleFinishedViewImage.fromJson(Map<String, dynamic> json) {
    contId = json['cont_id'];
    contractNo = json['ContractNo'];
    contractImage = json['ContractImage'];
    styleImage = json['StyleImage'];
    iMAGEAVAILABLE = json['IMAGE_AVAILABLE'];
    iMAGEAVAILABLEMA = json['IMAGE_AVAILABLE_MA'];
    iMAGEURL = json['IMAGE_URL'];
    highRes1 = json['high_res1'];
    highRes2 = json['high_res2'];
    highRes3 = json['high_res3'];
    highRes4 = json['high_res4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cont_id'] = contId;
    data['ContractNo'] = contractNo;
    data['ContractImage'] = contractImage;
    data['StyleImage'] = styleImage;
    data['IMAGE_AVAILABLE'] = iMAGEAVAILABLE;
    data['IMAGE_AVAILABLE_MA'] = iMAGEAVAILABLEMA;
    data['IMAGE_URL'] = iMAGEURL;
    data['high_res1'] = highRes1;
    data['high_res2'] = highRes2;
    data['high_res3'] = highRes3;
    data['high_res4'] = highRes4;
    return data;
  }
}

class CatalogueTemplate {
  String? sId;
  String? imageSrc;
  String? title;
  String? description;
  String? slug;

  CatalogueTemplate({this.sId, this.imageSrc, this.title, this.description, this.slug});

  CatalogueTemplate.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    imageSrc = json['imageSrc'];
    title = json['title'];
    description = json['description'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['imageSrc'] = imageSrc;
    data['title'] = title;
    data['description'] = description;
    data['slug'] = slug;
    return data;
  }
}
