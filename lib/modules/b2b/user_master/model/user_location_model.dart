import 'package:kgk/kgk.dart';

class UserLocationModel {
  String? id;
  String? name;

  UserLocationModel({
    this.id,
    this.name,
  });

  @override
  bool operator ==(Object other) {
    return other is UserLocationModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
