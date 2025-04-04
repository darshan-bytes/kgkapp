import 'package:kgk/kgk.dart';

class DiyStyleListModel {
  DiyStyleListModel({
    required this.receivedDateTime,
    required this.refSuid,
    required this.importedFrom,
    required this.subareaCode,
    required this.suid,
    required this.updatedDateTime,
    required this.createdAt,
    required this.updatedAt,
    required this.metal2,
    required this.jewelleryTypeName,
    required this.metal3,
    required this.linksCount,
    required this.modelApprovedDate,
    required this.partOfEnsembles,
    required this.businessCategoryName,
    required this.imageCadAvailable,
    required this.styleComplexity,
    required this.isVariation,
    required this.subJewelleryTypeCode,
    required this.isHighend,
    required this.msrp,
    required this.miraclePlate,
    required this.imageSketch,
    required this.subJewelleryTypeName,
    required this.isExclusive,
    required this.inHouse,
    required this.customerCode,
    required this.styleReferenceNumber,
    required this.designCreatedDt,
    required this.styleNumber,
    required this.bestSeller,
    required this.jewelleryGroup,
    required this.isFindingRequired,
    required this.styleCreatedDate,
    required this.longDescription,
    required this.designNumber,
    required this.modelPartsCount,
    required this.cancelHoldStatus,
    required this.isStoneCardLocked,
    required this.referenceId,
    required this.applicableDiamondShape,
    required this.metal,
    required this.customerCollection,
    required this.remarks,
    required this.defaultMetalKaratage,
    required this.modelWeight3,
    required this.customerGroup,
    required this.modelWeight2,
    required this.market,
    required this.isModelApproved,
    required this.kgkCollectionCode,
    required this.noOfStonesRecut,
    required this.stoneCardLocked,
    required this.jewelleryType,
    required this.businessCategoryCode,
    required this.autoDescription,
    required this.customerCollectionRefSuid,
    required this.customerAliasName,
    required this.salesPrice,
    required this.approximateModelWeight,
    required this.kgkCollectionName,
    required this.newArrival,
    required this.customerName,
    required this.subCollection,
    required this.metalLotcode,
    required this.metalColors,
    required this.productSize,
    required this.uom,
    required this.designerName,
    required this.stylePurpose,
    required this.settingTypeName,
    required this.id,
    required this.metalColor1HexCode,
    required this.finalPrice,
    required this.discountPrice,
    required this.components,
    this.isAddedToCart = false,
  });

  final DateTime? receivedDateTime;
  final String? refSuid;
  final String? importedFrom;
  final String? subareaCode;
  final String? suid;
  final DateTime? updatedDateTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic metal2;
  final String? jewelleryTypeName;
  final dynamic metal3;
  final String? linksCount;
  final dynamic modelApprovedDate;
  final dynamic partOfEnsembles;
  final String? businessCategoryName;
  final String? imageCadAvailable;
  final dynamic styleComplexity;
  final dynamic isVariation;
  final dynamic subJewelleryTypeCode;
  final String? isHighend;
  final String? msrp;
  final dynamic miraclePlate;
  final String? imageSketch;
  final dynamic subJewelleryTypeName;
  final String? isExclusive;
  final String? inHouse;
  final String? customerCode;
  final String? styleReferenceNumber;
  final dynamic designCreatedDt;
  final String? styleNumber;
  final String? bestSeller;
  final String? jewelleryGroup;
  final dynamic isFindingRequired;
  final String? styleCreatedDate;
  final String? longDescription;
  final String? designNumber;
  final dynamic modelPartsCount;
  final String? cancelHoldStatus;
  final String? isStoneCardLocked;
  final String? referenceId;
  final List<ApplicableDiamondShape> applicableDiamondShape;
  final String? metal;
  final String? customerCollection;
  final dynamic remarks;
  final String? defaultMetalKaratage;
  final dynamic modelWeight3;
  final dynamic customerGroup;
  final dynamic modelWeight2;
  final String? market;
  final String? isModelApproved;
  final String? kgkCollectionCode;
  final dynamic noOfStonesRecut;
  final dynamic stoneCardLocked;
  final String? jewelleryType;
  final String? businessCategoryCode;
  final String? autoDescription;
  final String? customerCollectionRefSuid;
  final String? customerAliasName;
  final int? salesPrice;
  final String? approximateModelWeight;
  final String? kgkCollectionName;
  final String? newArrival;
  final String? customerName;
  final String? subCollection;
  final String? metalLotcode;
  final List<MetalColor> metalColors;
  final String? productSize;
  final String? uom;
  final String? designerName;
  final dynamic stylePurpose;
  final String? settingTypeName;
  final String? id;
  final String? metalColor1HexCode;
  final double? finalPrice;
  final double? discountPrice;
  final List<Component> components;
  final bool isAddedToCart;

