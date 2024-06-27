class CategoriesModel {
  String? name;
  String? image;
  List<String>? productsDetailsList = [];
  bool isExpanded;

  CategoriesModel({this.name, this.image, this.productsDetailsList, this.isExpanded = true});
}
