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
    required this.isVerified,
  });

  final String? accessToken;
  final String? userId;
  final UserPermissions? userPermissions;
  final Role? role;
  final String? bagId;
  final String? defaultCscCode;
  final UserIdDetails? userIdDetails;
  final bool? isVerified;

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
      isVerified: json["isVerified"],
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
        "isVerified": isVerified,
      };

  @override
  String toString() {
    return "$accessToken, $userId, $userPermissions, $role, $userIdDetails, $bagId, $defaultCscCode, $isVerified";
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
    required this.accountType,
    required this.profilePicUrl,
    required this.phoneCode,
    required this.phone,
    required this.organisationName,
    this.customerAliasName,
    this.customerCode,
  });

  final String? firstname;
  final String? lastname;
  final String? profilePic;
  final String? userAccountId;
  final String? email;
  final String? userType;
  final String? accountType;
  final String? profilePicUrl;
  String? phoneCode;
  String? phone;
  String? organisationName;
  String? customerAliasName;
  String? customerCode;

  factory UserIdDetails.fromJson(Map<String, dynamic> json) {
    return UserIdDetails(
      firstname: json["firstname"],
      lastname: json["lastname"],
      profilePic: json["profile_pic"],
      userAccountId: json["user_account_id"]?.toString(),
      email: json["email"],
      userType: json["user_type"],
      profilePicUrl: json["profile_pic_url"],
      phoneCode: json["phone_code"],
      phone: json["phone"],
      organisationName: json["org_name"],
      accountType: json["account_type"],
      customerAliasName: json["customer_alias_name"],
      customerCode: json["customer_code"],
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
        "phone_code": phoneCode,
        "phone": phone,
        "org_name": organisationName,
        "account_type": accountType,
        "customer_alias_name": customerAliasName,
        "customer_code": customerCode,
      };

  @override
  String toString() {
    return "$firstname, $lastname, $profilePic, $userAccountId, $email, $userType, $profilePicUrl, $phoneCode, $phone, $organisationName, $accountType, $customerAliasName, $customerCode, ";
  }
}

extension UserIdDetailsExtension on UserIdDetails {
  String get fullName {
    final nameParts = [firstname, lastname];

    return nameParts.where((part) => part.isNotNullNorEmpty).join(" ");
  }

  String get phoneNumber {
    final String? validPhoneCode = phoneCode?.trim().isNotEmpty == true ? phoneCode : "";
    final String? validPhone = phone?.trim().isNotEmpty == true ? phone : "";

    if (validPhoneCode.isNullOrEmpty && validPhone.isNullOrEmpty) {
      return "-";
    } else {
      return "$validPhoneCode $validPhone";
    }
  }

  String get orgName => organisationName ?? "-";

  UserType get userTypeEnum {
    switch (userType) {
      case "customer":
        return UserType.values.firstWhereOrNull((element) => element.value == accountType) ?? UserType.b2cUser;
      case "internal":
        return UserType.internal;
      default:
        return UserType.b2cUser;
    }
  }
}

