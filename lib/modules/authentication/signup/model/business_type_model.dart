class BusinessType {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final String? name;
  final String? slug;
  bool isSelected;

  BusinessType({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.slug,
    this.isSelected = false,
  });

  factory BusinessType.fromJson(Map<String, dynamic> json) {
    return BusinessType(
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
    );
  }

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "id": id,
    "name": name,
    "slug": slug,
  };
}
