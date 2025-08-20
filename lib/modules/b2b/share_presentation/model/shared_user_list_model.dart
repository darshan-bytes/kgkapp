import 'package:kgk/kgk.dart';

class PresentationSharedUserData {
  PresentationSharedUserData({required this.accessType, required this.userId, required this.userIdDetails});

  final String? accessType;
  final String? userId;
  final UserIdDetails? userIdDetails;

  factory PresentationSharedUserData.fromJson(Map<String, dynamic> json) {
    return PresentationSharedUserData(
      accessType: json["access_type"],
      userId: json["user_id"]?.toString(),
      userIdDetails: json["user_id_details"] == null ? null : UserIdDetails.fromJson(json["user_id_details"]),
    );
  }

  Map<String, dynamic> toJson() => {"access_type": accessType, "user_id": userId, "user_id_details": userIdDetails?.toJson()};

  String? get image => userIdDetails?.profilePicUrl?.setMediaUrl;

  String? get name => userIdDetails?.fullName;

  String? get email => userIdDetails?.email;

  bool get isModifiable => accessType?.toLowerCase() != 'owner';
}

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
  String? accessType;
  String? code;
  bool isRemove;

  UserAccessType({this.accessType, this.code, this.isRemove = false});

  @override
  bool operator ==(Object other) {
    return other is UserAccessType && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}
