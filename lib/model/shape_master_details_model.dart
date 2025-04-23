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
