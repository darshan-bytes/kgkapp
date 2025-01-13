class OrionShapeModel {
  OrionShapeModel({
    required this.count,
    required this.shape,
    required this.shapeCode,
    required this.imgPath,
    required this.symbolPath,
  });

  final int? count;
  final String? shape;
  final String? shapeCode;
  final String? imgPath;
  final String? symbolPath;

  OrionShapeModel copyWith({
    int? count,
    String? shape,
    String? shapeCode,
    String? imgPath,
    String? symbolPath,
  }) {
    return OrionShapeModel(
      count: count ?? this.count,
      shape: shape ?? this.shape,
      shapeCode: shapeCode ?? this.shapeCode,
      imgPath: imgPath ?? this.imgPath,
      symbolPath: symbolPath ?? this.symbolPath,
    );
  }

  factory OrionShapeModel.fromJson(Map<String, dynamic> json) {
    return OrionShapeModel(
      count: json["count"],
      shape: json["shape"],
      shapeCode: json["shape_code"],
      imgPath: json["img_path"],
      symbolPath: json["symbol_path"],
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "shape": shape,
        "shape_code": shapeCode,
        "img_path": imgPath,
        "symbol_path": symbolPath,
      };
}
