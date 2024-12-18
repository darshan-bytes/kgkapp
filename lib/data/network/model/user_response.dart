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
    required this.accountType,
    required this.profilePicUrl,
    required this.phoneCode,
    required this.phone,
    required this.organisationName,
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
      };

  @override
  String toString() {
    return "$firstname, $lastname, $profilePic, $userAccountId, $email, $userType, $profilePicUrl, $phoneCode, $phone, $organisationName, $accountType, ";
  }
}

extension UserIdDetailsExtension on UserIdDetails {
  String get fullName => "$firstname $lastname";

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

class UserPermissions extends Equatable {
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

  @override
  List<Object?> get props => [
        id,
        userId,
        permissions,
        jewellery,
        gemstone,
        diamond,
        deleted,
        createdAt,
        updatedAt,
        v,
      ];
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

class Permissions extends Equatable {
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

  final ActivityLogs? activityLogs;
  final ActivityLogs? exhibitions;
  final ActivityLogs? assetMgmt;
  final ActivityLogs? reviewFeedbacks;
  final ActivityLogs? digitalCatalogue;
  final ActivityLogs? calendars;
  final ActivityLogs? messages;
  final CmsPageBuilder? cmsPageBuilder;
  final ActivityLogs? companies;
  final ActivityLogs? currency;
  final ActivityLogs? leads;
  final ActivityLogs? request;
  final ActivityLogs? department;
  final ActivityLogs? systemTemplates;
  final ActivityLogs? diamondCategories;
  final ActivityLogs? jewelleryCategories;
  final ActivityLogs? gemstoneCategories;
  final ActivityLogs? paymentTerms;
  final ActivityLogs? filterOptions;
  final ActivityLogs? diamondShapes;
  final ActivityLogs? diamondColors;
  final ActivityLogs? jewelleryMetalColors;
  final CmsPageBuilder? faqs;
  final ActivityLogs? tasks;
  final ActivityLogs? meetings;
  final ActivityLogs? inquiries;
  final ActivityLogs? language;
  final ActivityLogs? auctions;
  final ActivityLogs? orders;
  final ActivityLogs? newsletterSubscribers;
  final ActivityLogs? internalNoteTypes;
  final ActivityLogs? projects;
  final ActivityLogs? designs;
  final ActivityLogs? styles;
  final ActivityLogs? concepts;
  final ActivityLogs? presentations;
  final ActivityLogs? retailerStores;
  final ActivityLogs? roles;
  final ActivityLogs? deals;
  final ActivityLogs? customerGroups;
  final ActivityLogs? users;
  final Orion? orion;
  final ActivityLogs? cadLibrary;
  final ActivityLogs? designLibrary;
  final ActivityLogs? finishedGoodLibrary;
  final ActivityLogs? skuLibrary;
  final ActivityLogs? styleLibrary;
  final ActivityLogs? watchlist;
  final ActivityLogs? wishlist;
  final ActivityLogs? gemstoneShapes;

  factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
      activityLogs: json["activity_logs"] == null ? null : ActivityLogs.fromJson(json["activity_logs"]),
      exhibitions: json["exhibitions"] == null ? null : ActivityLogs.fromJson(json["exhibitions"]),
      assetMgmt: json["asset_mgmt"] == null ? null : ActivityLogs.fromJson(json["asset_mgmt"]),
      reviewFeedbacks: json["review_feedbacks"] == null ? null : ActivityLogs.fromJson(json["review_feedbacks"]),
      digitalCatalogue: json["digital_catalogue"] == null ? null : ActivityLogs.fromJson(json["digital_catalogue"]),
      calendars: json["calendars"] == null ? null : ActivityLogs.fromJson(json["calendars"]),
      messages: json["messages"] == null ? null : ActivityLogs.fromJson(json["messages"]),
      cmsPageBuilder: json["cms_page_builder"] == null ? null : CmsPageBuilder.fromJson(json["cms_page_builder"]),
      companies: json["companies"] == null ? null : ActivityLogs.fromJson(json["companies"]),
      currency: json["currency"] == null ? null : ActivityLogs.fromJson(json["currency"]),
      leads: json["leads"] == null ? null : ActivityLogs.fromJson(json["leads"]),
      request: json["request"] == null ? null : ActivityLogs.fromJson(json["request"]),
      department: json["department"] == null ? null : ActivityLogs.fromJson(json["department"]),
      systemTemplates: json["system_templates"] == null ? null : ActivityLogs.fromJson(json["system_templates"]),
      diamondCategories: json["diamond_categories"] == null ? null : ActivityLogs.fromJson(json["diamond_categories"]),
      jewelleryCategories: json["jewellery_categories"] == null ? null : ActivityLogs.fromJson(json["jewellery_categories"]),
      gemstoneCategories: json["gemstone_categories"] == null ? null : ActivityLogs.fromJson(json["gemstone_categories"]),
      paymentTerms: json["payment_terms"] == null ? null : ActivityLogs.fromJson(json["payment_terms"]),
      filterOptions: json["filter_options"] == null ? null : ActivityLogs.fromJson(json["filter_options"]),
      diamondShapes: json["diamond_shapes"] == null ? null : ActivityLogs.fromJson(json["diamond_shapes"]),
      diamondColors: json["diamond_colors"] == null ? null : ActivityLogs.fromJson(json["diamond_colors"]),
      jewelleryMetalColors: json["jewellery_metal_colors"] == null ? null : ActivityLogs.fromJson(json["jewellery_metal_colors"]),
      faqs: json["faqs"] == null ? null : CmsPageBuilder.fromJson(json["faqs"]),
      tasks: json["tasks"] == null ? null : ActivityLogs.fromJson(json["tasks"]),
      meetings: json["meetings"] == null ? null : ActivityLogs.fromJson(json["meetings"]),
      inquiries: json["inquiries"] == null ? null : ActivityLogs.fromJson(json["inquiries"]),
      language: json["language"] == null ? null : ActivityLogs.fromJson(json["language"]),
      auctions: json["auctions"] == null ? null : ActivityLogs.fromJson(json["auctions"]),
      orders: json["orders"] == null ? null : ActivityLogs.fromJson(json["orders"]),
      newsletterSubscribers: json["newsletter_subscribers"] == null ? null : ActivityLogs.fromJson(json["newsletter_subscribers"]),
      internalNoteTypes: json["internal_note_types"] == null ? null : ActivityLogs.fromJson(json["internal_note_types"]),
      projects: json["projects"] == null ? null : ActivityLogs.fromJson(json["projects"]),
      designs: json["designs"] == null ? null : ActivityLogs.fromJson(json["designs"]),
      styles: json["styles"] == null ? null : ActivityLogs.fromJson(json["styles"]),
      concepts: json["concepts"] == null ? null : ActivityLogs.fromJson(json["concepts"]),
      presentations: json["presentations"] == null ? null : ActivityLogs.fromJson(json["presentations"]),
      retailerStores: json["retailer_stores"] == null ? null : ActivityLogs.fromJson(json["retailer_stores"]),
      roles: json["roles"] == null ? null : ActivityLogs.fromJson(json["roles"]),
      deals: json["deals"] == null ? null : ActivityLogs.fromJson(json["deals"]),
      customerGroups: json["customer_groups"] == null ? null : ActivityLogs.fromJson(json["customer_groups"]),
      users: json["users"] == null ? null : ActivityLogs.fromJson(json["users"]),
      orion: json["orion"] == null ? null : Orion.fromJson(json["orion"]),
      cadLibrary: json["cad_library"] == null ? null : ActivityLogs.fromJson(json["cad_library"]),
      designLibrary: json["design_library"] == null ? null : ActivityLogs.fromJson(json["design_library"]),
      finishedGoodLibrary: json["finished_good_library"] == null ? null : ActivityLogs.fromJson(json["finished_good_library"]),
      skuLibrary: json["sku_library"] == null ? null : ActivityLogs.fromJson(json["sku_library"]),
      styleLibrary: json["style_library"] == null ? null : ActivityLogs.fromJson(json["style_library"]),
      watchlist: json["watchlist"] == null ? null : ActivityLogs.fromJson(json["watchlist"]),
      wishlist: json["wishlist"] == null ? null : ActivityLogs.fromJson(json["wishlist"]),
      gemstoneShapes: json["gemstone_shapes"] == null ? null : ActivityLogs.fromJson(json["gemstone_shapes"]),
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

  @override
  List<Object?> get props => [
        activityLogs,
        exhibitions,
        assetMgmt,
        reviewFeedbacks,
        digitalCatalogue,
        calendars,
        messages,
        cmsPageBuilder,
        companies,
        currency,
        leads,
        request,
        department,
        systemTemplates,
        diamondCategories,
        jewelleryCategories,
        gemstoneCategories,
        paymentTerms,
        filterOptions,
        diamondShapes,
        diamondColors,
        jewelleryMetalColors,
        faqs,
        tasks,
        meetings,
        inquiries,
        language,
        auctions,
        orders,
        newsletterSubscribers,
        internalNoteTypes,
        projects,
        designs,
        styles,
        concepts,
        presentations,
        retailerStores,
        roles,
        deals,
        customerGroups,
        users,
        orion,
        cadLibrary,
        designLibrary,
        finishedGoodLibrary,
        skuLibrary,
        styleLibrary,
        watchlist,
        wishlist,
        gemstoneShapes,
      ];
}

class ActivityLogs extends Equatable {
  const ActivityLogs({
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

  factory ActivityLogs.fromJson(Map<String, dynamic> json) {
    return ActivityLogs(
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

  @override
  List<Object?> get props => [
        list,
        activityLogsExport,
        comment,
        create,
        delete,
        activityLogsImport,
        share,
        update,
        view,
      ];
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
