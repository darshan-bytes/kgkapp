class ContactUsModel {
  ContactUsModel({required this.data, required this.meta});

  final List<ContactUsModelDatum> data;
  final ContactUsMeta? meta;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      data: json["data"] == null ? [] : List<ContactUsModelDatum>.from(json["data"]!.map((x) => ContactUsModelDatum.fromJson(x))),
      meta: json["meta"] == null ? null : ContactUsMeta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {"data": data.map((x) => x.toJson()).toList(), "meta": meta?.toJson()};
}

class ContactUsModelDatum {
  ContactUsModelDatum({required this.id, required this.attributes});

  final int? id;
  final PurpleAttributes? attributes;

  factory ContactUsModelDatum.fromJson(Map<String, dynamic> json) {
    return ContactUsModelDatum(
      id: json["id"],
      attributes: json["attributes"] == null ? null : PurpleAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "attributes": attributes?.toJson()};
}

class PurpleAttributes {
  PurpleAttributes({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.contactUs,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? locale;
  final List<ContactUs> contactUs;

  factory PurpleAttributes.fromJson(Map<String, dynamic> json) {
    return PurpleAttributes(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      locale: json["locale"],
      contactUs: json["contact_us"] == null ? [] : List<ContactUs>.from(json["contact_us"]!.map((x) => ContactUs.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "publishedAt": publishedAt?.toIso8601String(),
    "locale": locale,
    "contact_us": contactUs.map((x) => x.toJson()).toList(),
  };
}

class ContactUs {
  ContactUs({
    required this.id,
    required this.component,
    required this.supportTitle,
    required this.userType,
    required this.businessType,
    required this.card,
    required this.support,
  });

  final int? id;
  final String? component;
  final String? supportTitle;
  final ContactUsUserType? userType;
  final ContactUsBusinessType? businessType;
  final ContactUsCard? card;
  final List<ContactUsSupport> support;

  factory ContactUs.fromJson(Map<String, dynamic> json) {
    return ContactUs(
      id: json["id"],
      component: json["__component"],
      supportTitle: json["support_title"],
      userType: json["user_type"] == null ? null : ContactUsUserType.fromJson(json["user_type"]),
      businessType: json["business_type"] == null ? null : ContactUsBusinessType.fromJson(json["business_type"]),
      card: json["card"] == null ? null : ContactUsCard.fromJson(json["card"]),
      support: json["support"] == null ? [] : List<ContactUsSupport>.from(json["support"]!.map((x) => ContactUsSupport.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "__component": component,
    "support_title": supportTitle,
    "user_type": userType?.toJson(),
    "business_type": businessType?.toJson(),
    "card": card?.toJson(),
    "support": support.map((x) => x.toJson()).toList(),
  };
}

class ContactUsBusinessType {
  ContactUsBusinessType({required this.id, required this.businessTypes});

  final int? id;
  final List<String> businessTypes;

  factory ContactUsBusinessType.fromJson(Map<String, dynamic> json) {
    return ContactUsBusinessType(
      id: json["id"],
      businessTypes: json["business_types"] == null ? [] : List<String>.from(json["business_types"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "business_types": businessTypes.map((x) => x).toList()};
}

class ContactUsCard {
  ContactUsCard({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.redirecTo,
    required this.redirectionType,
    required this.url,
    required this.mobileImage,
    required this.image,
  });

  final int? id;
  final String? title;
  final String? description;
  final dynamic tag;
  final String? redirecTo;
  final String? redirectionType;
  final dynamic url;
  final ContactUsImage? mobileImage;
  final ContactUsImage? image;

  factory ContactUsCard.fromJson(Map<String, dynamic> json) {
    return ContactUsCard(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      tag: json["tag"],
      redirecTo: json["RedirecTo"],
      redirectionType: json["RedirectionType"],
      url: json["url"],
      mobileImage: json["mobile_image"] == null ? null : ContactUsImage.fromJson(json["mobile_image"]),
      image: json["image"] == null ? null : ContactUsImage.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "tag": tag,
    "RedirecTo": redirecTo,
    "RedirectionType": redirectionType,
    "url": url,
    "mobile_image": mobileImage?.toJson(),
    "image": image?.toJson(),
  };
}

class ContactUsImage {
  ContactUsImage({required this.data});

  final List<ImageDatum> data;

  factory ContactUsImage.fromJson(Map<String, dynamic> json) {
    return ContactUsImage(data: json["data"] == null ? [] : List<ImageDatum>.from(json["data"]!.map((x) => ImageDatum.fromJson(x))));
  }

  Map<String, dynamic> toJson() => {"data": data.map((x) => x.toJson()).toList()};
}

class ImageDatum {
  ImageDatum({required this.id, required this.attributes});

  final int? id;
  final ContactUsFluffyAttributes? attributes;

  factory ImageDatum.fromJson(Map<String, dynamic> json) {
    return ImageDatum(
      id: json["id"],
      attributes: json["attributes"] == null ? null : ContactUsFluffyAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "attributes": attributes?.toJson()};
}

class ContactUsFluffyAttributes {
  ContactUsFluffyAttributes({
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? name;
  final dynamic alternativeText;
  final dynamic caption;
  final int? width;
  final int? height;
  final Formats? formats;
  final String? hash;
  final String? ext;
  final String? mime;
  final double? size;
  final String? url;
  final dynamic previewUrl;
  final String? provider;
  final dynamic providerMetadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ContactUsFluffyAttributes.fromJson(Map<String, dynamic> json) {
    return ContactUsFluffyAttributes(
      name: json["name"],
      alternativeText: json["alternativeText"],
      caption: json["caption"],
      width: json["width"],
      height: json["height"],
      formats: json["formats"] == null ? null : Formats.fromJson(json["formats"]),
      hash: json["hash"],
      ext: json["ext"],
      mime: json["mime"],
      size: json["size"],
      url: json["url"],
      previewUrl: json["previewUrl"],
      provider: json["provider"],
      providerMetadata: json["provider_metadata"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "alternativeText": alternativeText,
    "caption": caption,
    "width": width,
    "height": height,
    "formats": formats?.toJson(),
    "hash": hash,
    "ext": ext,
    "mime": mime,
    "size": size,
    "url": url,
    "previewUrl": previewUrl,
    "provider": provider,
    "provider_metadata": providerMetadata,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Formats {
  Formats({required this.small, required this.medium, required this.thumbnail});

  final Medium? small;
  final Medium? medium;
  final Medium? thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) {
    return Formats(
      small: json["small"] == null ? null : Medium.fromJson(json["small"]),
      medium: json["medium"] == null ? null : Medium.fromJson(json["medium"]),
      thumbnail: json["thumbnail"] == null ? null : Medium.fromJson(json["thumbnail"]),
    );
  }

  Map<String, dynamic> toJson() => {"small": small?.toJson(), "medium": medium?.toJson(), "thumbnail": thumbnail?.toJson()};
}

class Medium {
  Medium({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
    required this.sizeInBytes,
  });

  final String? ext;
  final String? url;
  final String? hash;
  final String? mime;
  final String? name;
  final dynamic path;
  final double? size;
  final int? width;
  final int? height;
  final int? sizeInBytes;

  factory Medium.fromJson(Map<String, dynamic> json) {
    return Medium(
      ext: json["ext"],
      url: json["url"],
      hash: json["hash"],
      mime: json["mime"],
      name: json["name"],
      path: json["path"],
      size: json["size"],
      width: json["width"],
      height: json["height"],
      sizeInBytes: json["sizeInBytes"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ext": ext,
    "url": url,
    "hash": hash,
    "mime": mime,
    "name": name,
    "path": path,
    "size": size,
    "width": width,
    "height": height,
    "sizeInBytes": sizeInBytes,
  };
}

class ContactUsSupport {
  ContactUsSupport({required this.id, required this.title, required this.description, required this.action, required this.url});

  final int? id;
  final String? title;
  final String? description;
  final String? action;
  final String? url;

  factory ContactUsSupport.fromJson(Map<String, dynamic> json) {
    return ContactUsSupport(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      action: json["action"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title, "description": description, "action": action, "url": url};
}

class ContactUsUserType {
  ContactUsUserType({required this.id, required this.userType});

  final int? id;
  final String? userType;

  factory ContactUsUserType.fromJson(Map<String, dynamic> json) {
    return ContactUsUserType(id: json["id"], userType: json["user_type"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "user_type": userType};
}

class ContactUsMeta {
  ContactUsMeta({required this.pagination});

  final ContactUsPagination? pagination;

  factory ContactUsMeta.fromJson(Map<String, dynamic> json) {
    return ContactUsMeta(pagination: json["pagination"] == null ? null : ContactUsPagination.fromJson(json["pagination"]));
  }

  Map<String, dynamic> toJson() => {"pagination": pagination?.toJson()};
}

class ContactUsPagination {
  ContactUsPagination({required this.page, required this.pageSize, required this.pageCount, required this.total});

  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  factory ContactUsPagination.fromJson(Map<String, dynamic> json) {
    return ContactUsPagination(page: json["page"], pageSize: json["pageSize"], pageCount: json["pageCount"], total: json["total"]);
  }

  Map<String, dynamic> toJson() => {"page": page, "pageSize": pageSize, "pageCount": pageCount, "total": total};
}
