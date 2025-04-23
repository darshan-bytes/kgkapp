import 'package:kgk/kgk.dart';

class CompareProductDetails {
  CompareProductDetails({
    required this.blackCrown,
    required this.blackTable,
    required this.clarityGrading,
    required this.clarityChar,
    required this.colorGrading,
    required this.comment,
    required this.crownOpen,
    required this.crownAngle,
    required this.crownHeight,
    required this.culetSize,
    required this.girdleInclusion,
    required this.girdleCond,
    required this.hna,
    required this.laserInsReg,
    required this.milky,
    required this.noBgm,
    required this.pavOpen,
    required this.tableOpen,
    required this.whiteInCenter,
    required this.whiteInCrown,
    required this.updatedAt,
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
    required this.starLength,
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
    required this.finalPrice,
    required this.originalPrice,
    required this.originalDiscountPrice,
    required this.priceCts,
    required this.isAddedToCart,
  });

  final String? blackCrown;
  final String? blackTable;
  final String? clarityGrading;
  final String? clarityChar;
  final String? colorGrading;
  final String? comment;
  final String? crownOpen;
  final int? crownAngle;
  final int? crownHeight;
  final dynamic culetSize;
  final String? girdleInclusion;
  final dynamic girdleCond;
  final String? hna;
  final String? laserInsReg;
  final dynamic milky;
  final String? noBgm;
  final String? pavOpen;
  final String? tableOpen;
  final String? whiteInCenter;
  final String? whiteInCrown;
  final String? updatedAt;
  final String? id;
  final String? currency;
  final String? suid;
  final String? lotCode;
  final String? rmDescription;
  final String? size;
  final String? certificateFile;
  final List<DiamondImage> image;
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
  final String? culet;
  final dynamic lwRatio;
  final int? pavilionAngle;
  final int? starLength;
  final int? pavilionDepth;
  final String? girdlePer;
  final String? lowerHalf;
  final String? certificate;
  final String? importedFrom;
  final String? labs;
  final String? measurements;
  final String? cscCode;
  final String? rappaportPrice;
  final double? discountPercentage;
  final double? totalPrice;
  final double? discountPrice;
  final int? shapeRefSuid;
  final String? color;
  final double? finalPrice;
  final double? originalPrice;
  final double? originalDiscountPrice;
  final String? priceCts;
  final bool? isAddedToCart;

  CompareProductDetails copyWith({
    String? blackCrown,
    String? blackTable,
    String? clarityGrading,
    String? clarityChar,
    String? colorGrading,
    String? comment,
    String? crownOpen,
    int? crownAngle,
    int? crownHeight,
    dynamic culetSize,
    String? girdleInclusion,
    dynamic girdleCond,
    String? hna,
    String? laserInsReg,
    dynamic milky,
    String? noBgm,
    String? pavOpen,
    String? tableOpen,
    String? whiteInCenter,
    String? whiteInCrown,
    String? updatedAt,
    String? id,
    String? currency,
    String? suid,
    String? lotCode,
    String? rmDescription,
    String? size,
    String? certificateFile,
    List<DiamondImage>? image,
    String? shape,
    double? ctsOrGms,
    String? clarity,
    String? cut,
    String? polish,
    String? symmetry,
    String? fluorescence,
    dynamic origin,
    String? location,
    String? lsp,
    String? depth,
    String? table,
    String? girdle,
    String? culet,
    dynamic lwRatio,
    int? pavilionAngle,
    int? starLength,
    int? pavilionDepth,
    String? girdlePer,
    String? lowerHalf,
    String? certificate,
    String? importedFrom,
    String? labs,
    String? measurements,
    String? cscCode,
    String? rappaportPrice,
    double? discountPercentage,
    double? totalPrice,
    double? discountPrice,
    int? shapeRefSuid,
    String? color,
    double? finalPrice,
    double? originalPrice,
    double? originalDiscountPrice,
    String? priceCts,
    bool? isAddedToCart,
  }) {
    return CompareProductDetails(
      blackCrown: blackCrown ?? this.blackCrown,
      blackTable: blackTable ?? this.blackTable,
      clarityGrading: clarityGrading ?? this.clarityGrading,
      clarityChar: clarityChar ?? this.clarityChar,
      colorGrading: colorGrading ?? this.colorGrading,
      comment: comment ?? this.comment,
      crownOpen: crownOpen ?? this.crownOpen,
      crownAngle: crownAngle ?? this.crownAngle,
      crownHeight: crownHeight ?? this.crownHeight,
      culetSize: culetSize ?? this.culetSize,
      girdleInclusion: girdleInclusion ?? this.girdleInclusion,
      girdleCond: girdleCond ?? this.girdleCond,
      hna: hna ?? this.hna,
      laserInsReg: laserInsReg ?? this.laserInsReg,
      milky: milky ?? this.milky,
      noBgm: noBgm ?? this.noBgm,
      pavOpen: pavOpen ?? this.pavOpen,
      tableOpen: tableOpen ?? this.tableOpen,
      whiteInCenter: whiteInCenter ?? this.whiteInCenter,
      whiteInCrown: whiteInCrown ?? this.whiteInCrown,
      updatedAt: updatedAt ?? this.updatedAt,
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
      starLength: starLength ?? this.starLength,
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
      finalPrice: finalPrice ?? this.finalPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      originalDiscountPrice: originalDiscountPrice ?? this.originalDiscountPrice,
      priceCts: priceCts ?? this.priceCts,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
    );
  }

