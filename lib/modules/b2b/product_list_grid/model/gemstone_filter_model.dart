import 'package:kgk/kgk.dart';

class FilterOptionModel {
  FilterOptionModel({
    required this.name,
    required this.slug,
    required this.defaultValue,
    required this.inputType,
    required this.data,
    required this.id,
    this.fromCommon = false,
  });

  int? id;
  String? name;
  String? slug;
  dynamic defaultValue;
  String? inputType;
  List<dynamic> data;
  bool fromCommon;

  factory FilterOptionModel.fromJson(Map<String, dynamic> json) {
    return FilterOptionModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      defaultValue: json["default_value"],
      inputType: json["input_type"],
      data: json["data"] ?? [],
      fromCommon: json["fromCommon"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "default_value": defaultValue,
        "input_type": inputType,
        "data": data.map((x) => x).toList(),
        "id": id,
        "fromCommon": fromCommon,
      };

  @override
  String toString() {
    return "$name, $slug, $defaultValue, $inputType, $data, $id, $fromCommon";
  }
}

extension FilterOptionModelExtension on FilterOptionModel {
  FilterType get filterType =>
      FilterType.values.firstWhereOrNull((element) => element.value.toLowerCase() == inputType?.toLowerCase()) ?? FilterType.undefined;
}
