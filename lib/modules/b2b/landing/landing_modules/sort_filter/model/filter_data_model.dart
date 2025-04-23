import 'package:kgk/kgk.dart';

class FilterData {
  String? name;
  String? code;
  List<SecondaryFilterData>? secondaryFilterData;
  bool? isAdvanceFilter;
  String? inputType;
  FilterType? filterType;
  String? subFilterCodes;
  SfRangeValues? rangeValues;
  SfRangeValues? minMaxValues;
  DateTimeRange? dateRange;

  FilterData({
    this.name,
    this.code,
    this.secondaryFilterData,
    this.isAdvanceFilter,
    this.inputType,
    this.filterType,
    this.subFilterCodes,
    this.rangeValues,
    this.minMaxValues,
    this.dateRange,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterData &&
        other.name == name &&
        other.code == code &&
        other.secondaryFilterData == secondaryFilterData &&
        other.isAdvanceFilter == isAdvanceFilter &&
        other.inputType == inputType &&
        other.filterType == filterType &&
        other.subFilterCodes == subFilterCodes &&
        other.rangeValues == rangeValues &&
        other.minMaxValues == minMaxValues &&
        other.dateRange == dateRange;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      code.hashCode ^
      secondaryFilterData.hashCode ^
      isAdvanceFilter.hashCode ^
      inputType.hashCode ^
      filterType.hashCode ^
      subFilterCodes.hashCode ^
      rangeValues.hashCode ^
      minMaxValues.hashCode;
}

extension FilterDataExtension on FilterData {
  FilterType getFilterType({String? filterType}) {
    switch (filterType) {
      case "dropdown":
        return FilterType.checkbox;
      case "range":
        return FilterType.range;
      case "date":
        return FilterType.date;
      case "date_range":
        return FilterType.dateRange;
      case "created_by_search":
        return FilterType.checkbox;
      default:
        return FilterType.undefined;
    }
  }
}

class SecondaryFilterData {
  String? name;
  String? code;
  String? image;
  bool isSelected;

  SecondaryFilterData({this.name, this.code, this.image, this.isSelected = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SecondaryFilterData && other.name == name && other.code == code && other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'SecondaryFilterData{name: $name, code: $code, image: $image, isSelected: $isSelected}';
  }
}
