import 'package:kgk/kgk.dart';

class FilterData {
  String? name;
  String? code;
  List<SecondaryFilterData>? secondaryFilterData;

  FilterData({
    this.name,
    this.code,
    this.secondaryFilterData,
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
  bool isSelected;

  SecondaryFilterData({
    this.name,
    this.code,
    this.isSelected = false,
  });
}
