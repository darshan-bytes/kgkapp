import 'package:kgk/kgk.dart';

class UserListModel {
  String? image;
  String? name;
  String? email;
  UserRole? role;
  UserAccessType? userAccessType;

  UserListModel({this.image, this.name, this.email, this.role, this.userAccessType});

  @override
  bool operator ==(Object other) {
    return other is UserListModel &&
        other.image == image &&
        other.name == name &&
        other.email == email &&
        other.role == role &&
        other.userAccessType == userAccessType;
  }

  @override
  int get hashCode => image.hashCode ^ name.hashCode ^ email.hashCode ^ role.hashCode ^ userAccessType.hashCode;
}

class UserRole {
  String? roleName;
  bool isModifiable;

  UserRole({this.roleName, this.isModifiable = true});

  @override
  bool operator ==(Object other) {
    return other is UserRole && other.roleName == roleName && other.isModifiable == isModifiable;
  }

  @override
  int get hashCode => roleName.hashCode ^ isModifiable.hashCode;
}

class UserAccessType {
  String? id;
  String? accessType;

  UserAccessType({this.id, this.accessType});

  @override
  bool operator ==(Object other) {
    return other is UserAccessType && other.id == id && other.accessType == accessType;
  }

  @override
  int get hashCode => id.hashCode ^ accessType.hashCode;
}
