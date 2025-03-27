import 'package:kgk/kgk.dart';

class LanguageListModel {
  LanguageListModel({
    required this.filteredRecords,
    required this.totalRecords,
    required this.languageData,
    required this.limit,
    required this.page,
  });

  final int? filteredRecords;
  final int? totalRecords;
  final List<LanguageDatum> languageData;
  final int? limit;
  final int? page;

  LanguageListModel copyWith({
    int? filteredRecords,
    int? totalRecords,
    List<LanguageDatum>? languageData,
    int? limit,
    int? page,
  }) {
    return LanguageListModel(
      filteredRecords: filteredRecords ?? this.filteredRecords,
      totalRecords: totalRecords ?? this.totalRecords,
      languageData: languageData ?? this.languageData,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }

  factory LanguageListModel.fromJson(Map<String, dynamic> json) {
    return LanguageListModel(
      filteredRecords: json["filteredRecords"],
      totalRecords: json["totalRecords"],
      languageData: json["data"] == null ? [] : List<LanguageDatum>.from(json["data"]!.map((x) => LanguageDatum.fromJson(x))),
      limit: json["limit"],
      page: json["page"],
    );
  }

  Map<String, dynamic> toJson() => {
        "filteredRecords": filteredRecords,
        "totalRecords": totalRecords,
        "data": languageData.map((x) => x.toJson()).toList(),
        "limit": limit,
        "page": page,
      };

  @override
  String toString() {
    return "$filteredRecords, $totalRecords, $languageData, $limit, $page, ";
  }
}

class LanguageDatum {
  LanguageDatum({
    required this.name,
    required this.slug,
    required this.code,
    required this.textDirection,
    required this.dateFormat,
    required this.createdBy,
    required this.updatedBy,
    required this.status,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.flagIcon,
    required this.createdByDetails,
    required this.updatedByDetails,
  });

  final String? name;
  final String? slug;
  final String? code;
  final String? textDirection;
  final String? dateFormat;
  final String? createdBy;
  final String? updatedBy;
  final bool? status;
  final bool? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final String? flagIcon;
  final UserIdDetails? createdByDetails;
  final UserIdDetails? updatedByDetails;

  factory LanguageDatum.fromJson(Map<String, dynamic> json) {
    return LanguageDatum(
      name: json["name"],
      slug: json["slug"],
      code: json["code"],
      textDirection: json["text_direction"],
      dateFormat: json["date_format"],
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      status: json["status"],
      isDefault: json["is_default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      id: json["id"],
      flagIcon: json["flag_icon"],
      createdByDetails: json["created_by_details"] == null ? null : UserIdDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : UserIdDetails.fromJson(json["updated_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "code": code,
        "text_direction": textDirection,
        "date_format": dateFormat,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "status": status,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
        "flag_icon": flagIcon,
        "created_by_details": createdByDetails?.toJson(),
        "updated_by_details": updatedByDetails?.toJson(),
      };

  @override
  String toString() {
    return jsonEncode(toJson);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageDatum &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          slug == other.slug &&
          code == other.code &&
          textDirection == other.textDirection &&
          dateFormat == other.dateFormat &&
          status == other.status &&
          id == other.id;

  @override
  int get hashCode =>
      name.hashCode ^ slug.hashCode ^ code.hashCode ^ textDirection.hashCode ^ dateFormat.hashCode ^ status.hashCode ^ id.hashCode;

  String get mobileSymbol {
    return code.isNotNullNorEmpty ? (code!.toLowerCase().contains('zh') ? code! : code!.split('-').firstOrNull ?? 'en') : 'en';
  }
}