  factory CompareProductDetails.fromJson(Map<String, dynamic> json) {
    return CompareProductDetails(
      blackCrown: json["black_crown"],
      blackTable: json["black_table"],
      clarityGrading: json["clarity_grading"],
      clarityChar: json["clarity_char"],
      colorGrading: json["color_grading"],
      comment: json["comment"],
      crownOpen: json["crown_open"],
      crownAngle: json["crown_angle"],
      crownHeight: json["crown_height"],
      culetSize: json["culet_size"],
      girdleInclusion: json["girdle_inclusion"],
      girdleCond: json["girdle_cond"],
      hna: json["hna"],
      laserInsReg: json["laser_ins_reg"],
      milky: json["milky"],
      noBgm: json["no_bgm"],
      pavOpen: json["pav_open"],
      tableOpen: json["table_open"],
      whiteInCenter: json["white_in_center"],
      whiteInCrown: json["white_in_crown"],
      updatedAt: json["updated_at"],
      id: json["id"],
      currency: json["currency"],
      suid: json["suid"],
      lotCode: json["lot_code"],
      rmDescription: json["rm_description"],
      size: json["size"],
      certificateFile: json["certificate_file"],
      image: json["image"] == null ? [] : List<DiamondImage>.from(json["image"]!.map((x) => DiamondImage.fromJson(x))),
      shape: json["shape"],
      ctsOrGms: json["cts_or_gms"],
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
      starLength: json["star_length"],
      pavilionDepth: json["pavilion_depth"],
      girdlePer: json["girdle_per"],
      lowerHalf: json["lower_half"],
      certificate: json["certificate"],
      importedFrom: json["imported_from"],
      labs: json["labs"],
      measurements: json["measurements"],
      cscCode: json["csc_code"],
      rappaportPrice: json["rappaport_price"],
      discountPercentage: json["discount_percentage"]?.toDouble(),
      totalPrice: json["total_price"],
      discountPrice: json["discount_price"]?.toDouble(),
      shapeRefSuid: json["shape_ref_suid"],
      color: json["color"],
      finalPrice: json["final_price"],
      originalPrice: json["original_price"],
      originalDiscountPrice: json["original_discount_price"],
      priceCts: json["price_cts"],
      isAddedToCart: json["isAddedToCart"],
    );
  }

  Map<String, dynamic> toJson() => {
    "black_crown": blackCrown,
    "black_table": blackTable,
    "clarity_grading": clarityGrading,
    "clarity_char": clarityChar,
    "color_grading": colorGrading,
    "comment": comment,
    "crown_open": crownOpen,
    "crown_angle": crownAngle,
    "crown_height": crownHeight,
    "culet_size": culetSize,
    "girdle_inclusion": girdleInclusion,
    "girdle_cond": girdleCond,
    "hna": hna,
    "laser_ins_reg": laserInsReg,
    "milky": milky,
    "no_bgm": noBgm,
    "pav_open": pavOpen,
    "table_open": tableOpen,
    "white_in_center": whiteInCenter,
    "white_in_crown": whiteInCrown,
    "updated_at": updatedAt,
    "id": id,
    "currency": currency,
    "suid": suid,
    "lot_code": lotCode,
    "rm_description": rmDescription,
    "size": size,
    "certificate_file": certificateFile,
    "image": image.map((x) => x.toJson()).toList(),
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
    "star_length": starLength,
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
    "final_price": finalPrice,
    "original_price": originalPrice,
    "original_discount_price": originalDiscountPrice,
    "price_cts": priceCts,
    "isAddedToCart": isAddedToCart,
  };
}
