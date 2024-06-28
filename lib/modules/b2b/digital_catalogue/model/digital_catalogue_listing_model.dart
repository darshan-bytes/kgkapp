class DigitalCatalogueListingModel {
  String? image;
  String? name;
  String? productCount;
  String? date;
  int? id;

  DigitalCatalogueListingModel({
    this.image,
    this.name,
    this.productCount,
    this.date,
    this.id,
  });

  @override
  bool operator ==(Object other) {
    return other is DigitalCatalogueListingModel &&
        other.name == name &&
        other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
