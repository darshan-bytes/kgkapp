class OrionDetailModel {
  OrionDetailModel({required this.cuts, required this.colors, required this.clarity});

  final List<String> cuts;
  final List<String> colors;
  final List<String> clarity;

  factory OrionDetailModel.fromJson(Map<String, dynamic> json) {
    return OrionDetailModel(
      cuts: json["cuts"] == null ? [] : List<String>.from(json["cuts"]!.map((x) => x)),
      colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
      clarity: json["clarity"] == null ? [] : List<String>.from(json["clarity"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "cuts": cuts.map((x) => x).toList(),
    "colors": colors.map((x) => x).toList(),
    "clarity": clarity.map((x) => x).toList(),
  };

  @override
  String toString() {
    return "$cuts, $colors, $clarity, ";
  }
}