class UserPermissions {
  const UserPermissions({
    required this.id,
    required this.userId,
    required this.permissions,
    required this.jewellery,
    required this.gemstone,
    required this.diamond,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final int? userId;
  final Permissions? permissions;
  final Diamond? jewellery;
  final Diamond? gemstone;
  final Diamond? diamond;
  final bool? deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory UserPermissions.fromJson(Map<String, dynamic> json) {
    return UserPermissions(
      id: json["_id"],
      userId: json["user_id"],
      permissions: json["permissions"] == null ? null : Permissions.fromJson(json["permissions"]),
      jewellery: json["jewellery"] == null ? null : Diamond.fromJson(json["jewellery"]),
      gemstone: json["gemstone"] == null ? null : Diamond.fromJson(json["gemstone"]),
      diamond: json["diamond"] == null ? null : Diamond.fromJson(json["diamond"]),
      deleted: json["deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "permissions": permissions?.toJson(),
        "jewellery": jewellery?.toJson(),
        "gemstone": gemstone?.toJson(),
        "diamond": diamond?.toJson(),
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
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

class Permissions {
  const Permissions({
    this.activityLogs,
    this.exhibitions,
    this.assetMgmt,
    this.reviewFeedbacks,
    this.digitalCatalogue,
    this.calendars,
    this.messages,
    this.cmsPageBuilder,
    this.companies,
    this.currency,
    this.leads,
    this.request,
    this.department,
    this.systemTemplates,
    this.diamondCategories,
    this.jewelleryCategories,
    this.gemstoneCategories,
    this.paymentTerms,
    this.filterOptions,
    this.diamondShapes,
    this.diamondColors,
    this.jewelleryMetalColors,
    this.faqs,
    this.tasks,
    this.meetings,
    this.inquiries,
    this.language,
    this.auctions,
    this.orders,
    this.newsletterSubscribers,
    this.internalNoteTypes,
    this.projects,
    this.designs,
    this.styles,
    this.concepts,
    this.presentations,
    this.retailerStores,
    this.roles,
    this.deals,
    this.customerGroups,
    this.users,
    this.orion,
    this.cadLibrary,
    this.designLibrary,
    this.finishedGoodLibrary,
    this.skuLibrary,
    this.styleLibrary,
    this.watchlist,
    this.wishlist,
    this.gemstoneShapes,
  });

  final PermissionData? activityLogs;
  final PermissionData? exhibitions;
  final PermissionData? assetMgmt;
  final PermissionData? reviewFeedbacks;
  final PermissionData? digitalCatalogue;
  final PermissionData? calendars;
  final PermissionData? messages;
  final CmsPageBuilder? cmsPageBuilder;
  final PermissionData? companies;
  final PermissionData? currency;
  final PermissionData? leads;
  final PermissionData? request;
  final PermissionData? department;
  final PermissionData? systemTemplates;
  final PermissionData? diamondCategories;
  final PermissionData? jewelleryCategories;
  final PermissionData? gemstoneCategories;
  final PermissionData? paymentTerms;
  final PermissionData? filterOptions;
  final PermissionData? diamondShapes;
  final PermissionData? diamondColors;
  final PermissionData? jewelleryMetalColors;
  final CmsPageBuilder? faqs;
  final PermissionData? tasks;
  final PermissionData? meetings;
  final PermissionData? inquiries;
  final PermissionData? language;
  final PermissionData? auctions;
  final PermissionData? orders;
  final PermissionData? newsletterSubscribers;
  final PermissionData? internalNoteTypes;
  final PermissionData? projects;
  final PermissionData? designs;
  final PermissionData? styles;
  final PermissionData? concepts;
  final PermissionData? presentations;
  final PermissionData? retailerStores;
  final PermissionData? roles;
  final PermissionData? deals;
  final PermissionData? customerGroups;
  final PermissionData? users;
  final Orion? orion;
  final PermissionData? cadLibrary;
  final PermissionData? designLibrary;
  final PermissionData? finishedGoodLibrary;
  final PermissionData? skuLibrary;
  final PermissionData? styleLibrary;
  final PermissionData? watchlist;
  final PermissionData? wishlist;
  final PermissionData? gemstoneShapes;

  factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
      activityLogs: json["activity_logs"] == null ? null : PermissionData.fromJson(json["activity_logs"]),
      exhibitions: json["exhibitions"] == null ? null : PermissionData.fromJson(json["exhibitions"]),
      assetMgmt: json["asset_mgmt"] == null ? null : PermissionData.fromJson(json["asset_mgmt"]),
      reviewFeedbacks: json["review_feedbacks"] == null ? null : PermissionData.fromJson(json["review_feedbacks"]),
      digitalCatalogue: json["digital_catalogue"] == null ? null : PermissionData.fromJson(json["digital_catalogue"]),
      calendars: json["calendars"] == null ? null : PermissionData.fromJson(json["calendars"]),
      messages: json["messages"] == null ? null : PermissionData.fromJson(json["messages"]),
      cmsPageBuilder: json["cms_page_builder"] == null ? null : CmsPageBuilder.fromJson(json["cms_page_builder"]),
      companies: json["companies"] == null ? null : PermissionData.fromJson(json["companies"]),
      currency: json["currency"] == null ? null : PermissionData.fromJson(json["currency"]),
      leads: json["leads"] == null ? null : PermissionData.fromJson(json["leads"]),
      request: json["request"] == null ? null : PermissionData.fromJson(json["request"]),
      department: json["department"] == null ? null : PermissionData.fromJson(json["department"]),
      systemTemplates: json["system_templates"] == null ? null : PermissionData.fromJson(json["system_templates"]),
      diamondCategories: json["diamond_categories"] == null ? null : PermissionData.fromJson(json["diamond_categories"]),
      jewelleryCategories: json["jewellery_categories"] == null ? null : PermissionData.fromJson(json["jewellery_categories"]),
      gemstoneCategories: json["gemstone_categories"] == null ? null : PermissionData.fromJson(json["gemstone_categories"]),
      paymentTerms: json["payment_terms"] == null ? null : PermissionData.fromJson(json["payment_terms"]),
      filterOptions: json["filter_options"] == null ? null : PermissionData.fromJson(json["filter_options"]),
      diamondShapes: json["diamond_shapes"] == null ? null : PermissionData.fromJson(json["diamond_shapes"]),
      diamondColors: json["diamond_colors"] == null ? null : PermissionData.fromJson(json["diamond_colors"]),
      jewelleryMetalColors: json["jewellery_metal_colors"] == null ? null : PermissionData.fromJson(json["jewellery_metal_colors"]),
      faqs: json["faqs"] == null ? null : CmsPageBuilder.fromJson(json["faqs"]),
      tasks: json["tasks"] == null ? null : PermissionData.fromJson(json["tasks"]),
      meetings: json["meetings"] == null ? null : PermissionData.fromJson(json["meetings"]),
      inquiries: json["inquiries"] == null ? null : PermissionData.fromJson(json["inquiries"]),
      language: json["language"] == null ? null : PermissionData.fromJson(json["language"]),
      auctions: json["auctions"] == null ? null : PermissionData.fromJson(json["auctions"]),
      orders: json["orders"] == null ? null : PermissionData.fromJson(json["orders"]),
      newsletterSubscribers: json["newsletter_subscribers"] == null ? null : PermissionData.fromJson(json["newsletter_subscribers"]),
      internalNoteTypes: json["internal_note_types"] == null ? null : PermissionData.fromJson(json["internal_note_types"]),
      projects: json["projects"] == null ? null : PermissionData.fromJson(json["projects"]),
      designs: json["designs"] == null ? null : PermissionData.fromJson(json["designs"]),
      styles: json["styles"] == null ? null : PermissionData.fromJson(json["styles"]),
      concepts: json["concepts"] == null ? null : PermissionData.fromJson(json["concepts"]),
      presentations: json["presentations"] == null ? null : PermissionData.fromJson(json["presentations"]),
      retailerStores: json["retailer_stores"] == null ? null : PermissionData.fromJson(json["retailer_stores"]),
      roles: json["roles"] == null ? null : PermissionData.fromJson(json["roles"]),
      deals: json["deals"] == null ? null : PermissionData.fromJson(json["deals"]),
      customerGroups: json["customer_groups"] == null ? null : PermissionData.fromJson(json["customer_groups"]),
      users: json["users"] == null ? null : PermissionData.fromJson(json["users"]),
      orion: json["orion"] == null ? null : Orion.fromJson(json["orion"]),
      cadLibrary: json["cad_library"] == null ? null : PermissionData.fromJson(json["cad_library"]),
      designLibrary: json["design_library"] == null ? null : PermissionData.fromJson(json["design_library"]),
      finishedGoodLibrary: json["finished_good_library"] == null ? null : PermissionData.fromJson(json["finished_good_library"]),
      skuLibrary: json["sku_library"] == null ? null : PermissionData.fromJson(json["sku_library"]),
      styleLibrary: json["style_library"] == null ? null : PermissionData.fromJson(json["style_library"]),
      watchlist: json["watchlist"] == null ? null : PermissionData.fromJson(json["watchlist"]),
      wishlist: json["wishlist"] == null ? null : PermissionData.fromJson(json["wishlist"]),
      gemstoneShapes: json["gemstone_shapes"] == null ? null : PermissionData.fromJson(json["gemstone_shapes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "activity_logs": activityLogs?.toJson(),
        "exhibitions": exhibitions?.toJson(),
        "asset_mgmt": assetMgmt?.toJson(),
        "review_feedbacks": reviewFeedbacks?.toJson(),
        "digital_catalogue": digitalCatalogue?.toJson(),
        "calendars": calendars?.toJson(),
        "messages": messages?.toJson(),
        "cms_page_builder": cmsPageBuilder?.toJson(),
        "companies": companies?.toJson(),
        "currency": currency?.toJson(),
        "leads": leads?.toJson(),
        "request": request?.toJson(),
        "department": department?.toJson(),
        "system_templates": systemTemplates?.toJson(),
        "diamond_categories": diamondCategories?.toJson(),
        "jewellery_categories": jewelleryCategories?.toJson(),
        "gemstone_categories": gemstoneCategories?.toJson(),
        "payment_terms": paymentTerms?.toJson(),
        "filter_options": filterOptions?.toJson(),
        "diamond_shapes": diamondShapes?.toJson(),
        "diamond_colors": diamondColors?.toJson(),
        "jewellery_metal_colors": jewelleryMetalColors?.toJson(),
        "faqs": faqs?.toJson(),
        "tasks": tasks?.toJson(),
        "meetings": meetings?.toJson(),
        "inquiries": inquiries?.toJson(),
        "language": language?.toJson(),
        "auctions": auctions?.toJson(),
        "orders": orders?.toJson(),
        "newsletter_subscribers": newsletterSubscribers?.toJson(),
        "internal_note_types": internalNoteTypes?.toJson(),
        "projects": projects?.toJson(),
        "designs": designs?.toJson(),
        "styles": styles?.toJson(),
        "concepts": concepts?.toJson(),
        "presentations": presentations?.toJson(),
        "retailer_stores": retailerStores?.toJson(),
        "roles": roles?.toJson(),
        "deals": deals?.toJson(),
        "customer_groups": customerGroups?.toJson(),
        "users": users?.toJson(),
        "orion": orion?.toJson(),
        "cad_library": cadLibrary?.toJson(),
        "design_library": designLibrary?.toJson(),
        "finished_good_library": finishedGoodLibrary?.toJson(),
        "sku_library": skuLibrary?.toJson(),
        "style_library": styleLibrary?.toJson(),
        "watchlist": watchlist?.toJson(),
        "wishlist": wishlist?.toJson(),
        "gemstone_shapes": gemstoneShapes?.toJson(),
      };
}

class PermissionData {
  const PermissionData({
    required this.list,
    required this.activityLogsExport,
    required this.comment,
    required this.create,
    required this.delete,
    required this.activityLogsImport,
    required this.share,
    required this.update,
    required this.view,
  });

  final Comment? list;
  final Comment? activityLogsExport;
  final Comment? comment;
  final Comment? create;
  final Comment? delete;
  final Comment? activityLogsImport;
  final Comment? share;
  final Comment? update;
  final Comment? view;

  factory PermissionData.fromJson(Map<String, dynamic> json) {
    return PermissionData(
      list: json["list"] == null ? null : Comment.fromJson(json["list"]),
      activityLogsExport: json["export"] == null ? null : Comment.fromJson(json["export"]),
      comment: json["comment"] == null ? null : Comment.fromJson(json["comment"]),
      create: json["create"] == null ? null : Comment.fromJson(json["create"]),
      delete: json["delete"] == null ? null : Comment.fromJson(json["delete"]),
      activityLogsImport: json["import"] == null ? null : Comment.fromJson(json["import"]),
      share: json["share"] == null ? null : Comment.fromJson(json["share"]),
      update: json["update"] == null ? null : Comment.fromJson(json["update"]),
      view: json["view"] == null ? null : Comment.fromJson(json["view"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "list": list?.toJson(),
        "export": activityLogsExport?.toJson(),
        "comment": comment?.toJson(),
        "create": create?.toJson(),
        "delete": delete?.toJson(),
        "import": activityLogsImport?.toJson(),
        "share": share?.toJson(),
        "update": update?.toJson(),
        "view": view?.toJson(),
      };
}

class CmsPageBuilder extends Equatable {
  const CmsPageBuilder({
    required this.create,
    required this.delete,
    required this.list,
    required this.update,
    required this.share,
  });

  final Comment? create;
  final Comment? delete;
  final Comment? list;
  final Comment? update;
  final Comment? share;

  factory CmsPageBuilder.fromJson(Map<String, dynamic> json) {
    return CmsPageBuilder(
      create: json["create"] == null ? null : Comment.fromJson(json["create"]),
      delete: json["delete"] == null ? null : Comment.fromJson(json["delete"]),
      list: json["list"] == null ? null : Comment.fromJson(json["list"]),
      update: json["update"] == null ? null : Comment.fromJson(json["update"]),
      share: json["share"] == null ? null : Comment.fromJson(json["share"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "create": create?.toJson(),
        "delete": delete?.toJson(),
        "list": list?.toJson(),
        "update": update?.toJson(),
        "share": share?.toJson(),
      };

  @override
  List<Object?> get props => [
        create,
        delete,
        list,
        update,
        share,
      ];
}

class Orion extends Equatable {
  const Orion({
    required this.view,
  });

  final Comment? view;

  factory Orion.fromJson(Map<String, dynamic> json) {
    return Orion(
      view: json["view"] == null ? null : Comment.fromJson(json["view"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "view": view?.toJson(),
      };

  @override
  List<Object?> get props => [
        view,
      ];
}
