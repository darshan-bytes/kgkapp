import 'package:kgk/kgk.dart';

class ProductCustomizationOptionValues {
  String? id;
  String? value;
  String? shapeCode;
  String? image;
  int availableProductCount;

  ProductCustomizationOptionValues({this.id, this.value, this.shapeCode, this.image, this.availableProductCount = 0});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductCustomizationOptionValues &&
        other.id == id &&
        other.value == value &&
        other.shapeCode == shapeCode &&
        other.image == image &&
        other.availableProductCount == availableProductCount;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ shapeCode.hashCode ^ image.hashCode ^ availableProductCount.hashCode;
}

class ProductCustomizeData {
  ProductCustomizeData({this.name, this.price, required this.data, required this.productCustomizeDataDefault, this.applicable = const {}});

  final String? name;
  final String? price;
  final List<ProductCustomizeDataDatum> data;
  final Map<String, dynamic>? productCustomizeDataDefault;
  final Map<String, dynamic> applicable;

  factory ProductCustomizeData.fromJson(Map<String, dynamic> json) {
    return ProductCustomizeData(
      name: json["name"],
      price: json["price"],
      data:
          json["data"] == null ? [] : List<ProductCustomizeDataDatum>.from(json["data"]!.map((x) => ProductCustomizeDataDatum.fromJson(x))),
      productCustomizeDataDefault: json["default"],
      applicable: json["applicable"] ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "data": data.map((x) => x.toJson()).toList(),
    "default": productCustomizeDataDefault,
    "applicable": applicable,
  };
}

class ProductCustomizeDataDatum {
  ProductCustomizeDataDatum({required this.name, required this.slug, required this.data, required this.glbFiles});

  final String? name;
  final String? slug;
  final List<ProductCustomizationOptions> data;
  final List<String> glbFiles;
  ProductCustomizationOptions? selectedValue;

  factory ProductCustomizeDataDatum.fromJson(Map<String, dynamic> json) {
    return ProductCustomizeDataDatum(
      name: json["name"],
      slug: json["slug"],
      data:
          json["data"] == null
              ? []
              : List<ProductCustomizationOptions>.from(json["data"]!.map((x) => ProductCustomizationOptions.fromJson(x))),
      glbFiles: json["glbFiles"] == null ? [] : List<String>.from(json["glbFiles"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "data": data.map((x) => x.toJson()).toList(),
    "glbFiles": glbFiles.map((x) => x).toList(),
  };
}

class ProductCustomizationOptions {
  ProductCustomizationOptions({
    required this.name,
    required this.code,
    required this.icon,
    required this.formatType,
    required this.variants,
    required this.hexCode,
    required this.datumFormatType,
    this.isApplicable = true,
  });

  final String? name;
  final String? code;
  final String? icon;
  final String? formatType;
  final List<Variant> variants;
  final String? hexCode;
  final String? datumFormatType;
  bool isApplicable;

  factory ProductCustomizationOptions.fromJson(Map<String, dynamic> json) {
    return ProductCustomizationOptions(
      name: json["name"],
      code: json["code"],
      icon: json["icon"],
      formatType: json["formatType"],
      variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
      hexCode: json["hex_code"],
      datumFormatType: json["format_type"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "icon": icon,
    "formatType": formatType,
    "variants": variants.map((x) => x.toJson()).toList(),
    "hex_code": hexCode,
    "format_type": datumFormatType,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCustomizationOptions &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code &&
          icon == other.icon &&
          formatType == other.formatType &&
          variants == other.variants &&
          hexCode == other.hexCode &&
          datumFormatType == other.datumFormatType;

  @override
  int get hashCode =>
      name.hashCode ^ code.hashCode ^ icon.hashCode ^ formatType.hashCode ^ variants.hashCode ^ hexCode.hashCode ^ datumFormatType.hashCode;
}

class Variant {
  Variant({required this.name, required this.slug, required this.data, required this.glbFiles});

  final String? name;
  final String? slug;
  final List<VariantDatum> data;
  final List<dynamic> glbFiles;
  VariantDatum? selectedVariantDatum;

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      name: json["name"],
      slug: json["slug"],
      data: json["data"] == null ? [] : List<VariantDatum>.from(json["data"]!.map((x) => VariantDatum.fromJson(x))),
      glbFiles: json["glbFiles"] == null ? [] : List<dynamic>.from(json["glbFiles"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "slug": slug,
    "data": data.map((x) => x.toJson()).toList(),
    "glbFiles": glbFiles.map((x) => x).toList(),
  };
}

class VariantDatum {
  VariantDatum({required this.name, required this.code, required this.icon, required this.formatType, required this.isDefault});

  final String? name;
  final String? code;
  final String? icon;
  final String? formatType;
  final String? isDefault;

  factory VariantDatum.fromJson(Map<String, dynamic> json) {
    return VariantDatum(
      name: json["name"],
      code: json["code"],
      icon: json["icon"],
      formatType: json["formatType"],
      isDefault: json["isDefault"],
    );
  }

  Map<String, dynamic> toJson() => {"name": name, "code": code, "icon": icon, "formatType": formatType, "isDefault": isDefault};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariantDatum &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code &&
          icon == other.icon &&
          formatType == other.formatType;

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ icon.hashCode ^ formatType.hashCode ^ isDefault.hashCode;
}
