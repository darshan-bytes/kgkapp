import 'package:kgk/kgk.dart';

class ProductDetails {
  String? productId;
  String? name;
  String? offerPrice;
  String? originalPrice;
  String? imageUrl;
  String? discountPercentage;
  String? gram;
  String? diamond;
  CartProductQuality? productQuality;
  CartProductQuantity? productQuantity;
  List<CartProductQuality>? cartProductQuality;
  List<CartProductQuantity>? cartProductQuantity;
  bool isSelectedProduct;

  ProductDetails(
      {this.name,
      this.offerPrice,
      this.originalPrice,
      this.imageUrl,
      this.discountPercentage,
      this.gram,
      this.diamond,
      this.productId,
      this.productQuality,
      this.productQuantity,
      this.cartProductQuality,
      this.cartProductQuantity,
      this.isSelectedProduct = false});
}
