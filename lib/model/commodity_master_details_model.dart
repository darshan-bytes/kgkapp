class CommodityMasterDetails {
  CommodityMasterDetails({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.code,
    required this.name,
    required this.subTypeCode,
    required this.imgReferenceId,
    required this.imgPath,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final String? code;
  final String? name;
  final String? subTypeCode;
  final String? imgReferenceId;
  final String? imgPath;

  CommodityMasterDetails copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? code,
    String? name,
    String? subTypeCode,
    String? imgReferenceId,
    String? imgPath,
  }) {
    return CommodityMasterDetails(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      subTypeCode: subTypeCode ?? this.subTypeCode,
      imgReferenceId: imgReferenceId ?? this.imgReferenceId,
      imgPath: imgPath ?? this.imgPath,
    );
  }

  factory CommodityMasterDetails.fromJson(Map<String, dynamic> json) {
    return CommodityMasterDetails(
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      id: json["id"],
      code: json["code"],
      name: json["name"],
      subTypeCode: json["sub_type_code"],
      imgReferenceId: json["img_reference_id"],
      imgPath: json["img_path"],
    );
  }

  Map<String, dynamic> toJson() => {
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
        "code": code,
        "name": name,
        "sub_type_code": subTypeCode,
        "img_reference_id": imgReferenceId,
        "img_path": imgPath,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommodityMasterDetails &&
          runtimeType == other.runtimeType &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          id == other.id &&
          code == other.code &&
          name == other.name &&
          subTypeCode == other.subTypeCode &&
          imgReferenceId == other.imgReferenceId &&
          imgPath == other.imgPath;

  @override
  int get hashCode =>
      createdAt.hashCode ^
      updatedAt.hashCode ^
      id.hashCode ^
      code.hashCode ^
      name.hashCode ^
      subTypeCode.hashCode ^
      imgReferenceId.hashCode ^
      imgPath.hashCode;
}
