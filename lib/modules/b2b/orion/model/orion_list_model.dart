class OrionListModel {
  OrionListModel({
    required this.id,
    required this.currency,
    required this.suid,
    required this.lotCode,
    required this.rmDescription,
    required this.size,
    required this.certificateFile,
    required this.image,
    required this.shape,
    required this.ctsOrGms,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.origin,
    required this.location,
    required this.lsp,
    required this.depth,
    required this.table,
    required this.girdle,
    required this.culet,
    required this.lwRatio,
    required this.pavilionAngle,
    required this.pavilionDepth,
    required this.girdlePer,
    required this.lowerHalf,
    required this.certificate,
    required this.importedFrom,
    required this.labs,
    required this.measurements,
    required this.cscCode,
    required this.rappaportPrice,
    required this.discountPercentage,
    required this.totalPrice,
    required this.discountPrice,
    required this.shapeRefSuid,
    required this.color,
    required this.reportedDate,
    required this.numOfDays,
    required this.laserInscription,
    required this.starlength,
    required this.milkey,
    required this.whiteCrown,
    required this.keyToSymbol,
    required this.blackCrown,
    required this.blackTable,
    required this.clarityChar,
    required this.clarityGrading,
    required this.colorGrading,
    required this.comment,
    required this.crownAngle,
    required this.crownHeight,
    required this.crownOpen,
    required this.culetSize,
    required this.girdleCond,
    required this.girdleInclusion,
    required this.hna,
    required this.laserInsReg,
    required this.noBgm,
    required this.pavOpen,
    required this.tableOpen,
    required this.whiteInCenter,
    required this.isOrderPlaced,
    required this.openDnaUrl,
    required this.finalPrice,
    required this.rating,
    required this.reviewCount,
    required this.isFavorite,
    required this.isAuction,
    required this.shapeImage,
    required this.originalPrice,
    required this.originalDiscountPrice,
    required this.priceCts,
    required this.isAddedToCart,
  });

  final String? id;
  final String? currency;
  final String? suid;
  final String? lotCode;
  final String? rmDescription;
  final String? size;
  final String? certificateFile;
  final List<OrionListImage> image;
  final String? shape;
  final double? ctsOrGms;
  final String? clarity;
  final String? cut;
  final String? polish;
  final String? symmetry;
  final String? fluorescence;
  final dynamic origin;
  final String? location;
  final String? lsp;
  final String? depth;
  final String? table;
  final String? girdle;
  final dynamic culet;
  final dynamic lwRatio;
  final int? pavilionAngle;
  final int? pavilionDepth;
  final dynamic girdlePer;
  final dynamic lowerHalf;
  final String? certificate;
  final String? importedFrom;
  final String? labs;
  final String? measurements;
  final String? cscCode;
  final String? rappaportPrice;
  final int? discountPercentage;
  final double? totalPrice;
  final String? discountPrice;
  final int? shapeRefSuid;
  final String? color;
  final DateTime? reportedDate;
  final int? numOfDays;
  final dynamic laserInscription;
  final int? starlength;
  final dynamic milkey;
  final dynamic whiteCrown;
  final dynamic keyToSymbol;
  final dynamic blackCrown;
  final dynamic blackTable;
  final dynamic clarityChar;
  final dynamic clarityGrading;
  final dynamic colorGrading;
  final String? comment;
  final int? crownAngle;
  final int? crownHeight;
  final dynamic crownOpen;
  final dynamic culetSize;
  final String? girdleCond;
  final dynamic girdleInclusion;
  final dynamic hna;
  final dynamic laserInsReg;
  final dynamic noBgm;
  final dynamic pavOpen;
  final dynamic tableOpen;
  final dynamic whiteInCenter;
  final bool? isOrderPlaced;
  final String? openDnaUrl;
  final String? finalPrice;
  final int? rating;
  final int? reviewCount;
  final dynamic isFavorite;
  final bool? isAuction;
  final String? shapeImage;
  final double? originalPrice;
  final double? originalDiscountPrice;
  final String? priceCts;
  final bool? isAddedToCart;

  OrionListModel copyWith({
    String? id,
    String? currency,
    String? suid,
    String? lotCode,
    String? rmDescription,
    String? size,
    String? certificateFile,
    List<OrionListImage>? image,
    String? shape,
    double? ctsOrGms,
    String? clarity,
    String? cut,
    String? polish,
    String? symmetry,
    String? fluorescence,
    dynamic? origin,
    String? location,
    String? lsp,
    String? depth,
    String? table,
    String? girdle,
    dynamic? culet,
    dynamic? lwRatio,
    int? pavilionAngle,
    int? pavilionDepth,
    dynamic? girdlePer,
    dynamic? lowerHalf,
    String? certificate,
    String? importedFrom,
    String? labs,
    String? measurements,
    String? cscCode,
    String? rappaportPrice,
    int? discountPercentage,
    double? totalPrice,
    String? discountPrice,
    int? shapeRefSuid,
    String? color,
    DateTime? reportedDate,
    int? numOfDays,
    dynamic? laserInscription,
    int? starlength,
    dynamic? milkey,
    dynamic? whiteCrown,
    dynamic? keyToSymbol,
    dynamic? blackCrown,
    dynamic? blackTable,
    dynamic? clarityChar,
    dynamic? clarityGrading,
    dynamic? colorGrading,
    String? comment,
    int? crownAngle,
    int? crownHeight,
    dynamic? crownOpen,
    dynamic? culetSize,
    String? girdleCond,
    dynamic? girdleInclusion,
    dynamic? hna,
    dynamic? laserInsReg,
    dynamic? noBgm,
    dynamic? pavOpen,
    dynamic? tableOpen,
    dynamic? whiteInCenter,
    bool? isOrderPlaced,
    String? openDnaUrl,
    String? finalPrice,
    int? rating,
    int? reviewCount,
    dynamic? isFavorite,
    bool? isAuction,
    String? shapeImage,
    double? originalPrice,
    double? originalDiscountPrice,
    String? priceCts,
    bool? isAddedToCart,
  }) {
    return OrionListModel(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      suid: suid ?? this.suid,
      lotCode: lotCode ?? this.lotCode,
      rmDescription: rmDescription ?? this.rmDescription,
      size: size ?? this.size,
      certificateFile: certificateFile ?? this.certificateFile,
      image: image ?? this.image,
      shape: shape ?? this.shape,
      ctsOrGms: ctsOrGms ?? this.ctsOrGms,
      clarity: clarity ?? this.clarity,
      cut: cut ?? this.cut,
      polish: polish ?? this.polish,
      symmetry: symmetry ?? this.symmetry,
      fluorescence: fluorescence ?? this.fluorescence,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      lsp: lsp ?? this.lsp,
      depth: depth ?? this.depth,
      table: table ?? this.table,
      girdle: girdle ?? this.girdle,
      culet: culet ?? this.culet,
      lwRatio: lwRatio ?? this.lwRatio,
      pavilionAngle: pavilionAngle ?? this.pavilionAngle,
      pavilionDepth: pavilionDepth ?? this.pavilionDepth,
      girdlePer: girdlePer ?? this.girdlePer,
      lowerHalf: lowerHalf ?? this.lowerHalf,
      certificate: certificate ?? this.certificate,
      importedFrom: importedFrom ?? this.importedFrom,
      labs: labs ?? this.labs,
      measurements: measurements ?? this.measurements,
      cscCode: cscCode ?? this.cscCode,
      rappaportPrice: rappaportPrice ?? this.rappaportPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      totalPrice: totalPrice ?? this.totalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      shapeRefSuid: shapeRefSuid ?? this.shapeRefSuid,
      color: color ?? this.color,
      reportedDate: reportedDate ?? this.reportedDate,
      numOfDays: numOfDays ?? this.numOfDays,
      laserInscription: laserInscription ?? this.laserInscription,
      starlength: starlength ?? this.starlength,
      milkey: milkey ?? this.milkey,
      whiteCrown: whiteCrown ?? this.whiteCrown,
      keyToSymbol: keyToSymbol ?? this.keyToSymbol,
      blackCrown: blackCrown ?? this.blackCrown,
      blackTable: blackTable ?? this.blackTable,
      clarityChar: clarityChar ?? this.clarityChar,
      clarityGrading: clarityGrading ?? this.clarityGrading,
      colorGrading: colorGrading ?? this.colorGrading,
      comment: comment ?? this.comment,
      crownAngle: crownAngle ?? this.crownAngle,
      crownHeight: crownHeight ?? this.crownHeight,
      crownOpen: crownOpen ?? this.crownOpen,
      culetSize: culetSize ?? this.culetSize,
      girdleCond: girdleCond ?? this.girdleCond,
      girdleInclusion: girdleInclusion ?? this.girdleInclusion,
      hna: hna ?? this.hna,
      laserInsReg: laserInsReg ?? this.laserInsReg,
      noBgm: noBgm ?? this.noBgm,
      pavOpen: pavOpen ?? this.pavOpen,
      tableOpen: tableOpen ?? this.tableOpen,
      whiteInCenter: whiteInCenter ?? this.whiteInCenter,
      isOrderPlaced: isOrderPlaced ?? this.isOrderPlaced,
      openDnaUrl: openDnaUrl ?? this.openDnaUrl,
      finalPrice: finalPrice ?? this.finalPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFavorite: isFavorite ?? this.isFavorite,
      isAuction: isAuction ?? this.isAuction,
      shapeImage: shapeImage ?? this.shapeImage,
      originalPrice: originalPrice ?? this.originalPrice,
      originalDiscountPrice: originalDiscountPrice ?? this.originalDiscountPrice,
      priceCts: priceCts ?? this.priceCts,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
    );
  }

  factory OrionListModel.fromJson(Map<String, dynamic> json) {
    return OrionListModel(
      id: json["id"],
      currency: json["currency"],
      suid: json["suid"],
      lotCode: json["lot_code"],
      rmDescription: json["rm_description"],
      size: json["size"],
      certificateFile: json["certificate_file"],
      image: json["image"] == null ? [] : List<OrionListImage>.from(json["image"]!.map((x) => OrionListImage.fromJson(x))),
      shape: json["shape"],
      ctsOrGms: json["cts_or_gms"].toDouble(),
      clarity: json["clarity"],
      cut: json["cut"],
      polish: json["polish"],
      symmetry: json["symmetry"],
      fluorescence: json["fluorescence"],
      origin: json["origin"],
      location: json["location"],
      lsp: json["lsp"],
      depth: json["depth"],
      table: json["table"],
      girdle: json["girdle"],
      culet: json["culet"],
      lwRatio: json["lw_ratio"],
      pavilionAngle: json["pavilion_angle"],
      pavilionDepth: json["pavilion_depth"],
      girdlePer: json["girdle_per"],
      lowerHalf: json["lower_half"],
      certificate: json["certificate"],
      importedFrom: json["imported_from"],
      labs: json["labs"],
      measurements: json["measurements"],
      cscCode: json["csc_code"],
      rappaportPrice: json["rappaport_price"],
      discountPercentage: json["discount_percentage"],
      totalPrice: json["total_price"].toDouble(),
      discountPrice: json["discount_price"],
      shapeRefSuid: json["shape_ref_suid"],
      color: json["color"],
      reportedDate: DateTime.tryParse(json["reported_date"] ?? ""),
      numOfDays: json["num_of_days"],
      laserInscription: json["laser_inscription"],
      starlength: json["starlength"],
      milkey: json["milkey"],
      whiteCrown: json["white_crown"],
      keyToSymbol: json["key_to_symbol"],
      blackCrown: json["black_crown"],
      blackTable: json["black_table"],
      clarityChar: json["clarity_char"],
      clarityGrading: json["clarity_grading"],
      colorGrading: json["color_grading"],
      comment: json["comment"],
      crownAngle: json["crown_angle"],
      crownHeight: json["crown_height"],
      crownOpen: json["crown_open"],
      culetSize: json["culet_size"],
      girdleCond: json["girdle_cond"],
      girdleInclusion: json["girdle_inclusion"],
      hna: json["hna"],
      laserInsReg: json["laser_ins_reg"],
      noBgm: json["no_bgm"],
      pavOpen: json["pav_open"],
      tableOpen: json["table_open"],
      whiteInCenter: json["white_in_center"],
      isOrderPlaced: json["is_order_placed"],
      openDnaUrl: json["open_dna_url"],
      finalPrice: json["final_price"],
      rating: json["rating"],
      reviewCount: json["review_count"],
      isFavorite: json["is_favorite"],
      isAuction: json["is_auction"],
      shapeImage: json["shape_image"],
      originalPrice: json["original_price"].toDouble(),
      originalDiscountPrice: json["original_discount_price"].toDouble(),
      priceCts: json["price_cts"],
      isAddedToCart: json["isAddedToCart"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "suid": suid,
        "lot_code": lotCode,
        "rm_description": rmDescription,
        "size": size,
        "certificate_file": certificateFile,
        "image": image.map((x) => x?.toJson()).toList(),
        "shape": shape,
        "cts_or_gms": ctsOrGms,
        "clarity": clarity,
        "cut": cut,
        "polish": polish,
        "symmetry": symmetry,
        "fluorescence": fluorescence,
        "origin": origin,
        "location": location,
        "lsp": lsp,
        "depth": depth,
        "table": table,
        "girdle": girdle,
        "culet": culet,
        "lw_ratio": lwRatio,
        "pavilion_angle": pavilionAngle,
        "pavilion_depth": pavilionDepth,
        "girdle_per": girdlePer,
        "lower_half": lowerHalf,
        "certificate": certificate,
        "imported_from": importedFrom,
        "labs": labs,
        "measurements": measurements,
        "csc_code": cscCode,
        "rappaport_price": rappaportPrice,
        "discount_percentage": discountPercentage,
        "total_price": totalPrice,
        "discount_price": discountPrice,
        "shape_ref_suid": shapeRefSuid,
        "color": color,
        "reported_date": reportedDate?.toIso8601String(),
        "num_of_days": numOfDays,
        "laser_inscription": laserInscription,
        "starlength": starlength,
        "milkey": milkey,
        "white_crown": whiteCrown,
        "key_to_symbol": keyToSymbol,
        "black_crown": blackCrown,
        "black_table": blackTable,
        "clarity_char": clarityChar,
        "clarity_grading": clarityGrading,
        "color_grading": colorGrading,
        "comment": comment,
        "crown_angle": crownAngle,
        "crown_height": crownHeight,
        "crown_open": crownOpen,
        "culet_size": culetSize,
        "girdle_cond": girdleCond,
        "girdle_inclusion": girdleInclusion,
        "hna": hna,
        "laser_ins_reg": laserInsReg,
        "no_bgm": noBgm,
        "pav_open": pavOpen,
        "table_open": tableOpen,
        "white_in_center": whiteInCenter,
        "is_order_placed": isOrderPlaced,
        "open_dna_url": openDnaUrl,
        "final_price": finalPrice,
        "rating": rating,
        "review_count": reviewCount,
        "is_favorite": isFavorite,
        "is_auction": isAuction,
        "shape_image": shapeImage,
        "original_price": originalPrice,
        "original_discount_price": originalDiscountPrice,
        "price_cts": priceCts,
        "isAddedToCart": isAddedToCart,
      };
}

class OrionListImage {
  OrionListImage({
    required this.url,
  });

  final String? url;

  OrionListImage copyWith({
    String? url,
  }) {
    return OrionListImage(
      url: url ?? this.url,
    );
  }

  factory OrionListImage.fromJson(Map<String, dynamic> json) {
    return OrionListImage(
      url: json["URL"],
    );
  }

  Map<String, dynamic> toJson() => {
        "URL": url,
      };
}
