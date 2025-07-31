import 'package:kgk/kgk.dart';

class JewelleryListingModel {
  JewelleryListingModel({this.data = const [], this.filteredRecords, this.totalRecords});

  List<JewelleryDataModel> data;
  int? filteredRecords;
  int? totalRecords;

  factory JewelleryListingModel.fromJson(Map<String, dynamic> json) {
    return JewelleryListingModel(
      data: json["data"] == null ? [] : List<JewelleryDataModel>.from(json["data"]?.map((x) => JewelleryDataModel.fromJson(x))),
      filteredRecords: json["filteredRecords"],
      totalRecords: json["totalRecords"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
    "filteredRecords": filteredRecords,
    "totalRecords": totalRecords,
  };

  @override
  String toString() {
    return "$data, $filteredRecords, $totalRecords, ";
  }
}

class JewelleryDataModel {
  JewelleryDataModel({
    this.components = const [],
    this.exclusive,
    this.id,
    this.productDescription,

    this.newArrival,
    this.bestSeller,

    this.contractNoSkuNo,

    this.guestUser,
    this.brandName,
    this.productName,
    this.multipleFinishedViewImage = const [],
    this.suid,
    this.jewelleryType,
    this.kgkCollection,
    this.crt,
    this.gms,
    this.rating,
    this.reviewCount,
    this.metalColor1HexCode,
    this.metalColor2HexCode,
    this.metalColor3HexCode,
    this.discountPercentage,
    this.businessCategoryName,
    this.finalPrice,
    this.discountPrice,
    this.isFavorite = false,
    this.wishlistID,
    this.isAddedToCart = false,
    this.kgkCoutureImage,
    this.isCommented = false,
    this.inHouse,
    this.leavingSoon,
    this.specialOffer,
    this.trending,
    this.customizationSuid,
  });

  String? id;
  String? productDescription;
  String? exclusive;
  String? newArrival;
  String? bestSeller;
  String? contractNoSkuNo;
  String? guestUser;
  String? brandName;
  String? productName;
  List<MultipleFinishedViewImage> multipleFinishedViewImage;
  String? suid;
  String? jewelleryType;
  String? kgkCollection;
  String? crt;
  String? gms;
  double? rating;
  int? reviewCount;
  String? metalColor1HexCode;
  String? metalColor2HexCode;
  String? metalColor3HexCode;
  double? discountPercentage;
  String? businessCategoryName;
  String? finalPrice;
  String? discountPrice;
  bool isFavorite;
  String? wishlistID;
  List<Component> components;
  bool isAddedToCart;
  String? kgkCoutureImage;
  bool isCommented;
  String? inHouse;
  String? leavingSoon;
  String? specialOffer;
  String? trending;
  String? customizationSuid;

  factory JewelleryDataModel.fromJson(Map<String, dynamic> json) {
    return JewelleryDataModel(
      exclusive: json["exclusive"]?.toString(),
      id: json["id"] ?? json["_id"]?.toString(),
      productDescription: json["product_description"]?.toString(),

      newArrival: json["new_arrival"]?.toString(),
      bestSeller: json["best_seller"]?.toString(),
      contractNoSkuNo: json["contract_no_sku_no"]?.toString(),
      guestUser: json["guest_user"]?.toString(),
      brandName: json["brand_name"]?.toString(),
      productName: json["product_name"]?.toString(),
      multipleFinishedViewImage:
          (json["multiple_finished_view_image"] == null || json["multiple_finished_view_image"].runtimeType == String)
              ? []
              : List<MultipleFinishedViewImage>.from(
                json["multiple_finished_view_image"]!.map((x) => MultipleFinishedViewImage.fromJson(x)),
              ),
      kgkCoutureImage:
          (json["multiple_finished_view_image"] is List && json["multiple_finished_view_image"].isNotEmpty)
              ? json["multiple_finished_view_image"].first.toString()
              : null,
      suid: json["suid"]?.toString(),
      jewelleryType: json["jewellery_type"]?.toString(),
      kgkCollection: json["kgk_collection"]?.toString(),
      crt: json["crt"]?.toString(),
      gms: json["gms"]?.toString(),
      rating: json["rating"]?.toString().toDouble ?? 0.0,
      reviewCount: json["review_count"],
      metalColor1HexCode: json["metal_color_1_hex_code"]?.toString(),
      metalColor2HexCode: json["metal_color_2_hex_code"]?.toString(),
      metalColor3HexCode: json["metal_color_3_hex_code"]?.toString(),
      discountPercentage: json["discount_percentage"]?.toString().toDouble,
      businessCategoryName: json["business_category_name"]?.toString(),
      finalPrice: json["final_price"]?.toString(),
      discountPrice: json["discount_price"]?.toString(),
      isFavorite: (json["is_favorite"] != null && (json["is_favorite"]?.toString() ?? '').isNotEmpty) ? true : false,
      wishlistID: json["is_favorite"]?.toString(),
      components: json["components"] == null ? [] : List<Component>.from(json["components"]!.map((x) => Component.fromJson(x))),
      isAddedToCart: json["isAddedToCart"] ?? false,

      isCommented: json["is_commented"] ?? false,
      inHouse: json["in_house"]?.toString(),
      leavingSoon: json["leaving_soon"]?.toString(),
      specialOffer: json["special_offer"]?.toString(),
      trending: json["trending"]?.toString(),
      customizationSuid: json["customization_suid"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "exclusive": exclusive,
    "id": id,
    "product_description": productDescription,
    "new_arrival": newArrival,
    "best_seller": bestSeller,
    "contract_no_sku_no": contractNoSkuNo,
    "guest_user": guestUser,
    "brand_name": brandName,
    "product_name": productName,
    "multiple_finished_view_image": multipleFinishedViewImage.map((x) => x.toJson()).toList(),
    "suid": suid,
    "jewellery_type": jewelleryType,
    "kgk_collection": kgkCollection,
    "crt": crt,
    "gms": gms,
    "rating": rating,
    "review_count": reviewCount,
    "metal_color_1_hex_code": metalColor1HexCode,
    "metal_color_2_hex_code": metalColor2HexCode,
    "metal_color_3_hex_code": metalColor3HexCode,
    "discount_percentage": discountPercentage,
    "business_category_name": businessCategoryName,
    "final_price": finalPrice,
    "discount_price": discountPrice,
    "isAddedToCart": isAddedToCart,
    "kgk_couture_image": kgkCoutureImage,
    "is_commented": isCommented,
    "in_house": inHouse,
    "leaving_soon": leavingSoon,
    "special_offer": specialOffer,
    "trending": trending,
    "customization_suid": customizationSuid,
  };
}

extension JewelleryListingModelExtension on JewelleryDataModel {
  String? get discountEXT {
    if ((discountPercentage ?? 0) > 0) {
      return APPStrings.percentageOffInterpolating.tr.interpolate([discountPercentage]);
    }
    return null;
  }

  String? get crtEXT {
    final crtValue = double.tryParse(crt ?? '0') ?? 0.0;
    return crtValue > 0 ? crt : null;
  }

  List<String> get imageListEXT {
    final list = <String>[];
    for (var element in multipleFinishedViewImage) {
      if (element.imageAvailable?.toLowerCase() == ApiKey.yes) {
        if (element.imageUrl.isNotNullNorEmpty) {
          list.add(element.imageUrl!);
        }
        for (var e in element.multiAngleUrl) {
          if (e.url.isNotNullNorEmpty) {
            list.add(e.url!);
          }
        }
      }
    }
    return list;
  }
}

class MultipleFinishedViewImage {
  MultipleFinishedViewImage({
    this.imageAvailable,
    this.imageAvailableMa,
    this.imageUrl,
    this.multiAngleUrl = const [],
    this.the3DFile,
    this.videoUrl,
  });

  final String? imageAvailable;
  final String? imageAvailableMa;
  final String? imageUrl;
  final List<MultiAngleUrl> multiAngleUrl;
  final String? the3DFile;
  final String? videoUrl;

  factory MultipleFinishedViewImage.fromJson(Map<String, dynamic> json) {
    return MultipleFinishedViewImage(
      imageAvailable: json["IMAGE_AVAILABLE"],
      imageAvailableMa: json["IMAGE_AVAILABLE_MA"],
      imageUrl: json["IMAGE_URL"],
      multiAngleUrl:
          json["MULTI_ANGLE_URL"] == null ? [] : List<MultiAngleUrl>.from(json["MULTI_ANGLE_URL"]!.map((x) => MultiAngleUrl.fromJson(x))),
      the3DFile: json["3dFile"],
      videoUrl: json["VideoUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "IMAGE_AVAILABLE": imageAvailable,
    "IMAGE_AVAILABLE_MA": imageAvailableMa,
    "IMAGE_URL": imageUrl,
    "MULTI_ANGLE_URL": multiAngleUrl.map((x) => x.toJson()).toList(),
    "3dFile": the3DFile,
    "VideoUrl": videoUrl,
  };
}

class MultiAngleUrl {
  MultiAngleUrl({this.url});

  final String? url;

  factory MultiAngleUrl.fromJson(Map<String, dynamic> json) {
    return MultiAngleUrl(url: json["url"]?.toString());
  }

  Map<String, dynamic> toJson() => {"url": url};
}

class Component extends Equatable {
  const Component({this.title, this.values = const []});

  final String? title;
  final List<List<ValueElement>> values;

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      title: json["title"]?.toString(),
      values:
          json["values"] == null
              ? []
              : List<List<ValueElement>>.from(
                json["values"]!.map((x) => x == null ? [] : List<ValueElement>.from(x!.map((x) => ValueElement.fromJson(x)))),
              ),
    );
  }

  Map<String, dynamic> toJson() => {"title": title, "values": values.map((x) => x.map((x) => x.toJson()).toList()).toList()};

  @override
  List<Object?> get props => [title, values];
}

class ValueElement {
  ValueElement({required this.title, required this.value, required this.subLabel, required this.mobSubLabel});

  final String? title;
  final String? value;
  final String? subLabel;
  final String? mobSubLabel;

  factory ValueElement.fromJson(Map<String, dynamic> json) {
    return ValueElement(
      title: json["title"]?.toString(),
      value: json["value"]?.toString(),
      subLabel: json["sub_label"]?.toString(),
      mobSubLabel: json["mob_sub_label"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {"title": title, "value": value, "sub_label": subLabel, "mob_sub_label": mobSubLabel};
}

class StoneElement {
  const StoneElement({this.title, this.value});

  final String? title;
  final String? value;

  factory StoneElement.fromJson(Map<String, dynamic> json) {
    return StoneElement(title: json["label"]?.toString(), value: json["value"]?.toString());
  }

  Map<String, dynamic> toJson() => {"title": title, "value": value};
}
