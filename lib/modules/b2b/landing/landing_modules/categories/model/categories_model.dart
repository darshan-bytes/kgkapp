class CategoriesModel {
  String? name;
  String? image;
  List<ProductDetailModel>? productsDetailsList = [];
  bool isExpanded;

  CategoriesModel({this.name, this.image, this.productsDetailsList, this.isExpanded = true});
}

class ProductDetailModel {
  String? name;
  String? image;
  Map<String, dynamic>? data;

  ProductDetailModel({this.name, this.image, this.data});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailModel && runtimeType == other.runtimeType && name == other.name && image == other.image && data == other.data;

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ data.hashCode;
}
