import 'package:kgk/kgk.dart';

class OrionDiamondPropertiesDataModel {
  int? id;
  String? title;
  OrionPropertiesDetails? selectedProperties;
  List<OrionPropertiesDetails>? propertiesList;

  OrionDiamondPropertiesDataModel({
    this.id,
    this.title,
    this.selectedProperties,
    this.propertiesList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrionDiamondPropertiesDataModel &&
        other.id == id &&
        other.title == title &&
        other.selectedProperties == selectedProperties &&
        listEquals(other.propertiesList, propertiesList);
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ selectedProperties.hashCode ^ propertiesList.hashCode;
  }
}

class OrionPropertiesDetails {
  int? id;
  String? title;
  String? subTitle;

  OrionPropertiesDetails({
    this.id,
    this.title,
    this.subTitle,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrionPropertiesDetails && other.id == id && other.title == title && other.subTitle == subTitle;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ subTitle.hashCode;
  }
}
