import 'package:kgk/kgk.dart';

class CatalogueSharedUserWrapper {
  CatalogueSharedUserWrapper({required this.id, required this.catalogueType, required this.sharedWith});

  final String? id;
  final String? catalogueType;
  final List<CatalogueSharedUserData> sharedWith;

  factory CatalogueSharedUserWrapper.fromJson(Map<String, dynamic> json) {
    return CatalogueSharedUserWrapper(
      id: json["_id"],
      catalogueType: json["catalogue_type"],
      sharedWith:
          json["shared_with"] == null
              ? []
              : List<CatalogueSharedUserData>.from(json["shared_with"]!.map((x) => CatalogueSharedUserData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {"_id": id, "catalogue_type": catalogueType, "shared_with": sharedWith.map((x) => x.toJson()).toList()};
}

class CatalogueSharedUserData {
  CatalogueSharedUserData({
    required this.createdAt,
    required this.updatedAt,
    required this.sharedBy,
    required this.sharedTo,
    required this.sharedType,
    this.isViewer = false,
    this.isEditable = false,
    required this.accessFields,
    required this.id,
    required this.user,
  });

  final String? createdAt;
  final String? updatedAt;
  final int? sharedBy;
  final int? sharedTo;
  final String? sharedType;
  final bool isViewer;
  final bool isEditable;
  final String? accessFields;
  final String? id;
  final UserIdDetails? user;

  factory CatalogueSharedUserData.fromJson(Map<String, dynamic> json) {
    return CatalogueSharedUserData(
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      sharedBy: json["shared_by"],
      sharedTo: json["shared_to"],
      sharedType: json["shared_type"],
      isViewer: json["is_viewer"],
      isEditable: json["is_editable"],
      accessFields: json["access_fields"],
      id: json["_id"],
      user: json["user"] == null ? null : UserIdDetails.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "shared_by": sharedBy,
    "shared_to": sharedTo,
    "shared_type": sharedType,
    "is_viewer": isViewer,
    "is_editable": isEditable,
    "access_fields": accessFields,
    "_id": id,
    "user": user?.toJson(),
  };
}
