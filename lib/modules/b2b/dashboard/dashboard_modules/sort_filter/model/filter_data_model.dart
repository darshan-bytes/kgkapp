import 'package:kgk/kgk.dart';

class FilterData {
  String? name;
  String? code;
  List<SecondaryFilterData>? secondaryFilterData;
  bool? isAdvanceFilter;

  FilterData({
    this.name,
    this.code,
    this.secondaryFilterData,
    this.isAdvanceFilter,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterData && other.name == name && other.code == code && other.secondaryFilterData == secondaryFilterData;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ secondaryFilterData.hashCode;
}

class SecondaryFilterData {
  String? name;
  String? code;
  String? image;
  bool isSelected;

  SecondaryFilterData({
    this.name,
    this.code,
    this.image,
    this.isSelected = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SecondaryFilterData &&
        other.name == name &&
        other.code == code &&
        other.image == image &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ image.hashCode ^ isSelected.hashCode;
}
