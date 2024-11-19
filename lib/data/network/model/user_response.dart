import 'package:kgk/kgk.dart';

class UserResponse {
  UserResponse({
    required this.accessToken,
    required this.userId,
    required this.userPermissions,
    required this.role,
    required this.bagId,
    required this.defaultCscCode,
    required this.userIdDetails,
    required this.customerOrganizationId,
  });

  final String? accessToken;
  final String? userId;
  final UserPermissions? userPermissions;
  final Role? role;
  final String? bagId;
  final String? defaultCscCode;
  final UserIdDetails? userIdDetails;

  //customer_organization_id
  final String? customerOrganizationId;

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      accessToken: json["access_token"],
      userId: json["user_id"],
      userPermissions: json["user_permissions"] == null ? null : UserPermissions.fromJson(json["user_permissions"]),
      role: json["role"] == null ? null : Role.fromJson(json["role"]),
      defaultCscCode: json["default_csc_code"],
      userIdDetails: json["user_id_details"] == null ? null : UserIdDetails.fromJson(json["user_id_details"]),
      bagId: json["bag_id"],
      customerOrganizationId: json["customer_organization_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user_id": userId,
        "user_permissions": userPermissions?.toJson(),
        "role": role?.toJson(),
        "default_csc_code": defaultCscCode,
        "user_id_details": userIdDetails?.toJson(),
        "bag_id": bagId,
        "customer_organization_id": customerOrganizationId?.toString(),
      };

  @override
  String toString() {
    return "$accessToken, $userId, $userPermissions, $role, $userIdDetails, $bagId, $defaultCscCode, ";
  }
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.slug,
  });

  final String? id;
  final String? name;
  final String? slug;

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json["id"]?.toString(),
      name: json["name"],
      slug: json["slug"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };

  @override
  String toString() {
    return "$id, $name, $slug, ";
  }
}

class UserIdDetails {
  UserIdDetails({
    required this.firstname,
    required this.lastname,
    required this.profilePic,
    required this.userAccountId,
    required this.email,
    required this.userType,
    required this.profilePicUrl,
  });

  final String? firstname;
  final String? lastname;
  final String? profilePic;
  final String? userAccountId;
  final String? email;
  final String? userType;
  final String? profilePicUrl;

