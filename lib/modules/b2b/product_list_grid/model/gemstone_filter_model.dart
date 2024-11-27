class FilterOptionModel {
  FilterOptionModel({
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
  final dynamic data;
  final int? id;

  FilterOptionModel copyWith({
    String? name,
    String? slug,
    dynamic defaultValue,
    String? inputType,
    dynamic data,
    int? id,
  }) {
    return FilterOptionModel(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      defaultValue: defaultValue ?? this.defaultValue,
      inputType: inputType ?? this.inputType,
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }

  factory FilterOptionModel.fromJson(Map<String, dynamic> json) {
    return FilterOptionModel(
      name: json["name"],
      slug: json["slug"],
      defaultValue: json["default_value"],
      inputType: json["input_type"],
      data: json["data"] ?? [],
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
  String toString() {
    return "$name, $slug, $defaultValue, $inputType, $data, $id, ";
  }
}
