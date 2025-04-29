class DiyJewelleryType {
  DiyJewelleryType({required this.jewelleryTypeCode, required this.jewelleryTypeName});

  final String? jewelleryTypeCode;
  final String? jewelleryTypeName;

  factory DiyJewelleryType.fromJson(Map<String, dynamic> json) {
    return DiyJewelleryType(jewelleryTypeCode: json["jewellery_type_code"], jewelleryTypeName: json["jewellery_type_name"]);
  }

  Map<String, dynamic> toJson() => {"jewellery_type_code": jewelleryTypeCode, "jewellery_type_name": jewelleryTypeName};
}
