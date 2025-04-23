class MetalShapeModel {
  MetalShapeModel({
    required this.id,
    required this.referenceId,
    required this.productDescription,
    required this.lotCode,
    required this.image,
    required this.colorName,
    required this.rawMaterialName,
    required this.sortingNo,
    required this.karatage,
    required this.importedFrom,
    required this.suid,
    required this.subareaCode,
    required this.refSuid,
    required this.subareaName,
    required this.commodityName,
  });

  final String? id;
  final String? referenceId;
  final String? productDescription;
  final String? lotCode;
  final dynamic image;
  final String? colorName;
  final String? rawMaterialName;
  final dynamic sortingNo;
  final String? karatage;
  final String? importedFrom;
  final String? suid;
  final dynamic subareaCode;
  final int? refSuid;
  final dynamic subareaName;
  final String? commodityName;

  factory MetalShapeModel.fromJson(Map<String, dynamic> json) {
    return MetalShapeModel(
      id: json["_id"],
      referenceId: json["reference_id"],
      productDescription: json["product_description"],
      lotCode: json["lot_code"],
      image: json["image"],
      colorName: json["color_name"],
      rawMaterialName: json["raw_material_name"],
      sortingNo: json["sorting_no"],
      karatage: json["karatage"],
      importedFrom: json["imported_from"],
      suid: json["suid"],
      subareaCode: json["subarea_code"],
      refSuid: json["ref_suid"],
      subareaName: json["subarea_name"],
      commodityName: json["commodity_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "reference_id": referenceId,
    "product_description": productDescription,
    "lot_code": lotCode,
    "image": image,
    "color_name": colorName,
    "raw_material_name": rawMaterialName,
    "sorting_no": sortingNo,
    "karatage": karatage,
    "imported_from": importedFrom,
    "suid": suid,
    "subarea_code": subareaCode,
    "ref_suid": refSuid,
    "subarea_name": subareaName,
    "commodity_name": commodityName,
  };
}
