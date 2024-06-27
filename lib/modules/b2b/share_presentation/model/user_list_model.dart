import 'package:kgk/kgk.dart';

class UserListModel {
  String? image;
  String? name;
  String? email;
  UserRole? role;

  UserListModel({
    this.image,
    this.name,
    this.email,
    this.role,
  });

  @override
  bool operator ==(Object other) {
    return other is UserListModel && other.image == image && other.name == name && other.email == email && other.role == role;
  }

  @override
  int get hashCode => image.hashCode ^ name.hashCode ^ email.hashCode ^ role.hashCode;
}

class UserRole {
  String? roleName;
  bool isModifiable;

  UserRole({
    this.roleName,
    this.isModifiable = true,
  });

  @override
  bool operator ==(Object other) {
    return other is UserRole && other.roleName == roleName && other.isModifiable == isModifiable;
  }

  @override
  int get hashCode => roleName.hashCode ^ isModifiable.hashCode;
}
