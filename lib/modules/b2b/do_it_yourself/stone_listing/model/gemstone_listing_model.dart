import 'package:kgk/kgk.dart';

class GemstoneListingModel {
  GemstoneListingModel({
    required this.data,
    required this.filteredRecords,
    required this.pagination,
    required this.totalRecords,
  });

  final List<GemstoneDatum> data;
  final int? filteredRecords;
  final Pagination? pagination;
  int? totalRecords;

  factory GemstoneListingModel.fromJson(Map<String, dynamic> json) {
    return GemstoneListingModel(
      data: json["data"] == null ? [] : List<GemstoneDatum>.from(json["data"]!.map((x) => GemstoneDatum.fromJson(x))),
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

class GemstoneDatum {
  GemstoneDatum({
    required this.id,
    required this.avgWeight,
    required this.backRate,
    required this.blackCrown,
    required this.blackCrownRefSuid,
    required this.blackCrownSuid,
    required this.blackTable,
    required this.blackTableRefSuid,
    required this.blackTableSuid,
    required this.cscCode,
    required this.cscId,
    required this.cscName,
    required this.certificate,
    required this.certificateCardImage,
    required this.certificateFile,
    required this.certificateImage,
    required this.certificateVideo,
    required this.clarity,
    required this.clarityGrading,
    required this.clarityRefSuid,
    required this.claritySuid,
    required this.clarityChar,
    required this.color,
    required this.colorGrading,
    required this.colorGradingRefSuid,
    required this.colorGradingSuid,
    required this.colorOrigin,
    required this.colorRefSuid,
    required this.colorSuid,
    required this.comment,
    required this.commodityName,
    required this.commodityNameRefSuid,
    required this.commodityNameSuid,
    required this.crownOpen,
    required this.crownOpenRefSuid,
    required this.crownOpenSuid,
    required this.crownAngle,
    required this.crownHeight,
    required this.ctsOrGms,
    required this.culet,
    required this.culetCondRefSuid,
    required this.culetCondSuid,
    required this.culetSizeRefSuid,
    required this.culetSizeSuid,
    required this.culetCond,
    required this.culetRefSuid,
    required this.culetSize,
    required this.culetSuid,
    required this.culetGia,
    required this.currency,
    required this.cut,
    required this.cutRefSuid,
    required this.cutSuid,
    required this.depth,
    required this.diamondAssetUrl,
    required this.discountPercentage,
    required this.dtcBand,
    required this.fancyColor,
    required this.fancyColorRefSuid,
    required this.fancyColorSuid,
    required this.flag,
    required this.fluorescence,
    required this.fluorescenceRefSuid,
    required this.fluorescenceSuid,
    required this.girdle,
    required this.girdleInclusion,
    required this.girdleInclusionRefSuid,
    required this.girdleInclusionSuid,
    required this.girdleSize,
    required this.girdleCond,
    required this.girdlePer,
    required this.girdleRefSuid,
    required this.girdleSuid,
    required this.grade,
    required this.guestUser,
    required this.hna,
    required this.hnaRefSuid,
    required this.hnaSuid,
    required this.image,
    required this.includes,
    required this.inscriptionNumber,
    required this.intensity,
    required this.invTypeDiscount,
    required this.inventoryType,
    required this.keyToSymbol,
    required this.keyToSymbolRefSuid,
    required this.keyToSymbolSuid,
    required this.lwRatio,
    required this.labs,
    required this.laserInscription,
    required this.laserInsReg,
    required this.location,
    required this.lotCodeRefSuid,
    required this.lotCodeSuid,
    required this.lotCode,
    required this.lowerHalf,
    required this.lsp,
    required this.maxSize,
    required this.measurements,
    required this.milky,
    required this.milkyRefSuid,
    required this.milkySuid,
    required this.minSize,
    required this.noBgm,
    required this.openDnaUrl,
    required this.origin,
    required this.pavOpen,
    required this.pavOpenRefSuid,
    required this.pavOpenSuid,
    required this.pavilionAngle,
    required this.pavilionDepth,
    required this.pcs,
    required this.polish,
    required this.price,
    required this.quality,
    required this.rmDescription,
    required this.rappaportDate,
    required this.rappaportPrice,
    required this.rawMaterial,
    required this.rawMaterialRefSuid,
    required this.rawMaterialSuid,
    required this.receivedDateTime,
    required this.refSuid,
    required this.sscWebsiteLotNo,
    required this.shape,
    required this.shapeCode,
    required this.shapeRefSuid,
    required this.shapeSuid,
    required this.size,
    required this.sizeRange,
    required this.importedFrom,
    required this.specialOffer,
    required this.starLength,
    required this.status,
    required this.stone,
    required this.subTypeCode,
    required this.subTypeName,
    required this.subareaCode,
    required this.subareaId,
    required this.subareaName,
    required this.suid,
    required this.supplierCode,
    required this.supplierName,
    required this.symmetry,
    required this.symmetryRefSuid,
    required this.symmetrySuid,
    required this.table,
    required this.tableOpen,
    required this.tableOpenRefSuid,
    required this.tableOpenSuid,
    required this.totalCarat,
    required this.treatment,
    required this.type,
    required this.uom1,
    required this.uom2,
    required this.updatedDateTime,
    required this.video,
    required this.whiteInCenter,
    required this.whiteInCenterRefSuid,
    required this.whiteInCenterSuid,
    required this.whiteInCrown,
    required this.whiteInCrownRefSuid,
    required this.whiteInCrownSuid,
    required this.referenceId,
    required this.datumCreatedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.viewCount,
    required this.discountPrice,
    required this.isFavorite,
    required this.rating,
    required this.reviewCount,
    required this.finalPrice,
    required this.priceCts,
  });

  final String? id;
  final String? avgWeight;
  final int? backRate;
  final dynamic blackCrown;
  final dynamic blackCrownRefSuid;
  final dynamic blackCrownSuid;
  final dynamic blackTable;
  final dynamic blackTableRefSuid;
  final dynamic blackTableSuid;
  final String? cscCode;
  final int? cscId;
  final String? cscName;
  final String? certificate;
  final dynamic certificateCardImage;
  final String? certificateFile;
  final String? certificateImage;
  final dynamic certificateVideo;
  final dynamic clarity;
  final dynamic clarityGrading;
  final dynamic clarityRefSuid;
  final dynamic claritySuid;
  final dynamic clarityChar;
  final String? color;
  final dynamic colorGrading;
  final dynamic colorGradingRefSuid;
  final dynamic colorGradingSuid;
  final dynamic colorOrigin;
  final dynamic colorRefSuid;
  final dynamic colorSuid;
  final dynamic comment;
  final String? commodityName;
  final String? commodityNameRefSuid;
  final String? commodityNameSuid;
  final dynamic crownOpen;
  final dynamic crownOpenRefSuid;
  final dynamic crownOpenSuid;
  final String? crownAngle;
  final String? crownHeight;
  final double? ctsOrGms;
  final dynamic culet;
  final dynamic culetCondRefSuid;
  final dynamic culetCondSuid;
  final dynamic culetSizeRefSuid;
  final dynamic culetSizeSuid;
  final dynamic culetCond;
  final dynamic culetRefSuid;
  final dynamic culetSize;
  final dynamic culetSuid;
  final dynamic culetGia;
  final String? currency;
  final dynamic cut;
  final dynamic cutRefSuid;
  final dynamic cutSuid;
  final dynamic depth;
  final String? diamondAssetUrl;
  final double? discountPercentage;
  final dynamic dtcBand;
  final dynamic fancyColor;
  final dynamic fancyColorRefSuid;
  final dynamic fancyColorSuid;
  final dynamic flag;
  final dynamic fluorescence;
  final dynamic fluorescenceRefSuid;
  final dynamic fluorescenceSuid;
  final dynamic girdle;
  final dynamic girdleInclusion;
  final dynamic girdleInclusionRefSuid;
  final dynamic girdleInclusionSuid;
  final dynamic girdleSize;
  final dynamic girdleCond;
  final dynamic girdlePer;
  final dynamic girdleRefSuid;
  final dynamic girdleSuid;
  final dynamic grade;
  final String? guestUser;
  final dynamic hna;
  final dynamic hnaRefSuid;
  final dynamic hnaSuid;
  final List<GemstoneDetailsImage> image;
  final dynamic includes;
  final dynamic inscriptionNumber;
  final dynamic intensity;
  final dynamic invTypeDiscount;
  final String? inventoryType;
  final dynamic keyToSymbol;
  final dynamic keyToSymbolRefSuid;
  final dynamic keyToSymbolSuid;
  final dynamic lwRatio;
  final String? labs;
  final dynamic laserInscription;
  final dynamic laserInsReg;
  final String? location;
  final String? lotCodeRefSuid;
  final String? lotCodeSuid;
  final String? lotCode;
  final dynamic lowerHalf;
  final String? lsp;
  final String? maxSize;
  final dynamic measurements;
  final dynamic milky;
  final dynamic milkyRefSuid;
  final dynamic milkySuid;
  final String? minSize;
  final dynamic noBgm;
  final String? openDnaUrl;
  final String? origin;
  final dynamic pavOpen;
  final dynamic pavOpenRefSuid;
  final dynamic pavOpenSuid;
  final String? pavilionAngle;
  final String? pavilionDepth;
  final int? pcs;
  final dynamic polish;
  final int? price;
  final String? quality;
  final String? rmDescription;
  final dynamic rappaportDate;
  final String? rappaportPrice;
  final String? rawMaterial;
  final dynamic rawMaterialRefSuid;
  final dynamic rawMaterialSuid;
  final DateTime? receivedDateTime;
  final String? refSuid;
  final dynamic sscWebsiteLotNo;
  final String? shape;
  final String? shapeCode;
  final String? shapeRefSuid;
  final String? shapeSuid;
  final dynamic size;
  final String? sizeRange;
  final String? importedFrom;
  final String? specialOffer;
  final String? starLength;
  final dynamic status;
  final String? stone;
  final String? subTypeCode;
  final String? subTypeName;
  final String? subareaCode;
  final int? subareaId;
  final String? subareaName;
  final String? suid;
  final dynamic supplierCode;
  final dynamic supplierName;
  final dynamic symmetry;
  final dynamic symmetryRefSuid;
  final dynamic symmetrySuid;
  final dynamic table;
  final dynamic tableOpen;
  final dynamic tableOpenRefSuid;
  final dynamic tableOpenSuid;
  final String? totalCarat;
  final dynamic treatment;
  final String? type;
  final String? uom1;
  final String? uom2;
  final DateTime? updatedDateTime;
  final String? video;
  final dynamic whiteInCenter;
  final dynamic whiteInCenterRefSuid;
  final dynamic whiteInCenterSuid;
  final dynamic whiteInCrown;
  final dynamic whiteInCrownRefSuid;
  final dynamic whiteInCrownSuid;
  final String? referenceId;
  final String? datumCreatedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? viewCount;
  final String? discountPrice;
  final dynamic isFavorite;
  final int? rating;
  final int? reviewCount;
  final String? finalPrice;
  final String? priceCts;

  factory GemstoneDatum.fromJson(Map<String, dynamic> json) {
    return GemstoneDatum(
      id: json["id"],
      avgWeight: json["avg_weight"],
      backRate: json["back_rate"],
      blackCrown: json["black_crown"],
      blackCrownRefSuid: json["black_crown_ref_suid"],
      blackCrownSuid: json["black_crown_suid"],
      blackTable: json["black_table"],
      blackTableRefSuid: json["black_table_ref_suid"],
      blackTableSuid: json["black_table_suid"],
      cscCode: json["csc_code"],
      cscId: json["csc_id"],
      cscName: json["csc_name"],
      certificate: json["certificate"],
      certificateCardImage: json["certificate_card_image"],
      certificateFile: json["certificate_file"],
      certificateImage: json["certificate_image"],
      certificateVideo: json["certificate_video"],
      clarity: json["clarity"],
      clarityGrading: json["clarity_grading"],
      clarityRefSuid: json["clarity_ref_suid"],
      claritySuid: json["clarity_suid"],
      clarityChar: json["clarity_char"],
      color: json["color"],
      colorGrading: json["color_grading"],
      colorGradingRefSuid: json["color_grading_ref_suid"],
      colorGradingSuid: json["color_grading_suid"],
      colorOrigin: json["color_origin"],
      colorRefSuid: json["color_ref_suid"],
      colorSuid: json["color_suid"],
      comment: json["comment"],
      commodityName: json["commodity_name"],
      commodityNameRefSuid: json["commodity_name_ref_suid"],
      commodityNameSuid: json["commodity_name_suid"],
      crownOpen: json["crown_open"],
      crownOpenRefSuid: json["crown_open_ref_suid"],
      crownOpenSuid: json["crown_open_suid"],
      crownAngle: json["crown_angle"],
      crownHeight: json["crown_height"],
      ctsOrGms: double.tryParse(json["cts_or_gms"].toString()),
      culet: json["culet"],
      culetCondRefSuid: json["culet_cond_ref_suid"],
      culetCondSuid: json["culet_cond_suid"],
      culetSizeRefSuid: json["culet_size_ref_suid"],
      culetSizeSuid: json["culet_size_suid"],
      culetCond: json["culet_cond"],
      culetRefSuid: json["culet_ref_suid"],
      culetSize: json["culet_size"],
      culetSuid: json["culet_suid"],
      culetGia: json["culet_gia"],
      currency: json["currency"],
      cut: json["cut"],
      cutRefSuid: json["cut_ref_suid"],
      cutSuid: json["cut_suid"],
      depth: json["depth"],
      diamondAssetUrl: json["diamond_asset_url"],
      discountPercentage: json["discount_percentage"] != null ? double.tryParse(json["discount_percentage"].toString()) : 0.0,
      dtcBand: json["dtc_band"],
      fancyColor: json["fancy_color"],
      fancyColorRefSuid: json["fancy_color_ref_suid"],
      fancyColorSuid: json["fancy_color_suid"],
      flag: json["flag"],
      fluorescence: json["fluorescence"],
      fluorescenceRefSuid: json["fluorescence_ref_suid"],
      fluorescenceSuid: json["fluorescence_suid"],
      girdle: json["girdle"],
      girdleInclusion: json["girdle_inclusion"],
      girdleInclusionRefSuid: json["girdle_inclusion_ref_suid"],
      girdleInclusionSuid: json["girdle_inclusion_suid"],
      girdleSize: json["girdle_size"],
      girdleCond: json["girdle_cond"],
      girdlePer: json["girdle_per"],
      girdleRefSuid: json["girdle_ref_suid"],
      girdleSuid: json["girdle_suid"],
      grade: json["grade"],
      guestUser: json["guest_user"],
      hna: json["hna"],
      hnaRefSuid: json["hna_ref_suid"],
      hnaSuid: json["hna_suid"],
      image: json["image"] == null ? [] : List<GemstoneDetailsImage>.from(json["image"]!.map((x) => GemstoneDetailsImage.fromJson(x))),
      includes: json["includes"],
      inscriptionNumber: json["inscription_number"],
      intensity: json["intensity"],
      invTypeDiscount: json["inv_type_discount"],
      inventoryType: json["inventory_type"],
      keyToSymbol: json["key_to_symbol"],
      keyToSymbolRefSuid: json["key_to_symbol_ref_suid"],
      keyToSymbolSuid: json["key_to_symbol_suid"],
      lwRatio: json["lw_ratio"],
      labs: json["labs"],
      laserInscription: json["laser_inscription"],
      laserInsReg: json["laser_ins_reg"],
      location: json["location"],
      lotCodeRefSuid: json["lot_code_ref_suid"],
      lotCodeSuid: json["lot_code_suid"],
      lotCode: json["lot_code"],
      lowerHalf: json["lower_half"],
      lsp: json["lsp"],
      maxSize: json["max_size"],
      measurements: json["measurements"],
      milky: json["milky"],
      milkyRefSuid: json["milky_ref_suid"],
      milkySuid: json["milky_suid"],
      minSize: json["min_size"],
      noBgm: json["no_bgm"],
      openDnaUrl: json["open_dna_url"],
      origin: json["origin"],
      pavOpen: json["pav_open"],
      pavOpenRefSuid: json["pav_open_ref_suid"],
      pavOpenSuid: json["pav_open_suid"],
      pavilionAngle: json["pavilion_angle"],
      pavilionDepth: json["pavilion_depth"],
      pcs: json["pcs"],
      polish: json["polish"],
      price: json["price"],
      quality: json["quality"],
      rmDescription: json["rm_description"],
      rappaportDate: json["rappaport_date"],
      rappaportPrice: json["rappaport_price"],
      rawMaterial: json["raw_material"],
      rawMaterialRefSuid: json["raw_material_ref_suid"],
      rawMaterialSuid: json["raw_material_suid"],
      receivedDateTime: DateTime.tryParse(json["received_date_time"] ?? ""),
      refSuid: json["ref_suid"],
      sscWebsiteLotNo: json["ssc_website_lot_no"],
      shape: json["shape"],
      shapeCode: json["shape_code"],
      shapeRefSuid: json["shape_ref_suid"],
      shapeSuid: json["shape_suid"],
      size: json["size"],
      sizeRange: json["size_range"],
      importedFrom: json["imported_from"],
      specialOffer: json["special_offer"],
      starLength: json["star_length"],
      status: json["status"],
      stone: json["stone"],
      subTypeCode: json["sub_type_code"],
      subTypeName: json["sub_type_name"],
      subareaCode: json["subarea_code"],
      subareaId: json["subarea_id"],
      subareaName: json["subarea_name"],
      suid: json["suid"],
      supplierCode: json["supplier_code"],
      supplierName: json["supplier_name"],
      symmetry: json["symmetry"],
      symmetryRefSuid: json["symmetry_ref_suid"],
      symmetrySuid: json["symmetry_suid"],
      table: json["table"],
      tableOpen: json["table_open"],
      tableOpenRefSuid: json["table_open_ref_suid"],
      tableOpenSuid: json["table_open_suid"],
      totalCarat: json["total_carat"],
      treatment: json["treatment"],
      type: json["type"],
      uom1: json["uom1"],
      uom2: json["uom2"],
      updatedDateTime: DateTime.tryParse(json["updated_date_time"] ?? ""),
      video: json["video"],
      whiteInCenter: json["white_in_center"],
      whiteInCenterRefSuid: json["white_in_center_ref_suid"],
      whiteInCenterSuid: json["white_in_center_suid"],
      whiteInCrown: json["white_in_crown"],
      whiteInCrownRefSuid: json["white_in_crown_ref_suid"],
      whiteInCrownSuid: json["white_in_crown_suid"],
      referenceId: json["reference_id"],
      datumCreatedAt: json["created_at"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      viewCount: json["view_count"],
      discountPrice: json["discount_price"],
      isFavorite: json["is_favorite"],
      rating: json["rating"],
      reviewCount: json["review_count"],
      finalPrice: json["final_price"],
      priceCts: json["price_cts"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "avg_weight": avgWeight,
        "back_rate": backRate,
        "black_crown": blackCrown,
        "black_crown_ref_suid": blackCrownRefSuid,
        "black_crown_suid": blackCrownSuid,
        "black_table": blackTable,
        "black_table_ref_suid": blackTableRefSuid,
        "black_table_suid": blackTableSuid,
        "csc_code": cscCode,
        "csc_id": cscId,
        "csc_name": cscName,
        "certificate": certificate,
        "certificate_card_image": certificateCardImage,
        "certificate_file": certificateFile,
        "certificate_image": certificateImage,
        "certificate_video": certificateVideo,
        "clarity": clarity,
        "clarity_grading": clarityGrading,
        "clarity_ref_suid": clarityRefSuid,
        "clarity_suid": claritySuid,
        "clarity_char": clarityChar,
        "color": color,
        "color_grading": colorGrading,
        "color_grading_ref_suid": colorGradingRefSuid,
        "color_grading_suid": colorGradingSuid,
        "color_origin": colorOrigin,
        "color_ref_suid": colorRefSuid,
        "color_suid": colorSuid,
        "comment": comment,
        "commodity_name": commodityName,
        "commodity_name_ref_suid": commodityNameRefSuid,
        "commodity_name_suid": commodityNameSuid,
        "crown_open": crownOpen,
        "crown_open_ref_suid": crownOpenRefSuid,
        "crown_open_suid": crownOpenSuid,
        "crown_angle": crownAngle,
        "crown_height": crownHeight,
        "cts_or_gms": ctsOrGms,
        "culet": culet,
        "culet_cond_ref_suid": culetCondRefSuid,
        "culet_cond_suid": culetCondSuid,
        "culet_size_ref_suid": culetSizeRefSuid,
        "culet_size_suid": culetSizeSuid,
        "culet_cond": culetCond,
        "culet_ref_suid": culetRefSuid,
        "culet_size": culetSize,
        "culet_suid": culetSuid,
        "culet_gia": culetGia,
        "currency": currency,
        "cut": cut,
        "cut_ref_suid": cutRefSuid,
        "cut_suid": cutSuid,
        "depth": depth,
        "diamond_asset_url": diamondAssetUrl,
        "discount_percentage": discountPercentage,
        "dtc_band": dtcBand,
        "fancy_color": fancyColor,
        "fancy_color_ref_suid": fancyColorRefSuid,
        "fancy_color_suid": fancyColorSuid,
        "flag": flag,
        "fluorescence": fluorescence,
        "fluorescence_ref_suid": fluorescenceRefSuid,
        "fluorescence_suid": fluorescenceSuid,
        "girdle": girdle,
        "girdle_inclusion": girdleInclusion,
        "girdle_inclusion_ref_suid": girdleInclusionRefSuid,
        "girdle_inclusion_suid": girdleInclusionSuid,
        "girdle_size": girdleSize,
        "girdle_cond": girdleCond,
        "girdle_per": girdlePer,
        "girdle_ref_suid": girdleRefSuid,
        "girdle_suid": girdleSuid,
        "grade": grade,
        "guest_user": guestUser,
        "hna": hna,
        "hna_ref_suid": hnaRefSuid,
        "hna_suid": hnaSuid,
        "image": image.map((x) => x.toJson()).toList(),
        "includes": includes,
        "inscription_number": inscriptionNumber,
        "intensity": intensity,
        "inv_type_discount": invTypeDiscount,
        "inventory_type": inventoryType,
        "key_to_symbol": keyToSymbol,
        "key_to_symbol_ref_suid": keyToSymbolRefSuid,
        "key_to_symbol_suid": keyToSymbolSuid,
        "lw_ratio": lwRatio,
        "labs": labs,
        "laser_inscription": laserInscription,
        "laser_ins_reg": laserInsReg,
        "location": location,
        "lot_code_ref_suid": lotCodeRefSuid,
        "lot_code_suid": lotCodeSuid,
        "lot_code": lotCode,
        "lower_half": lowerHalf,
        "lsp": lsp,
        "max_size": maxSize,
        "measurements": measurements,
        "milky": milky,
        "milky_ref_suid": milkyRefSuid,
        "milky_suid": milkySuid,
        "min_size": minSize,
        "no_bgm": noBgm,
        "open_dna_url": openDnaUrl,
        "origin": origin,
        "pav_open": pavOpen,
        "pav_open_ref_suid": pavOpenRefSuid,
        "pav_open_suid": pavOpenSuid,
        "pavilion_angle": pavilionAngle,
        "pavilion_depth": pavilionDepth,
        "pcs": pcs,
        "polish": polish,
        "price": price,
        "quality": quality,
        "rm_description": rmDescription,
        "rappaport_date": rappaportDate,
        "rappaport_price": rappaportPrice,
        "raw_material": rawMaterial,
        "raw_material_ref_suid": rawMaterialRefSuid,
        "raw_material_suid": rawMaterialSuid,
        "received_date_time": receivedDateTime?.toIso8601String(),
        "ref_suid": refSuid,
        "ssc_website_lot_no": sscWebsiteLotNo,
        "shape": shape,
        "shape_code": shapeCode,
        "shape_ref_suid": shapeRefSuid,
        "shape_suid": shapeSuid,
        "size": size,
        "size_range": sizeRange,
        "imported_from": importedFrom,
        "special_offer": specialOffer,
        "star_length": starLength,
        "status": status,
        "stone": stone,
        "sub_type_code": subTypeCode,
        "sub_type_name": subTypeName,
        "subarea_code": subareaCode,
        "subarea_id": subareaId,
        "subarea_name": subareaName,
        "suid": suid,
        "supplier_code": supplierCode,
        "supplier_name": supplierName,
        "symmetry": symmetry,
        "symmetry_ref_suid": symmetryRefSuid,
        "symmetry_suid": symmetrySuid,
        "table": table,
        "table_open": tableOpen,
        "table_open_ref_suid": tableOpenRefSuid,
        "table_open_suid": tableOpenSuid,
        "total_carat": totalCarat,
        "treatment": treatment,
        "type": type,
        "uom1": uom1,
        "uom2": uom2,
        "updated_date_time": updatedDateTime?.toIso8601String(),
        "video": video,
        "white_in_center": whiteInCenter,
        "white_in_center_ref_suid": whiteInCenterRefSuid,
        "white_in_center_suid": whiteInCenterSuid,
        "white_in_crown": whiteInCrown,
        "white_in_crown_ref_suid": whiteInCrownRefSuid,
        "white_in_crown_suid": whiteInCrownSuid,
        "reference_id": referenceId,
        "created_at": datumCreatedAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "view_count": viewCount,
        "discount_price": discountPrice,
        "is_favorite": isFavorite,
        "rating": rating,
        "review_count": reviewCount,
        "final_price": finalPrice,
        "price_cts": priceCts,
      };

  @override
  String toString() {
    return "$id, $avgWeight, $backRate, $blackCrown, $blackCrownRefSuid, $blackCrownSuid, $blackTable, $blackTableRefSuid, $blackTableSuid, $cscCode, $cscId, $cscName, $certificate, $certificateCardImage, $certificateFile, $certificateImage, $certificateVideo, $clarity, $clarityGrading, $clarityRefSuid, $claritySuid, $clarityChar, $color, $colorGrading, $colorGradingRefSuid, $colorGradingSuid, $colorOrigin, $colorRefSuid, $colorSuid, $comment, $commodityName, $commodityNameRefSuid, $commodityNameSuid, $crownOpen, $crownOpenRefSuid, $crownOpenSuid, $crownAngle, $crownHeight, $ctsOrGms, $culet, $culetCondRefSuid, $culetCondSuid, $culetSizeRefSuid, $culetSizeSuid, $culetCond, $culetRefSuid, $culetSize, $culetSuid, $culetGia, $currency, $cut, $cutRefSuid, $cutSuid, $depth, $diamondAssetUrl, $discountPercentage, $dtcBand, $fancyColor, $fancyColorRefSuid, $fancyColorSuid, $flag, $fluorescence, $fluorescenceRefSuid, $fluorescenceSuid, $girdle, $girdleInclusion, $girdleInclusionRefSuid, $girdleInclusionSuid, $girdleSize, $girdleCond, $girdlePer, $girdleRefSuid, $girdleSuid, $grade, $guestUser, $hna, $hnaRefSuid, $hnaSuid, $image, $includes, $inscriptionNumber, $intensity, $invTypeDiscount, $inventoryType, $keyToSymbol, $keyToSymbolRefSuid, $keyToSymbolSuid, $lwRatio, $labs, $laserInscription, $laserInsReg, $location, $lotCodeRefSuid, $lotCodeSuid, $lotCode, $lowerHalf, $lsp, $maxSize, $measurements, $milky, $milkyRefSuid, $milkySuid, $minSize, $noBgm, $openDnaUrl, $origin, $pavOpen, $pavOpenRefSuid, $pavOpenSuid, $pavilionAngle, $pavilionDepth, $pcs, $polish, $price, $quality, $rmDescription, $rappaportDate, $rappaportPrice, $rawMaterial, $rawMaterialRefSuid, $rawMaterialSuid, $receivedDateTime, $refSuid, $sscWebsiteLotNo, $shape, $shapeCode, $shapeRefSuid, $shapeSuid, $size, $sizeRange, $importedFrom, $specialOffer, $starLength, $status, $stone, $subTypeCode, $subTypeName, $subareaCode, $subareaId, $subareaName, $suid, $supplierCode, $supplierName, $symmetry, $symmetryRefSuid, $symmetrySuid, $table, $tableOpen, $tableOpenRefSuid, $tableOpenSuid, $totalCarat, $treatment, $type, $uom1, $uom2, $updatedDateTime, $video, $whiteInCenter, $whiteInCenterRefSuid, $whiteInCenterSuid, $whiteInCrown, $whiteInCrownRefSuid, $whiteInCrownSuid, $referenceId, $datumCreatedAt, $createdAt, $updatedAt, $viewCount, $discountPrice, $isFavorite, $rating, $reviewCount, $finalPrice, $priceCts, ";
  }
}

class GemstoneDetailsImage {
  GemstoneDetailsImage({
    required this.url,
  });

  final String? url;

  factory GemstoneDetailsImage.fromJson(Map<String, dynamic> json) {
    return GemstoneDetailsImage(
      url: json["URL"],
    );
  }

  Map<String, dynamic> toJson() => {
        "URL": url,
      };

  @override
  String toString() {
    return "$url, ";
  }
}
