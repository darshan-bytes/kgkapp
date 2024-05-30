import 'package:kgk/kgk.dart';

class ProductCustomizationOptions {
  String? id;
  String? name;
  String? type;
  List<ProductCustomizationOptionValues>? values;
  ProductCustomizationOptionValues? selectedValue;

  ProductCustomizationOptions({this.id, this.name, this.type, this.values, this.selectedValue});

  ProductCustomizationOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    if (json['values'] != null) {
      values = [];
      json['values'].forEach((v) {
        values?.add(ProductCustomizationOptionValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    if (values != null) {
      data['values'] = values?.map((v) => v.toJson()).toList();
    }
    data['selectedValue'] = selectedValue?.toJson();
    return data;
  }
}

extension ProductCustomizationOptionsExtension on ProductCustomizationOptions {
  ProductCustomizationType get productCustomizationType =>
      ProductCustomizationType.values.firstWhereOrNull((element) => element.value == type) ?? ProductCustomizationType.other;
}

class ProductCustomizationOptionValues {
  String? id;
  String? value;
  String? image;

  ProductCustomizationOptionValues({
    this.id,
    this.value,
    this.image,
  });

  ProductCustomizationOptionValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['image'] = image;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductCustomizationOptionValues && other.id == id && other.value == value && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ image.hashCode;
}
