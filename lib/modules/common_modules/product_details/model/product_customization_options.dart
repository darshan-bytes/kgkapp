import 'package:kgk/kgk.dart';

class ProductCustomizationOptions {
  String? id;
  String? name;
  String? type;
  List<ProductCustomizationOptionValues>? values;
  ProductCustomizationOptionValues? selectedValue;

  ProductCustomizationOptions({
    this.id,
    this.name,
    this.type,
    this.values,
    this.selectedValue,
  });
}

extension ProductCustomizationOptionsExtension on ProductCustomizationOptions {
  ProductCustomizationType get productCustomizationType =>
      ProductCustomizationType.values.firstWhereOrNull((element) => element.value == type) ?? ProductCustomizationType.other;
}

class ProductCustomizationOptionValues {
  String? id;
  String? value;
  String? shapeCode;
  String? image;
  int availableProductCount;

  ProductCustomizationOptionValues({
    this.id,
    this.value,
    this.shapeCode,
    this.image,
    this.availableProductCount = 0,
  });

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
