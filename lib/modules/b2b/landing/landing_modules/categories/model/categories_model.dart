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

  ProductDetailModel({this.name, this.image});
}