  factory UserIdDetails.fromJson(Map<String, dynamic> json) {
    return UserIdDetails(
      firstname: json["firstname"],
      lastname: json["lastname"],
      profilePic: json["profile_pic"],
      userAccountId: json["user_account_id"]?.toString(),
      email: json["email"],
      userType: json["user_type"],
      profilePicUrl: json["profile_pic_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "profile_pic": profilePic,
        "user_account_id": userAccountId,
        "email": email,
        "user_type": userType,
        "profile_pic_url": profilePicUrl,
      };

  @override
  String toString() {
    return "$firstname, $lastname, $profilePic, $userAccountId, $email, $userType, $profilePicUrl, ";
  }
}

extension UserIdDetailsExtension on UserIdDetails {
  String get fullName => "$firstname $lastname";

  UserType get userTypeEnum => UserType.values.firstWhereOrNull((element) => element.value == userType) ?? UserType.b2cUser;
}

class UserPermissions {
  UserPermissions({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.permissions,
    required this.diamond,
    required this.gemstone,
    required this.jewellery,
    required this.deleted,
    required this.v,
  });

  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userId;
  final Map<String, KGKPermission> permissions;
  final Diamond? diamond;
  final Diamond? gemstone;
  final Diamond? jewellery;
  final bool? deleted;
  final int? v;

  factory UserPermissions.fromJson(Map<String, dynamic> json) {
    return UserPermissions(
      id: json["_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      userId: json["user_id"],
      permissions: json["permissions"] == null
          ? {}
          : Map.from(json["permissions"]).map((k, v) => MapEntry<String, KGKPermission>(k, KGKPermission.fromJson(v))),
      diamond: json["diamond"] == null ? null : Diamond.fromJson(json["diamond"]),
      gemstone: json["gemstone"] == null ? null : Diamond.fromJson(json["gemstone"]),
      jewellery: json["jewellery"] == null ? null : Diamond.fromJson(json["jewellery"]),
      deleted: json["deleted"],
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user_id": userId,
        "permissions": Map.from(permissions).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "diamond": diamond?.toJson(),
        "gemstone": gemstone?.toJson(),
        "jewellery": jewellery?.toJson(),
        "deleted": deleted,
        "__v": v,
      };

  @override
  String toString() {
    return "$id, $createdAt, $updatedAt, $userId, $permissions, $diamond, $gemstone, $jewellery, $deleted, $v, ";
  }
}

class Diamond {
  Diamond({
    required this.createdAt,
    required this.updatedAt,
    required this.restriction,
    required this.visibilityAndSequence,
    required this.id,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> restriction;
  final List<VisibilityAndSequence> visibilityAndSequence;
  final String? id;

  factory Diamond.fromJson(Map<String, dynamic> json) {
    return Diamond(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      restriction: json["restriction"] == null ? [] : List<dynamic>.from(json["restriction"]!.map((x) => x)),
      visibilityAndSequence: json["visibility_and_sequence"] == null
          ? []
          : List<VisibilityAndSequence>.from(json["visibility_and_sequence"]!.map((x) => VisibilityAndSequence.fromJson(x))),
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "restriction": restriction.map((x) => x).toList(),
        "visibility_and_sequence": visibilityAndSequence.map((x) => x.toJson()).toList(),
        "_id": id,
      };

  @override
  String toString() {
    return "$createdAt, $updatedAt, $restriction, $visibilityAndSequence, $id, ";
  }
}

class VisibilityAndSequence {
  VisibilityAndSequence({
    required this.name,
    required this.code,
  });

  final String? name;
  final String? code;

  factory VisibilityAndSequence.fromJson(Map<String, dynamic> json) {
    return VisibilityAndSequence(
      name: json["name"],
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
      };

  @override
  String toString() {
    return "$name, $code, ";
  }
}

class KGKPermission {
  KGKPermission({
    required this.list,
    required this.permissionExport,
    required this.comment,
    required this.create,
    required this.delete,
    required this.permissionImport,
    required this.share,
    required this.update,
    required this.view,
  });

  final Comment? list;
  final Comment? permissionExport;
  final Comment? comment;
  final Comment? create;
  final Comment? delete;
  final Comment? permissionImport;
  final Comment? share;
  final Comment? update;
  final Comment? view;

  factory KGKPermission.fromJson(Map<String, dynamic> json) {
    return KGKPermission(
      list: json["list"] == null ? null : Comment.fromJson(json["list"]),
      permissionExport: json["export"] == null ? null : Comment.fromJson(json["export"]),
      comment: json["comment"] == null ? null : Comment.fromJson(json["comment"]),
      create: json["create"] == null ? null : Comment.fromJson(json["create"]),
      delete: json["delete"] == null ? null : Comment.fromJson(json["delete"]),
      permissionImport: json["import"] == null ? null : Comment.fromJson(json["import"]),
      share: json["share"] == null ? null : Comment.fromJson(json["share"]),
      update: json["update"] == null ? null : Comment.fromJson(json["update"]),
      view: json["view"] == null ? null : Comment.fromJson(json["view"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "list": list?.toJson(),
        "export": permissionExport?.toJson(),
        "comment": comment?.toJson(),
        "create": create?.toJson(),
        "delete": delete?.toJson(),
        "import": permissionImport?.toJson(),
        "share": share?.toJson(),
        "update": update?.toJson(),
        "view": view?.toJson(),
      };

  @override
  String toString() {
    return "$list, $permissionExport, $comment, $create, $delete, $permissionImport, $share, $update, $view, ";
  }
}

class Comment {
  Comment({
    required this.allowed,
  });

  final bool? allowed;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      allowed: json["allowed"],
    );
  }

  Map<String, dynamic> toJson() => {
        "allowed": allowed,
      };

  @override
  String toString() {
    return "$allowed, ";
  }
}
