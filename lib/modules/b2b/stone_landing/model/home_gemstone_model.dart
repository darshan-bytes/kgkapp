class HomeGemstonesModel {
  HomeGemstonesModel({
    required this.id,
    required this.referenceId,
    required this.rawMaterialName,
    required this.image,
    required this.importedFrom,
    required this.suid,
    required this.commodityName,
    required this.commodityGroup,
    required this.subTypeCode,
    required this.subTypeName,
    required this.commodityCode,
    required this.updatedDateTime,
  });

  final String? id;
  final String? referenceId;
  final String? rawMaterialName;
  final dynamic image;
  final String? importedFrom;
  final String? suid;
  final String? commodityName;
  final String? commodityGroup;
  final String? subTypeCode;
  final String? subTypeName;
  final String? commodityCode;
  final String? updatedDateTime;

  factory HomeGemstonesModel.fromJson(Map<String, dynamic> json) {
    return HomeGemstonesModel(
      id: json["_id"],
      referenceId: json["reference_id"],
      rawMaterialName: json["raw_material_name"],
      image: json["image"],
      importedFrom: json["imported_from"],
      suid: json["suid"],
      commodityName: json["commodity_name"],
      commodityGroup: json["commodity_group"],
      subTypeCode: json["sub_type_code"],
      subTypeName: json["sub_type_name"],
      commodityCode: json["commodity_code"],
      updatedDateTime: json["updated_date_time"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reference_id": referenceId,
    "raw_material_name": rawMaterialName,
    "image": image,
    "imported_from": importedFrom,
    "suid": suid,
    "commodity_name": commodityName,
    "commodity_group": commodityGroup,
    "sub_type_code": subTypeCode,
    "sub_type_name": subTypeName,
    "commodity_code": commodityCode,
    "updated_date_time": updatedDateTime,
  };

  @override
  String toString() {
    return "$id, $referenceId, $rawMaterialName, $image, $importedFrom, $suid, $commodityName, $commodityGroup, $subTypeCode, $subTypeName, $commodityCode, $updatedDateTime, ";
  }
}