  factory DiyStyleListModel.fromJson(Map<String, dynamic> json) {
    return DiyStyleListModel(
      receivedDateTime: DateTime.tryParse(json["received_date_time"] ?? ""),
      refSuid: json["ref_suid"],
      importedFrom: json["imported_from"],
      subareaCode: json["subarea_code"],
      suid: json["suid"],
      updatedDateTime: DateTime.tryParse(json["updated_date_time"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      metal2: json["metal_2"],
      jewelleryTypeName: json["jewellery_type_name"],
      metal3: json["metal_3"],
      linksCount: json["links_count"],
      modelApprovedDate: json["model_approved_date"],
      partOfEnsembles: json["part_of_ensembles"],
      businessCategoryName: json["business_category_name"],
      imageCadAvailable: json["image_cad_available"],
      styleComplexity: json["style_complexity"],
      isVariation: json["is_variation"],
      subJewelleryTypeCode: json["sub_jewellery_type_code"],
      isHighend: json["is_highend"],
      msrp: json["msrp"],
      miraclePlate: json["miracle_plate"],
      imageSketch: json["image_sketch"],
      subJewelleryTypeName: json["sub_jewellery_type_name"],
      isExclusive: json["is_exclusive"],
      inHouse: json["in_house"],
      customerCode: json["customer_code"],
      styleReferenceNumber: json["style_reference_number"],
      designCreatedDt: json["design_created_dt"],
      styleNumber: json["style_number"],
      bestSeller: json["best_seller"],
      jewelleryGroup: json["jewellery_group"],
      isFindingRequired: json["is_finding_required"],
      styleCreatedDate: json["style_created_date"],
      longDescription: json["long_description"],
      designNumber: json["design_number"],
      modelPartsCount: json["model_parts_count"],
      cancelHoldStatus: json["cancel_hold_status"],
      isStoneCardLocked: json["is_stone_card_locked"],
      referenceId: json["reference_id"],
      applicableDiamondShape: json["applicable_diamond_shape"] == null
          ? []
          : List<ApplicableDiamondShape>.from(json["applicable_diamond_shape"]!.map((x) => ApplicableDiamondShape.fromJson(x))),
      metal: json["metal"],
      customerCollection: json["customer_collection"],
      remarks: json["remarks"],
      defaultMetalKaratage: json["default_metal_karatage"],
      modelWeight3: json["model_weight3"],
      customerGroup: json["customer_group"],
      modelWeight2: json["model_weight2"],
      market: json["market"],
      isModelApproved: json["is_model_approved"],
      kgkCollectionCode: json["kgk_collection_code"],
      noOfStonesRecut: json["no_of_stones_recut"],
      stoneCardLocked: json["stone_card_locked"],
      jewelleryType: json["jewellery_type"],
      businessCategoryCode: json["business_category_code"],
      autoDescription: json["auto_description"],
      customerCollectionRefSuid: json["customer_collection_ref_suid"],
      customerAliasName: json["customer_alias_name"],
      salesPrice: json["sales_price"],
      approximateModelWeight: json["approximate_model_weight"],
      kgkCollectionName: json["kgk_collection_name"],
      newArrival: json["new_arrival"],
      customerName: json["customer_name"],
      subCollection: json["sub_collection"],
      metalLotcode: json["metal_lotcode"],
      metalColors: json["metal_colors"] == null ? [] : List<MetalColor>.from(json["metal_colors"]!.map((x) => MetalColor.fromJson(x))),
      productSize: json["product_size"],
      uom: json["uom"],
      designerName: json["designer_name"],
      stylePurpose: json["style_purpose"],
      settingTypeName: json["setting_type_name"],
      id: json["_id"],
      metalColor1HexCode: json["metal_color_1_hex_code"],
      finalPrice: json["final_price"]?.toString().toDouble,
      discountPrice: json["discount_price"]?.toString().toDouble,
      components: json["components"] == null ? [] : List<Component>.from(json["components"].map((x) => Component.fromJson(x))),
        isAddedToCart: json["isAddedToCart"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "received_date_time": receivedDateTime?.toIso8601String(),
        "ref_suid": refSuid,
        "imported_from": importedFrom,
        "subarea_code": subareaCode,
        "suid": suid,
        "updated_date_time": updatedDateTime?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "metal_2": metal2,
        "jewellery_type_name": jewelleryTypeName,
        "metal_3": metal3,
        "links_count": linksCount,
        "model_approved_date": modelApprovedDate,
        "part_of_ensembles": partOfEnsembles,
        "business_category_name": businessCategoryName,
        "image_cad_available": imageCadAvailable,
        "style_complexity": styleComplexity,
        "is_variation": isVariation,
        "sub_jewellery_type_code": subJewelleryTypeCode,
        "is_highend": isHighend,
        "msrp": msrp,
        "miracle_plate": miraclePlate,
        "image_sketch": imageSketch,
        "sub_jewellery_type_name": subJewelleryTypeName,
        "is_exclusive": isExclusive,
        "in_house": inHouse,
        "customer_code": customerCode,
        "style_reference_number": styleReferenceNumber,
        "design_created_dt": designCreatedDt,
        "style_number": styleNumber,
        "best_seller": bestSeller,
        "jewellery_group": jewelleryGroup,
        "is_finding_required": isFindingRequired,
        "style_created_date": styleCreatedDate,
        "long_description": longDescription,
        "design_number": designNumber,
        "model_parts_count": modelPartsCount,
        "cancel_hold_status": cancelHoldStatus,
        "is_stone_card_locked": isStoneCardLocked,
        "reference_id": referenceId,
        "applicable_diamond_shape": applicableDiamondShape.map((x) => x.toJson()).toList(),
        "metal": metal,
        "customer_collection": customerCollection,
        "remarks": remarks,
        "default_metal_karatage": defaultMetalKaratage,
        "model_weight3": modelWeight3,
        "customer_group": customerGroup,
        "model_weight2": modelWeight2,
        "market": market,
        "is_model_approved": isModelApproved,
        "kgk_collection_code": kgkCollectionCode,
        "no_of_stones_recut": noOfStonesRecut,
        "stone_card_locked": stoneCardLocked,
        "jewellery_type": jewelleryType,
        "business_category_code": businessCategoryCode,
        "auto_description": autoDescription,
        "customer_collection_ref_suid": customerCollectionRefSuid,
        "customer_alias_name": customerAliasName,
        "sales_price": salesPrice,
        "approximate_model_weight": approximateModelWeight,
        "kgk_collection_name": kgkCollectionName,
        "new_arrival": newArrival,
        "customer_name": customerName,
        "sub_collection": subCollection,
        "metal_lotcode": metalLotcode,
        "metal_colors": metalColors.map((x) => x.toJson()).toList(),
        "product_size": productSize,
        "uom": uom,
        "designer_name": designerName,
        "style_purpose": stylePurpose,
        "setting_type_name": settingTypeName,
        "_id": id,
        "metal_color_1_hex_code": metalColor1HexCode,
        "final_price": finalPrice,
        "discount_price": discountPrice,
        "components": components.map((x) => x.toJson()).toList(),
      };
}

class ApplicableDiamondShape {
  ApplicableDiamondShape({
    required this.shapeName,
    required this.shapeCode,
  });

  final String? shapeName;
  final String? shapeCode;

  ApplicableDiamondShape copyWith({
    String? shapeName,
    String? shapeCode,
  }) {
    return ApplicableDiamondShape(
      shapeName: shapeName ?? this.shapeName,
      shapeCode: shapeCode ?? this.shapeCode,
    );
  }

  factory ApplicableDiamondShape.fromJson(Map<String, dynamic> json) {
    return ApplicableDiamondShape(
      shapeName: json["ShapeName"],
      shapeCode: json["ShapeCode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ShapeName": shapeName,
        "ShapeCode": shapeCode,
      };
}

class MetalColor {
  MetalColor({
    required this.name,
  });

  final dynamic name;

  MetalColor copyWith({
    dynamic name,
  }) {
    return MetalColor(
      name: name ?? this.name,
    );
  }

  factory MetalColor.fromJson(Map<String, dynamic> json) {
    return MetalColor(
      name: json["Name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Name": name,
      };
}
