import 'dart:ui';

class ChartDataModel {
  ChartDataModel(this.x, this.y, {required this.cutModel, required this.clarityModel, required this.colorModel});

  final double x; // This should be non-nullable
  final double? y;
  Offset? offset;
  CutModel cutModel;
  ClarityModel clarityModel;
  ColorModel colorModel;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChartDataModel &&
        other.x == x &&
        other.y == y &&
        other.offset == offset &&
        other.cutModel == cutModel &&
        other.clarityModel == clarityModel &&
        other.colorModel == colorModel;
  }

  @override
  int get hashCode {
    return x.hashCode ^ y.hashCode ^ offset.hashCode ^ cutModel.hashCode ^ clarityModel.hashCode ^ colorModel.hashCode;
  }
}

class ClarityModel {
  int id;
  String name;
  String description;

  ClarityModel({required this.id, required this.name, required this.description});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClarityModel && other.name == name && other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode;
  }
}

class ColorModel {
  int id;
  String name;
  String description;

  ColorModel({required this.id, required this.name, required this.description});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorModel && other.id == id && other.name == name && other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode;
  }
}

class CutModel {
  int id;
  String name;
  String description;

  CutModel({required this.id, required this.name, required this.description});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CutModel && other.id == id && other.name == name && other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode;
  }
}
