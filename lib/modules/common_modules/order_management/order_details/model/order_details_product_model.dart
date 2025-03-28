import 'package:kgk/kgk.dart';

class OrderDetailsProductModel {
  String? id;
  String? name;
  String? price;
  String? quantity;
  String? image;
  String? sku;
  String? status;
  String? brand;
  String? deliveryDate;
  String? suid;

  OrderDetailsProductModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.image,
    this.sku,
    this.status,
    this.brand,
    this.deliveryDate,
    this.suid,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetailsProductModel &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.quantity == quantity &&
        other.image == image &&
        other.sku == sku &&
        other.status == status &&
        other.brand == brand &&
        other.deliveryDate == deliveryDate &&
        other.suid == suid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        image.hashCode ^
        sku.hashCode ^
        status.hashCode ^
        brand.hashCode ^
        deliveryDate.hashCode ^
        suid.hashCode;
  }
}

extension OrderDetailsProductModelExtension on OrderDetailsProductModel {
  ProjectStatus get orderStatus =>
      ProjectStatus.values.firstWhereOrNull((element) => element.value == status) ?? ProjectStatus.orangeInProgress;
}
