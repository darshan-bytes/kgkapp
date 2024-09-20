class GemstoneFilterModel {
  GemstoneFilterModel({
    required this.name,
    required this.slug,
    required this.defaultValue,
    required this.inputType,
    required this.data,
    required this.id,
  });

  final String? name;
  final String? slug;
  final dynamic defaultValue;
  final String? inputType;
  final List<String> data;
  final int? id;

  GemstoneFilterModel copyWith({
    String? name,
    String? slug,
    dynamic defaultValue,
    String? inputType,
    List<String>? data,
    int? id,
  }) {
    return GemstoneFilterModel(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      defaultValue: defaultValue ?? this.defaultValue,
      inputType: inputType ?? this.inputType,
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }

  factory GemstoneFilterModel.fromJson(Map<String, dynamic> json){
    return GemstoneFilterModel(
      name: json["name"],
      slug: json["slug"],
      defaultValue: json["default_value"],
      inputType: json["input_type"],
      data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x.toString())),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "default_value": defaultValue,
    "input_type": inputType,
    "data": data.map((x) => x).toList(),
    "id": id,
  };

  @override
  String toString(){
    return "$name, $slug, $defaultValue, $inputType, $data, $id, ";
  }
}