import 'package:kgk/kgk.dart';

class ProductDetailsModel {
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
  int? reviewCount;
  double? rating;
  String? brandName;
  Commodity? commodity;
  bool isFavourite;
  String? wishlistId;
  bool isForAuction;
  bool isCommentVisible;
  String? auctionId;
  bool isAddedToCart;
  String? title;
  String? subTitle;
  String? kgkCollectionName;
  String? businessCategoryName;
  String? gms;
  String? cts;
  List<String>? colorsCode;
  List<ComponentDetail>? componentDetails;
  String? certificate;
  String? depth;
  String? table;
  String? polish;
  String? symmetry;
  String? pavAngle;
  String? starLength;
  String? girdlePercentage;
  String? pavDepth;
  String? lowerHalf;
  String? carat;

  ProductDetailsModel({
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
    this.reviewCount,
    this.rating,
    this.brandName,
    this.commodity,
    this.isFavourite = false,
    this.wishlistId,
    this.isForAuction = false,
    this.isCommentVisible = false,
    this.auctionId,
    this.isAddedToCart = false,
    this.title,
    this.subTitle,
    this.gms,
    this.kgkCollectionName,
    this.businessCategoryName,
    this.cts,
    this.colorsCode,
    this.componentDetails,
    this.certificate,
    this.depth,
    this.table,
    this.polish,
    this.symmetry,
    this.pavAngle,
    this.starLength,
    this.girdlePercentage,
    this.pavDepth,
    this.lowerHalf,
    this.carat,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsModel &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          name == other.name &&
          offerPrice == other.offerPrice &&
          originalPrice == other.originalPrice &&
          imageUrl == other.imageUrl &&
          discountPercentage == other.discountPercentage &&
          gram == other.gram &&
          diamond == other.diamond &&
          productQuality == other.productQuality &&
          productQuantity == other.productQuantity &&
          cartProductQuality == other.cartProductQuality &&
          cartProductQuantity == other.cartProductQuantity &&
          isSelectedProduct == other.isSelectedProduct &&
          isDiamondProduct == other.isDiamondProduct &&
          diamondClarityChart == other.diamondClarityChart &&
          productInfoClarityChat == other.productInfoClarityChat &&
          isOutOfStock == other.isOutOfStock &&
          company == other.company &&
          productSku == other.productSku &&
          showMore == other.showMore &&
          ctsOrGms == other.ctsOrGms &&
          rappaportPrice == other.rappaportPrice &&
          priceCts == other.priceCts &&
          discountPrice == other.discountPrice &&
          finalPrice == other.finalPrice &&
          lotCode == other.lotCode &&
          shape == other.shape &&
          fluorescence == other.fluorescence &&
          labs == other.labs &&
          lsp == other.lsp &&
          color == other.color &&
          clarity == other.clarity &&
          cut == other.cut &&
          certificateFile == other.certificateFile &&
          openDnaUrl == other.openDnaUrl &&
          reviewCount == other.reviewCount &&
          rating == other.rating &&
          brandName == other.brandName &&
          commodity == other.commodity &&
          isFavourite == other.isFavourite &&
          wishlistId == other.wishlistId &&
          isForAuction == other.isForAuction &&
          isCommentVisible == other.isCommentVisible &&
          auctionId == other.auctionId &&
          isAddedToCart == other.isAddedToCart &&
          title == other.title &&
          subTitle == other.subTitle &&
          gms == other.gms &&
          kgkCollectionName == other.kgkCollectionName &&
          businessCategoryName == other.businessCategoryName &&
          cts == other.cts &&
          colorsCode == other.colorsCode &&
          componentDetails == other.componentDetails &&
          certificate == other.certificate &&
          depth == other.depth &&
          table == other.table &&
          polish == other.polish &&
          symmetry == other.symmetry &&
          pavAngle == other.pavAngle &&
          starLength == other.starLength &&
          girdlePercentage == other.girdlePercentage &&
          pavDepth == other.pavDepth &&
          lowerHalf == other.lowerHalf &&
          carat == other.carat;

  @override
  int get hashCode =>
      productId.hashCode ^
      name.hashCode ^
      offerPrice.hashCode ^
      originalPrice.hashCode ^
      imageUrl.hashCode ^
      discountPercentage.hashCode ^
      gram.hashCode ^
      diamond.hashCode ^
      productQuality.hashCode ^
      productQuantity.hashCode ^
      cartProductQuality.hashCode ^
      cartProductQuantity.hashCode ^
      isSelectedProduct.hashCode ^
      isDiamondProduct.hashCode ^
      diamondClarityChart.hashCode ^
      productInfoClarityChat.hashCode ^
      isOutOfStock.hashCode ^
      company.hashCode ^
      productSku.hashCode ^
      showMore.hashCode ^
      ctsOrGms.hashCode ^
      rappaportPrice.hashCode ^
      priceCts.hashCode ^
      discountPrice.hashCode ^
      finalPrice.hashCode ^
      lotCode.hashCode ^
      shape.hashCode ^
      fluorescence.hashCode ^
      labs.hashCode ^
      lsp.hashCode ^
      color.hashCode ^
      clarity.hashCode ^
      cut.hashCode ^
      certificateFile.hashCode ^
      openDnaUrl.hashCode ^
      reviewCount.hashCode ^
      rating.hashCode ^
      brandName.hashCode ^
      commodity.hashCode ^
      isFavourite.hashCode ^
      wishlistId.hashCode ^
      isForAuction.hashCode ^
      isCommentVisible.hashCode ^
      auctionId.hashCode ^
      isAddedToCart.hashCode ^
      title.hashCode ^
      subTitle.hashCode ^
      gms.hashCode ^
      kgkCollectionName.hashCode ^
      businessCategoryName.hashCode ^
      cts.hashCode ^
      colorsCode.hashCode ^
      componentDetails.hashCode ^
      certificate.hashCode ^
      depth.hashCode ^
      table.hashCode ^
      polish.hashCode ^
      symmetry.hashCode ^
      pavAngle.hashCode ^
      starLength.hashCode ^
      girdlePercentage.hashCode ^
      pavDepth.hashCode ^
      lowerHalf.hashCode ^
      carat.hashCode;
}

extension ProductDetailsExtension on ProductDetailsModel {
  String get displayPrice => offerPrice ?? originalPrice ?? '';

  Color get getCatalogueBadgeColor {
    if (colorsCode.isNullOrEmpty) return Colors.transparent;
    for (String color in (colorsCode ?? [])) {
      if (color.isNotEmpty && color.startsWith('#')) {
        return _convertToColor(color);
      }
    }
    return Colors.transparent;
  }

  Color _convertToColor(String color) {
    String hexColor = color.replaceAll('#', '');
    return Color(int.parse('0xFF$hexColor'));
  }
}
