class DigitalCatalogueListingModel {
  int? id;
  String? name;
  String? description;
  String? image;
  String? productCount;
  String? date;
  bool isWebView;
  String? webUrl;

  DigitalCatalogueListingModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.productCount,
    this.date,
    this.isWebView = false,
    this.webUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DigitalCatalogueListingModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.productCount == productCount &&
        other.date == date &&
        other.isWebView == isWebView &&
        other.webUrl == webUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        productCount.hashCode ^
        date.hashCode ^
        isWebView.hashCode ^
        webUrl.hashCode;
  }
}
