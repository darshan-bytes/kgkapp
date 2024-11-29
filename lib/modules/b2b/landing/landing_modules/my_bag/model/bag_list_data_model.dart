import 'package:kgk/kgk.dart';

class BagListDataModel {
  BagListDataModel({
    required this.result,
    required this.totalRecords,
    required this.page,
    required this.limit,
  });

  final List<Result> result;
  final int? totalRecords;
  final int? page;
  final int? limit;

  BagListDataModel copyWith({
    List<Result>? result,
    int? totalRecords,
    int? page,
    int? limit,
  }) {
    return BagListDataModel(
      result: result ?? this.result,
      totalRecords: totalRecords ?? this.totalRecords,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  factory BagListDataModel.fromJson(Map<String, dynamic> json) {
    return BagListDataModel(
      result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      totalRecords: json["totalRecords"],
      page: json["page"]?.toString().toInt,
      limit: json["limit"]?.toString().toInt,
    );
  }

  Map<String, dynamic> toJson() => {
        "result": result.map((x) => x.toJson()).toList(),
        "totalRecords": totalRecords,
        "page": page,
        "limit": limit,
      };

  @override
  String toString() {
    return "$result, $totalRecords, $page, $limit, ";
  }
}

class Result {
  Result({
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
  });

  final String? suid;
  final int? quantity;
  final double? totalPrice;
  final String? rate;
  final String? jewelleryName;
  final String? productId;
  final String? image;
  final String? commodity;
  final String? discountPrice;
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

  Result copyWith({
    String? suid,
    int? quantity,
    double? totalPrice,
    String? rate,
    String? jewelleryName,
    String? productId,
    String? image,
    String? commodity,
    String? discountPrice,
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
  }) {
    return Result(
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
    );
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      suid: json["suid"],
      quantity: json["quantity"],
      totalPrice: json["totalPrice"].toDouble(),
      rate: json["rate"]?.toString(),
      jewelleryName: json["jewellery_name"],
      productId: json["productId"],
      image: json["image"],
      commodity: json["commodity"],
      discountPrice: json["discount_price"]?.toString(),
      discountPercentage: json["discount_percentage"]?.toDouble(),
      lotCode: json["lot_code"],
      shape: json["shape"],
      labs: json["labs"],
      cut: json["cut"],
      color: json["color"],
      clarity: json["clarity"],
      ctsOrGms: json["cts_or_gms"],
      polish: json["polish"],
      symmetry: json["symmetry"],
      depth: json["depth"],
      table: json["table"],
      measurements: json["measurements"],
      rappaportPrice: json["rappaport_price"],
      location: json["location"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "suid": suid,
        "quantity": quantity,
        "totalPrice": totalPrice,
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
        "location": location,
        "status": status,
      };

  @override
  String toString() {
    return "$suid, $quantity, $totalPrice, $rate, $jewelleryName, $productId, $image, $commodity, $discountPrice, $discountPercentage, $lotCode, $shape, $labs, $cut, $color, $clarity, $ctsOrGms, $polish, $symmetry, $depth, $table, $measurements, $rappaportPrice, $location, $status, ";
  }

  Commodity get displayCommodity => Commodity.values.firstWhereOrNull((element) => element.value == commodity) ?? Commodity.diamond;
}
