import 'package:kgk/kgk.dart';

class DigitalCatalogueDetails {
  DigitalCatalogueDetails({
    required this.id,
    required this.name,
    required this.catalogueType,
    required this.cscCode,
    required this.validFrom,
    required this.validTo,
    required this.isPublic,
    required this.createdBy,
    required this.updatedBy,
    required this.status,
    required this.templateId,
    required this.products,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.sharedWith,
    required this.v,
    required this.catalogueCoverImage,
    required this.isViewer,
    required this.isEditable,
    required this.createdByDetails,
    required this.updatedByDetails,
  });

  final String? id;
  final String? name;
  final String? catalogueType;
  final String? cscCode;
  final DateTime? validFrom;
  final DateTime? validTo;
  final bool? isPublic;
  final int? createdBy;
  final int? updatedBy;
  final String? status;
  final String? templateId;
  final List<CatalogueProduct> products;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> sharedWith;
  final int? v;
  final String? catalogueCoverImage;
  final bool? isViewer;
  final bool? isEditable;
  final UserIdDetails? createdByDetails;
  final UserIdDetails? updatedByDetails;

  factory DigitalCatalogueDetails.fromJson(Map<String, dynamic> json) {
    return DigitalCatalogueDetails(
      id: json["_id"],
      name: json["name"],
      catalogueType: json["catalogue_type"],
      cscCode: json["csc_code"],
      validFrom: DateTime.tryParse(json["valid_from"] ?? ""),
      validTo: DateTime.tryParse(json["valid_to"] ?? ""),
      isPublic: json["is_public"],
      createdBy: json["created_by"],
      updatedBy: json["updated_by"],
      status: json["status"],
      templateId: json["template_id"],
      products: json["products"] == null ? [] : List<CatalogueProduct>.from(json["products"]!.map((x) => CatalogueProduct.fromJson(x))),
      deleted: json["deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      sharedWith: json["shared_with"] == null ? [] : List<dynamic>.from(json["shared_with"]!.map((x) => x)),
      v: json["__v"],
      catalogueCoverImage: json["catalogue_cover_image"],
      isViewer: json["is_viewer"],
      isEditable: json["is_editable"],
      createdByDetails: json["created_by_details"] == null ? null : UserIdDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : UserIdDetails.fromJson(json["updated_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "catalogue_type": catalogueType,
    "csc_code": cscCode,
    "valid_from": validFrom?.toIso8601String(),
    "valid_to": validTo?.toIso8601String(),
    "is_public": isPublic,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "status": status,
    "template_id": templateId,
    "products": products.map((x) => x.toJson()).toList(),
    "deleted": deleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "shared_with": sharedWith.map((x) => x).toList(),
    "__v": v,
    "catalogue_cover_image": catalogueCoverImage,
    "is_viewer": isViewer,
    "is_editable": isEditable,
    "created_by_details": createdByDetails?.toJson(),
    "updated_by_details": updatedByDetails?.toJson(),
  };
}

class CatalogueProduct {
  CatalogueProduct({required this.productId});

  final String? productId;

  CatalogueProduct copyWith({String? productId}) {
    return CatalogueProduct(productId: productId ?? this.productId);
  }

  factory CatalogueProduct.fromJson(Map<String, dynamic> json) {
    return CatalogueProduct(productId: json["product_id"]);
  }

  Map<String, dynamic> toJson() => {"product_id": productId};
}
