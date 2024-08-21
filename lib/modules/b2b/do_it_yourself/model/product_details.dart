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
  bool showMore;
  double? ctsOrGms;
  String? rappaportPrice;
  String? priceCts;
  String? discountPrice;
  String? finalPrice;
  String? lotCode;
  String? shape;
  String? fluorescence;
  String? labs;
  String? lsp;
  String? color;
  String? clarity;
  String? cut;
  String? certificateFile;
  String? openDnaUrl;

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
    this.showMore = false,
    this.ctsOrGms,
    this.rappaportPrice,
    this.priceCts,
    this.discountPrice,
    this.finalPrice,
    this.lotCode,
    this.shape,
    this.fluorescence,
    this.labs,
    this.lsp,
    this.color,
    this.clarity,
    this.cut,
    this.certificateFile,
    this.openDnaUrl,
  });
}
