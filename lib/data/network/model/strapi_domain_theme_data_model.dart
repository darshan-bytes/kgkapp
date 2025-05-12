class StrapiDomainThemeDataModel {
  StrapiDomainThemeDataModel({
    required this.data,
  });

  final DomainThemeData? data;

  factory StrapiDomainThemeDataModel.fromJson(Map<String, dynamic> json) {
    return StrapiDomainThemeDataModel(
      data: json["data"] == null ? null : DomainThemeData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class DomainThemeData {
  DomainThemeData({
    required this.id,
    required this.attributes,
  });

  final int? id;
  final ThemeAttributes? attributes;

  factory DomainThemeData.fromJson(Map<String, dynamic> json) {
    return DomainThemeData(
      id: json["id"],
      attributes: json["attributes"] == null ? null : ThemeAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes?.toJson(),
      };
}

class ThemeAttributes {
  ThemeAttributes({
    required this.theme,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  final String? theme;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;

  factory ThemeAttributes.fromJson(Map<String, dynamic> json) {
    return ThemeAttributes(
      theme: json["theme"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "theme": theme,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
      };
}
