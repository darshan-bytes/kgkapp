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
  bool isDiamondProduct;
  DiamondClarityChart? diamondClarityChart;
  ProductInfoClarityChat? productInfoClarityChat;
  bool isOutOfStock;
  String? company;
  String? productSku;

  ProductDetails({
    this.productId,
    this.name,
    this.offerPrice,
    this.originalPrice,
    this.imageUrl,
    this.discountPercentage,
    this.gram,
    this.diamond,
    this.productQuality,
    this.productQuantity,
    this.cartProductQuality,
    this.cartProductQuantity,
    this.isSelectedProduct = false,
    this.isDiamondProduct = false,
    this.diamondClarityChart,
    this.productInfoClarityChat,
    this.isOutOfStock = false,
    this.company,
    this.productSku,
  });
}
