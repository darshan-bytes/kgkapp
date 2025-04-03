class ShapeMasterDetails {
  ShapeMasterDetails({
    required this.id,
    required this.refSuid,
    required this.suid,
    required this.referenceId,
    required this.importedFrom,
    required this.shapeCode,
    required this.createdAt,
    required this.shapeName,
    required this.stoneType,
    required this.sortingOrder,
    required this.updatedDateTime,
    required this.receivedDateTime,
    required this.image,
  });

  final String? id;
  final int? refSuid;
  final String? suid;
  final String? referenceId;
  final String? importedFrom;
  final String? shapeCode;
  final DateTime? createdAt;
  final String? shapeName;
  final String? stoneType;
  final int? sortingOrder;
  final String? updatedDateTime;
  final DateTime? receivedDateTime;
  final String? image;

  factory ShapeMasterDetails.fromJson(Map<String, dynamic> json) {
    return ShapeMasterDetails(
      id: json["_id"],
      refSuid: json["ref_suid"],
      suid: json["suid"],
      referenceId: json["reference_id"],
      importedFrom: json["imported_from"],
      shapeCode: json["shape_code"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      shapeName: json["shape_name"],
      stoneType: json["stone_type"],
      sortingOrder: json["sorting_order"],
      updatedDateTime: json["updated_date_time"],
      receivedDateTime: DateTime.tryParse(json["received_date_time"] ?? ""),
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ref_suid": refSuid,
        "suid": suid,
        "reference_id": referenceId,
        "imported_from": importedFrom,
        "shape_code": shapeCode,
        "created_at": createdAt?.toIso8601String(),
        "shape_name": shapeName,
        "stone_type": stoneType,
        "sorting_order": sortingOrder,
        "updated_date_time": updatedDateTime,
        "received_date_time": receivedDateTime?.toIso8601String(),
        "image": image,
      };
}

/*
class ShapeMasterDetails {
  ShapeMasterDetails({
    required this.id,
    required this.referenceId,
    required this.suid,
    required this.refSuid,
    required this.importedFrom,
    required this.shapeId,
    required this.shapeName,
    required this.stoneType,
    required this.imgReferenceId,
    required this.symbolReferenceId,
    required this.sortingNo,
    required this.receivedAt,
    required this.updatedDateTime,
    required this.createdAt,
    required this.updatedAt,
    required this.imgPath,
    required this.symbolPath,
  });

  final int? id;
  final String? referenceId;
  final String? suid;
  final String? refSuid;
  final String? importedFrom;
  final String? shapeId;
  final String? shapeName;
  final String? stoneType;
  final String? imgReferenceId;
  final String? symbolReferenceId;
  final String? sortingNo;
  final DateTime? receivedAt;
  final DateTime? updatedDateTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imgPath;
  final String? symbolPath;

  factory ShapeMasterDetails.fromJson(Map<String, dynamic> json) {
    return ShapeMasterDetails(
      id: json["id"],
      referenceId: json["reference_id"],
      suid: json["suid"],
      refSuid: json["ref_suid"],
      importedFrom: json["imported_from"],
      shapeId: json["shape_id"],
      shapeName: json["shape_name"],
      stoneType: json["stone_type"],
      imgReferenceId: json["img_reference_id"],
      symbolReferenceId: json["symbol_reference_id"],
      sortingNo: json["sorting_no"],
      receivedAt: DateTime.tryParse(json["received_at"] ?? ""),
      updatedDateTime: DateTime.tryParse(json["updated_date_time"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      imgPath: json["img_path"],
      symbolPath: json["symbol_path"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference_id": referenceId,
        "suid": suid,
        "ref_suid": refSuid,
        "imported_from": importedFrom,
        "shape_id": shapeId,
        "shape_name": shapeName,
        "stone_type": stoneType,
        "img_reference_id": imgReferenceId,
        "symbol_reference_id": symbolReferenceId,
        "sorting_no": sortingNo,
        "received_at": receivedAt?.toIso8601String(),
        "updated_date_time": updatedDateTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "img_path": imgPath,
        "symbol_path": symbolPath,
      };
}
*/
