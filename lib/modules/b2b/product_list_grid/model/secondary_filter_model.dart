class SecondaryFilterModel {
  SecondaryFilterModel({
    required this.value,
    required this.label,
    this.imgReferenceId,
    this.stoneType,
    this.imgPath,
  });

  final String? value;
  final String? label;
  final String? imgReferenceId;
  final String? stoneType;
  final String? imgPath;

  factory SecondaryFilterModel.fromJson(Map<String, dynamic> json) {
    return SecondaryFilterModel(
      value: json["value"]?.toString(),
      label: json["label"],
      imgReferenceId: json["img_reference_id"],
      stoneType: json["stone_type"],
      imgPath: json["img_path"],
    );
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
        "img_reference_id": imgReferenceId,
        "stone_type": stoneType,
        "img_path": imgPath,
      };

  @override
  String toString() {
    return "$value, $label, $imgReferenceId, $stoneType, $imgPath, ";
  }
}
