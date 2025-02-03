import 'package:kgk/kgk.dart';

class BagListDataModel {
  BagListDataModel({
    required this.result,
    required this.summary,
    required this.totalRecords,
    required this.page,
    required this.limit,
    required this.bagId,
    required this.isExpired,
  });

  final List<MyBagResult> result;
  final BagSummary? summary;
  final int? totalRecords;
  final int? page;
  final int? limit;
  final String? bagId;
  final bool? isExpired;

  BagListDataModel copyWith({
    List<MyBagResult>? result,
    BagSummary? summary,
    int? totalRecords,
    int? page,
    int? limit,
    String? bagId,
    bool? isExpired,
  }) {
    return BagListDataModel(
      result: result ?? this.result,
      summary: summary ?? this.summary,
      totalRecords: totalRecords ?? this.totalRecords,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      bagId: bagId ?? this.bagId,
      isExpired: isExpired ?? this.isExpired,
    );
  }

  factory BagListDataModel.fromJson(Map<String, dynamic> json) {
    return BagListDataModel(
      result: json["result"] == null ? [] : List<MyBagResult>.from(json["result"]!.map((x) => MyBagResult.fromJson(x))),
      summary: json["summary"] == null ? null : BagSummary.fromJson(json["summary"]),
      totalRecords: json["totalRecords"],
      page: json["page"]?.toString().toInt,
      limit: json["limit"]?.toString().toInt,
      bagId: json["bag_id"],
      isExpired: json["is_expired"],
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
        "summary": summary?.toJson(),
        "totalRecords": totalRecords,
        "page": page,
        "limit": limit,
        "bag_id": bagId,
        "is_expired": isExpired,
      };

  @override
  String toString() {
    return 'BagListDataModel{result: $result, summary: $summary, totalRecords: $totalRecords, page: $page, limit: $limit, bagId: $bagId, isExpired: $isExpired}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BagListDataModel &&
          runtimeType == other.runtimeType &&
          result == other.result &&
          summary == other.summary &&
          totalRecords == other.totalRecords &&
          page == other.page &&
          limit == other.limit &&
          bagId == other.bagId &&
          isExpired == other.isExpired;

  @override
  int get hashCode =>
      result.hashCode ^ summary.hashCode ^ totalRecords.hashCode ^ page.hashCode ^ limit.hashCode ^ bagId.hashCode ^ isExpired.hashCode;
}

class MyBagResult {
  MyBagResult({
    required this.suid,
    required this.quantity,
    required this.totalPrice,
    required this.rate,
    required this.jewelleryName,
    required this.productId,
    required this.image,
    required this.commodity,
    required this.discountPrice,
    required this.discountPercentage,
    required this.lotCode,
    required this.shape,
    required this.labs,
    required this.cut,
    required this.color,
    required this.clarity,
    required this.ctsOrGms,
    required this.polish,
    required this.symmetry,
    required this.depth,
    required this.table,
    required this.measurements,
    required this.rappaportPrice,
    required this.location,
    required this.status,
    required this.finalPrice,
    required this.shapeImage,
    required this.certificateFile,
    required this.openDnaUrl,
    required this.fluorescence,
    required this.stockQty,
    required this.yourRate,
    required this.yourAmount,
    required this.yourDiscount,
    required this.originalYourRate,
    required this.originalYourAmount,
    required this.originalTotalPrice,
    required this.originalFinalPrice,
    required this.cscCode,
    required this.certificate,
    required this.crt,
    required this.gms,
  });

  final String? suid;
  final int? quantity;
  final String? totalPrice;
  final String? rate;
  final String? jewelleryName;
  final String? productId;
  final String? image;
  final String? commodity;
  final double? discountPrice;
  final double? discountPercentage;
  final String? lotCode;
  final String? shape;
  final String? labs;
  final String? cut;
  final String? color;
  final String? clarity;
  final double? ctsOrGms;
  final String? polish;
  final String? symmetry;
  final String? depth;
  final String? table;
  final String? measurements;
  final String? rappaportPrice;
  final String? location;
  final String? status;
  final String? finalPrice;
  final String? shapeImage;
  final String? certificateFile;
  final String? openDnaUrl;
  final String? fluorescence;
  final int? stockQty;
  final double? yourDiscount;
  final String? yourRate;
  final String? yourAmount;
  final double? originalYourRate;
  final double? originalYourAmount;
  final double? originalTotalPrice;
  final String? cscCode;
  final double? originalFinalPrice;
  final String? certificate;
  final String? crt;
  final String? gms;

  MyBagResult copyWith({
    String? suid,
    int? quantity,
    String? totalPrice,
    String? rate,
    String? jewelleryName,
    String? productId,
    String? image,
    String? commodity,
    double? discountPrice,
    double? discountPercentage,
    String? lotCode,
    String? shape,
    String? labs,
    String? cut,
    String? color,
    String? clarity,
    double? ctsOrGms,
    String? polish,
    String? symmetry,
    String? depth,
    String? table,
    String? measurements,
    String? rappaportPrice,
    String? location,
    String? status,
    String? finalPrice,
    String? shapeImage,
    String? certificateFile,
    String? openDnaUrl,
    String? fluorescence,
    int? stockQty,
    double? yourDiscount,
    String? yourRate,
    String? yourAmount,
    double? originalYourRate,
    double? originalYourAmount,
    double? originalTotalPrice,
    String? cscCode,
    double? originalFinalPrice,
    String? certificate,
    String? crt,
    String? gms,
  }) {
    return MyBagResult(
      suid: suid ?? this.suid,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      rate: rate ?? this.rate,
      jewelleryName: jewelleryName ?? this.jewelleryName,
      productId: productId ?? this.productId,
      image: image ?? this.image,
      commodity: commodity ?? this.commodity,
      discountPrice: discountPrice ?? this.discountPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      lotCode: lotCode ?? this.lotCode,
      shape: shape ?? this.shape,
      labs: labs ?? this.labs,
      cut: cut ?? this.cut,
      color: color ?? this.color,
      clarity: clarity ?? this.clarity,
      ctsOrGms: ctsOrGms ?? this.ctsOrGms,
      polish: polish ?? this.polish,
      symmetry: symmetry ?? this.symmetry,
      depth: depth ?? this.depth,
      table: table ?? this.table,
      measurements: measurements ?? this.measurements,
      rappaportPrice: rappaportPrice ?? this.rappaportPrice,
      location: location ?? this.location,
      status: status ?? this.status,
      finalPrice: finalPrice ?? this.finalPrice,
      shapeImage: shapeImage ?? this.shapeImage,
      certificateFile: certificateFile ?? this.certificateFile,
      openDnaUrl: openDnaUrl ?? this.openDnaUrl,
      fluorescence: fluorescence ?? this.fluorescence,
      stockQty: stockQty ?? this.stockQty,
      yourAmount: yourAmount ?? this.yourAmount,
      yourDiscount: yourDiscount ?? this.yourDiscount,
      yourRate: yourRate ?? this.yourRate,
      originalYourRate: originalYourRate ?? this.originalYourRate,
      originalYourAmount: originalYourAmount ?? this.originalYourAmount,
      originalTotalPrice: originalTotalPrice ?? this.originalTotalPrice,
      certificate: certificate ?? this.certificate,
      cscCode: cscCode ?? this.cscCode,
      originalFinalPrice: originalFinalPrice ?? this.originalFinalPrice,
      crt: crt ?? this.crt,
      gms: gms ?? this.gms,
    );
  }

  factory MyBagResult.fromJson(Map<String, dynamic> json) {
    return MyBagResult(
      suid: json["suid"],
      quantity: json["quantity"],
      totalPrice: json["totalPrice"]?.toString(),
      rate: json["rate"]?.toString(),
      jewelleryName: json["jewellery_name"],
      productId: json["productId"],
      image: json["image"],
      commodity: json["commodity"],
      discountPrice: json["discount_price"]?.toString().toDouble,
      discountPercentage: json["discount_percentage"]?.toString().toDouble,
      lotCode: json["lot_code"],
      shape: json["shape"],
      labs: json["labs"],
      cut: json["cut"],
      color: json["color"],
      clarity: json["clarity"],
      ctsOrGms: json["cts_or_gms"]?.toString().toDouble,
      polish: json["polish"],
      symmetry: json["symmetry"],
      depth: json["depth"],
      table: json["table"],
      measurements: json["measurements"],
      rappaportPrice: json["rappaport_price"],
      location: json["location"],
      status: json["status"],
      finalPrice: json["final_price"]?.toString(),
      fluorescence: json["fluorescence"],
      certificateFile: json["certificate_file"],
      openDnaUrl: json["open_dna_url"],
      shapeImage: json["shape_image"],
      stockQty: json["stock_qty"],
      yourRate: json["your_rate"],
      yourAmount: json["your_amount"],
      yourDiscount: json["your_discount"]?.toString().toDouble,
      originalYourRate: json["original_your_rate"]?.toString().toDouble,
      originalYourAmount: json["original_your_amount"]?.toString().toDouble,
      originalTotalPrice: json["original_totalPrice"]?.toString().toDouble,
      originalFinalPrice: json["original_final_price"]?.toString().toDouble,
      cscCode: json["csc_code"],
      certificate: json["certificate"],
      crt: json["crt"]?.toString(),
      gms: json["gms"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "suid": suid,
        "quantity": quantity,
        "rate": rate,
        "jewellery_name": jewelleryName,
        "productId": productId,
        "image": image,
        "commodity": commodity,
        "discount_price": discountPrice,
        "discount_percentage": discountPercentage,
        "lot_code": lotCode,
        "shape": shape,
        "labs": labs,
        "cut": cut,
        "color": color,
        "clarity": clarity,
        "cts_or_gms": ctsOrGms,
        "polish": polish,
        "symmetry": symmetry,
        "depth": depth,
        "table": table,
        "measurements": measurements,
        "rappaport_price": rappaportPrice,
        "status": status,
        "csc_code": cscCode,
        "original_final_price": originalFinalPrice,
        "final_price": finalPrice,
        "stock_qty": stockQty,
        "shape_image": shapeImage,
        "certificate_file": certificateFile,
        "open_dna_url": openDnaUrl,
        "fluorescence": fluorescence,
        "certificate": certificate,
        "your_discount": yourDiscount,
        "original_your_rate": originalYourRate,
        "your_rate": yourRate,
        "original_your_amount": originalYourAmount,
        "your_amount": yourAmount,
        "original_totalPrice": originalTotalPrice,
        "totalPrice": totalPrice,
        "location": location,
        "crt": crt,
        "gms": gms,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyBagResult &&
          runtimeType == other.runtimeType &&
          suid == other.suid &&
          quantity == other.quantity &&
          totalPrice == other.totalPrice &&
          rate == other.rate &&
          jewelleryName == other.jewelleryName &&
          productId == other.productId &&
          image == other.image &&
          commodity == other.commodity &&
          discountPrice == other.discountPrice &&
          discountPercentage == other.discountPercentage &&
          lotCode == other.lotCode &&
          shape == other.shape &&
          labs == other.labs &&
          cut == other.cut &&
          color == other.color &&
          clarity == other.clarity &&
          ctsOrGms == other.ctsOrGms &&
          polish == other.polish &&
          symmetry == other.symmetry &&
          depth == other.depth &&
          table == other.table &&
          measurements == other.measurements &&
          rappaportPrice == other.rappaportPrice &&
          location == other.location &&
          status == other.status &&
          finalPrice == other.finalPrice &&
          shapeImage == other.shapeImage &&
          certificateFile == other.certificateFile &&
          openDnaUrl == other.openDnaUrl &&
          fluorescence == other.fluorescence &&
          stockQty == other.stockQty &&
          yourDiscount == other.yourDiscount &&
          yourRate == other.yourRate &&
          yourAmount == other.yourAmount &&
          originalYourRate == other.originalYourRate &&
          originalYourAmount == other.originalYourAmount &&
          originalTotalPrice == other.originalTotalPrice &&
          cscCode == other.cscCode &&
          originalFinalPrice == other.originalFinalPrice &&
          certificate == other.certificate;

  @override
  int get hashCode =>
      suid.hashCode ^
      quantity.hashCode ^
      totalPrice.hashCode ^
      rate.hashCode ^
      jewelleryName.hashCode ^
      productId.hashCode ^
      image.hashCode ^
      commodity.hashCode ^
      discountPrice.hashCode ^
      discountPercentage.hashCode ^
      lotCode.hashCode ^
      shape.hashCode ^
      labs.hashCode ^
      cut.hashCode ^
      color.hashCode ^
      clarity.hashCode ^
      ctsOrGms.hashCode ^
      polish.hashCode ^
      symmetry.hashCode ^
      depth.hashCode ^
      table.hashCode ^
      measurements.hashCode ^
      rappaportPrice.hashCode ^
      location.hashCode ^
      status.hashCode ^
      finalPrice.hashCode ^
      shapeImage.hashCode ^
      certificateFile.hashCode ^
      openDnaUrl.hashCode ^
      fluorescence.hashCode ^
      stockQty.hashCode ^
      yourDiscount.hashCode ^
      yourRate.hashCode ^
      yourAmount.hashCode ^
      originalYourRate.hashCode ^
      originalYourAmount.hashCode ^
      originalTotalPrice.hashCode ^
      cscCode.hashCode ^
      originalFinalPrice.hashCode ^
      certificate.hashCode;

  @override
  String toString() {
    return 'MyBagResult{suid: $suid, quantity: $quantity, totalPrice: $totalPrice, rate: $rate, jewelleryName: $jewelleryName, productId: $productId, image: $image, commodity: $commodity, discountPrice: $discountPrice, discountPercentage: $discountPercentage, lotCode: $lotCode, shape: $shape, labs: $labs, cut: $cut, color: $color, clarity: $clarity, ctsOrGms: $ctsOrGms, polish: $polish, symmetry: $symmetry, depth: $depth, table: $table, measurements: $measurements, rappaportPrice: $rappaportPrice, location: $location, status: $status, finalPrice: $finalPrice, shapeImage: $shapeImage, certificateFile: $certificateFile, openDnaUrl: $openDnaUrl, fluorescence: $fluorescence, stockQty: $stockQty, yourDiscount: $yourDiscount, yourRate: $yourRate, yourAmount: $yourAmount, originalYourRate: $originalYourRate, originalYourAmount: $originalYourAmount, originalTotalPrice: $originalTotalPrice, cscCode: $cscCode, originalFinalPrice: $originalFinalPrice, certificate: $certificate}';
  }

  Commodity get displayCommodity => Commodity.values.firstWhereOrNull((element) => element.value == commodity) ?? Commodity.diamond;

  String? get crtEXT {
    final crtValue = double.tryParse(crt ?? '0') ?? 0.0;
    return crtValue > 0 ? crt : null;
  }
}

class BagSummary {
  BagSummary({
    this.totalItems,
    this.totalCarats,
    this.originalAmount,
    this.discountPercentage,
    this.discountAmount,
    this.yourDiscount,
    this.yourRate,
    this.yourAmount,
    this.totalAmount,
    this.originalYourRate,
    this.originalYourAmount,
  });

  final int? totalItems;
  final double? totalCarats;
  final String? originalAmount;
  final double? discountPercentage;
  final String? discountAmount;
  final double? yourDiscount;
  final String? yourRate;
  final String? yourAmount;
  final double? totalAmount;
  final double? originalYourRate;
  final double? originalYourAmount;

  BagSummary copyWith({
    int? totalItems,
    double? totalCarats,
    String? originalAmount,
    double? discountPercentage,
    String? discountAmount,
    double? yourDiscount,
    String? yourRate,
    String? yourAmount,
    double? totalAmount,
    double? originalYourRate,
    double? originalYourAmount,
  }) {
    return BagSummary(
      totalItems: totalItems ?? this.totalItems,
      totalCarats: totalCarats ?? this.totalCarats,
      originalAmount: originalAmount ?? this.originalAmount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      yourAmount: yourAmount ?? this.yourAmount,
      yourRate: yourRate ?? this.yourRate,
      yourDiscount: yourDiscount ?? this.yourDiscount,
      totalAmount: totalAmount ?? this.totalAmount,
      originalYourRate: originalYourRate ?? this.originalYourRate,
      originalYourAmount: originalYourAmount ?? this.originalYourAmount,
    );
  }

  factory BagSummary.fromJson(Map<String, dynamic> json) {
    return BagSummary(
      totalItems: json["total_items"],
      totalCarats: json["total_carats"]?.toString().toDouble,
      originalAmount: json["original_amount"],
      discountPercentage: json["discount_percentage"]?.toString().toDouble,
      discountAmount: json["discount_amount"],
      yourAmount: json["your_amount"]?.toString(),
      yourRate: json["your_rate"]?.toString(),
      yourDiscount: json["your_discount"]?.toString().toDouble,
      totalAmount: json["total_amount"]?.toString().toDouble,
      originalYourRate: json["original_your_rate"]?.toString().toDouble,
      originalYourAmount: json["original_your_amount"]?.toString().toDouble,
    );
  }

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "total_carats": totalCarats,
        "original_amount": originalAmount,
        "discount_percentage": discountPercentage,
        "discount_amount": discountAmount,
        "your_discount": yourDiscount,
        "your_rate": yourRate,
        "your_amount": yourAmount,
        "total_amount": totalAmount,
        "original_your_rate": originalYourRate,
        "original_your_amount": originalYourAmount,
      };
}
