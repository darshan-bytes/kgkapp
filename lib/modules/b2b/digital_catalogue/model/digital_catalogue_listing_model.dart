import 'package:kgk/kgk.dart';

class DigitalCatalogueListingModel {
  String? id;
  String? name;
  String? description;
  String? image;
  String? productCount;
  String? date;
  ProjectStatus? status;
  bool isCreatedByMe;

  DigitalCatalogueListingModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.productCount,
    this.date,
    this.status,
    this.isCreatedByMe = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DigitalCatalogueListingModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.productCount == productCount &&
        other.date == date &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ image.hashCode ^ productCount.hashCode ^ date.hashCode ^ status.hashCode;
  }
}
