import 'package:kgk/kgk.dart';

class JewelleryStrapiModel {
  JewelleryStrapiModel({required this.data, required this.meta});

  final List<Datum> data;
  final Meta? meta;

  factory JewelleryStrapiModel.fromJson(Map<String, dynamic> json) {
    return JewelleryStrapiModel(
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {"data": data.map((x) => x.toJson()).toList(), "meta": meta?.toJson()};

  @override
  String toString() {
    return "$data, $meta, ";
  }
}

class Datum {
  Datum({required this.id, required this.attributes});

  final int? id;
  final PurpleAttributes? attributes;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(id: json["id"], attributes: json["attributes"] == null ? null : PurpleAttributes.fromJson(json["attributes"]));
  }

  Map<String, dynamic> toJson() => {"id": id, "attributes": attributes?.toJson()};

  @override
  String toString() {
    return "$id, $attributes, ";
  }
}

class PurpleAttributes {
  PurpleAttributes({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.jewelleries,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? locale;
  final List<Jewellery> jewelleries;

  factory PurpleAttributes.fromJson(Map<String, dynamic> json) {
    return PurpleAttributes(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      locale: json["locale"],
      jewelleries: json["jewelleries"] == null ? [] : List<Jewellery>.from(json["jewelleries"]!.map((x) => Jewellery.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "publishedAt": publishedAt?.toIso8601String(),
    "locale": locale,
    "jewelleries": jewelleries.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() {
    return "$createdAt, $updatedAt, $publishedAt, $locale, $jewelleries, ";
  }
}

class Jewellery {
  Jewellery({
    required this.id,
    required this.component,
    required this.slug,
    required this.button,
    required this.userType,
    required this.businessType,
    required this.poster,
    required this.info,
    required this.details,
    required this.country,
    required this.title,
    required this.description,
    required this.image,
    required this.mobileImage,
    required this.banner,
    required this.backgroundImage,
    required this.button1,
    required this.button2,
    required this.points,
  });

  final int? id;
  final String? component;
  final Slug? slug;
  final dynamic button;
  final UserType? userType;
  final BusinessType? businessType;
  final Poster? poster;
  final Info? info;
  final Details? details;
  final List<Poster> country;
  final String? title;
  final String? description;
  final BannerImage? image;
  final BannerImage? mobileImage;
  final List<Banner> banner;
  final BackgroundImage? backgroundImage;
  final Button? button1;
  final Button? button2;
  final List<Details> points;

  factory Jewellery.fromJson(Map<String, dynamic> json) {
    return Jewellery(
      id: json["id"],
      component: json["__component"],
      slug: json["slug"] == null ? null : Slug.fromJson(json["slug"]),
      button: json["button"],
      userType: json["user_type"] == null ? null : UserType.fromJson(json["user_type"]),
      businessType: json["business_type"] == null ? null : BusinessType.fromJson(json["business_type"]),
      poster: json["poster"] == null ? null : Poster.fromJson(json["poster"]),
      info: json["info"] == null ? null : Info.fromJson(json["info"]),
      details: json["details"] == null ? null : Details.fromJson(json["details"]),
      country: json["country"] == null ? [] : List<Poster>.from(json["country"]!.map((x) => Poster.fromJson(x))),
      title: json["title"],
      description: json["description"],
      image: json["image"] == null ? null : BannerImage.fromJson(json["image"]),
      mobileImage: json["mobile_image"] == null ? null : BannerImage.fromJson(json["mobile_image"]),
      banner:
          json["banner"] == null
              ? []
              : (json["banner"] is List)
              ? List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x)))
              : [Banner.fromJson(json["banner"] as Map<String, dynamic>)],
      backgroundImage: json["background_image"] == null ? null : BackgroundImage.fromJson(json["background_image"]),
      button1: json["button_1"] == null ? null : Button.fromJson(json["button_1"]),
      button2: json["button_2"] == null ? null : Button.fromJson(json["button_2"]),
      points: json["points"] == null ? [] : List<Details>.from(json["points"]!.map((x) => Details.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "__component": component,
    "slug": slug?.toJson(),
    "button": button,
    "user_type": userType?.toJson(),
    "business_type": businessType?.toJson(),
    "poster": poster?.toJson(),
    "info": info?.toJson(),
    "details": details?.toJson(),
    "country": country.map((x) => x.toJson()).toList(),
    "title": title,
    "description": description,
    "image": image?.toJson(),
    "mobile_image": mobileImage?.toJson(),
    "banner": banner.map((x) => x.toJson()).toList(),
    "background_image": backgroundImage?.toJson(),
    "button_1": button1?.toJson(),
    "button_2": button2?.toJson(),
    "points": points.map((x) => x.toJson()).toList(),
  };
}

class BackgroundImage {
  BackgroundImage({required this.id, required this.title, required this.url, required this.mobileImage, required this.image});

  final int? id;
  final dynamic title;
  final dynamic url;
  final BannerImage? mobileImage;
  final BannerImage? image;

  factory BackgroundImage.fromJson(Map<String, dynamic> json) {
    return BackgroundImage(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      mobileImage: json["mobile_image"] == null ? null : BannerImage.fromJson(json["mobile_image"]),
      image: json["image"] == null ? null : BannerImage.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title, "url": url, "mobile_image": mobileImage?.toJson(), "image": image?.toJson()};
}

class Banner {
  Banner({
    required this.id,
    required this.title,
    required this.tag,
    required this.buttonLabel,
    required this.buttonUrl,
    required this.buttonTarget,
    required this.description,
    required this.redirectTo,
    required this.redirectionType,
    required this.image,
  });

  final int? id;
  final String? title;
  final dynamic tag;
  final String? buttonLabel;
  final dynamic buttonUrl;
  final dynamic buttonTarget;
  final String? description;
  final String? redirectTo;
  final String? redirectionType;
  final BannerImage? image;

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json["id"],
      title: json["title"],
      tag: json["tag"],
      buttonLabel: json["button_label"],
      buttonUrl: json["button_url"],
      buttonTarget: json["button_target"],
      description: json["description"],
      redirectTo: json["redirectTo"],
      redirectionType: json["redirectionType"],
      image: json["image"] == null ? null : BannerImage.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "tag": tag,
    "button_label": buttonLabel,
    "button_url": buttonUrl,
    "button_target": buttonTarget,
    "description": description,
    "redirectTo": redirectTo,
    "redirectionType": redirectionType,
    "image": image?.toJson(),
  };

  @override
  String toString() {
    return "$id, $title, $tag, $buttonLabel, $buttonUrl, $buttonTarget, $description, $redirectTo, $redirectionType, $image, ";
  }
}

class BannerImage {
  BannerImage({required this.data});

  final List<Dat> data;

  factory BannerImage.fromJson(Map<String, dynamic> json) {
    // Handle case where data might be a Map or a List
    dynamic jsonData = json["data"];
    if (jsonData == null) {
      return BannerImage(data: []);
    }

    if (jsonData is Map<String, dynamic>) {
      // If it's a single object, wrap it in a list
      return BannerImage(data: [Dat.fromJson(jsonData)]);
    }

    // If it's already a list, process it normally
    return BannerImage(data: (jsonData as List<dynamic>).map((x) => Dat.fromJson(x as Map<String, dynamic>)).toList());
  }

  Map<String, dynamic> toJson() => {"data": data.map((x) => x.toJson()).toList()};

  @override
  String toString() {
    return "$data, ";
  }
}

class Dat {
  Dat({required this.id, required this.attributes});

  final int? id;
  final DataAttributes? attributes;

  factory Dat.fromJson(Map<String, dynamic> json) {
    return Dat(id: json["id"], attributes: json["attributes"] == null ? null : DataAttributes.fromJson(json["attributes"]));
  }

  Map<String, dynamic> toJson() => {"id": id, "attributes": attributes?.toJson()};

  @override
  String toString() {
    return "$id, $attributes, ";
  }
}

class DataAttributes {
  DataAttributes({
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

  factory DataAttributes.fromJson(Map<String, dynamic> json) {
    return DataAttributes(
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

  @override
  String toString() {
    return "$name, $alternativeText, $caption, $width, $height, $formats, $hash, $ext, $mime, $size, $url, $previewUrl, $provider, $providerMetadata, $createdAt, $updatedAt, ";
  }
}

class Formats {
  Formats({required this.large, required this.small, required this.medium, required this.thumbnail});

  final Large? large;
  final Large? small;
  final Large? medium;
  final Large? thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) {
    return Formats(
      large: json["large"] == null ? null : Large.fromJson(json["large"]),
      small: json["small"] == null ? null : Large.fromJson(json["small"]),
      medium: json["medium"] == null ? null : Large.fromJson(json["medium"]),
      thumbnail: json["thumbnail"] == null ? null : Large.fromJson(json["thumbnail"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "large": large?.toJson(),
    "small": small?.toJson(),
    "medium": medium?.toJson(),
    "thumbnail": thumbnail?.toJson(),
  };

  @override
  String toString() {
    return "$large, $small, $medium, $thumbnail, ";
  }
}

class Large {
  Large({
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

  factory Large.fromJson(Map<String, dynamic> json) {
    return Large(
      ext: json["ext"],
      url: json["url"],
      hash: json["hash"],
      mime: json["mime"],
      name: json["name"],
      path: json["path"],
      size: json["size"]?.toString().toDouble,
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

  @override
  String toString() {
    return "$ext, $url, $hash, $mime, $name, $path, $size, $width, $height, $sizeInBytes, ";
  }
}

class BusinessType {
  BusinessType({required this.id, required this.businessType});

  final int? id;
  final String? businessType;

  factory BusinessType.fromJson(Map<String, dynamic> json) {
    return BusinessType(id: json["id"], businessType: json["business_type"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "business_type": businessType};

  @override
  String toString() {
    return "$id, $businessType, ";
  }
}

class Button {
  Button({
    required this.id,
    required this.label,
    required this.url,
    required this.target,
    required this.redirectTo,
    required this.redirectionType,
  });

  final int? id;
  final String? label;
  final dynamic url;
  final String? target;
  final String? redirectTo;
  final String? redirectionType;

  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
      id: json["id"],
      label: json["label"],
      url: json["url"],
      target: json["target"],
      redirectTo: json["redirectTo"],
      redirectionType: json["redirectionType"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "url": url,
    "target": target,
    "redirectTo": redirectTo,
    "redirectionType": redirectionType,
  };

  @override
  String toString() {
    return "$id, $label, $url, $target, $redirectTo, $redirectionType, ";
  }
}

class Poster {
  Poster({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.redirecTo,
    required this.redirectionType,
    required this.mobileImage,
    required this.image,
  });

  final int? id;
  final String? title;
  final String? description;
  final dynamic tag;
  final String? redirecTo;
  final String? redirectionType;
  final BannerImage? mobileImage;
  final BannerImage? image;

  factory Poster.fromJson(Map<String, dynamic> json) {
    return Poster(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      tag: json["tag"],
      redirecTo: json["RedirecTo"],
      redirectionType: json["RedirectionType"],
      mobileImage: json["mobile_image"] == null ? null : BannerImage.fromJson(json["mobile_image"]),
      image: json["image"] == null ? null : BannerImage.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "tag": tag,
    "RedirecTo": redirecTo,
    "RedirectionType": redirectionType,
    "mobile_image": mobileImage?.toJson(),
    "image": image?.toJson(),
  };
}

class Country {
  Country({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.redirecTo,
    required this.redirectionType,
    required this.image,
  });

  final int? id;
  final String? title;
  final dynamic description;
  final dynamic tag;
  final String? redirecTo;
  final dynamic redirectionType;
  final BannerImage? image;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      tag: json["tag"],
      redirecTo: json["RedirecTo"],
      redirectionType: json["RedirectionType"],
      image: json["image"] == null ? null : BannerImage.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "tag": tag,
    "RedirecTo": redirecTo,
    "RedirectionType": redirectionType,
    "image": image?.toJson(),
  };

  @override
  String toString() {
    return "$id, $title, $description, $tag, $redirecTo, $redirectionType, $image, ";
  }
}

class Details {
  Details({required this.id, required this.title, required this.description});

  final int? id;
  final String? title;
  final dynamic description;

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(id: json["id"], title: json["title"], description: json["description"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title, "description": description};

  @override
  String toString() {
    return "$id, $title, $description, ";
  }
}

class MobileImageClass {
  MobileImageClass({required this.data});

  final Dat? data;

  factory MobileImageClass.fromJson(Map<String, dynamic> json) {
    return MobileImageClass(data: json["data"] == null ? null : Dat.fromJson(json["data"]));
  }

  Map<String, dynamic> toJson() => {"data": data?.toJson()};

  @override
  String toString() {
    return "$data, ";
  }
}

class Info {
  Info({required this.id, required this.title, required this.headline, required this.tagline, required this.sectionTitle});

  final int? id;
  final String? title;
  final dynamic headline;
  final String? tagline;
  final dynamic sectionTitle;

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      id: json["id"],
      title: json["title"],
      headline: json["headline"],
      tagline: json["tagline"],
      sectionTitle: json["section_title"],
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title, "headline": headline, "tagline": tagline, "section_title": sectionTitle};
}

class Slug {
  Slug({required this.id, required this.slug});

  final int? id;
  final String? slug;

  factory Slug.fromJson(Map<String, dynamic> json) {
    return Slug(id: json["id"], slug: json["slug"]);
  }

  LandingSlug get landingSlug => LandingSlug.values.firstWhereOrNull((element) => element.value == slug) ?? LandingSlug.unknown;

  Map<String, dynamic> toJson() => {"id": id, "slug": slug};

  @override
  String toString() {
    return "$id, $slug, ";
  }
}

class UserType {
  UserType({required this.id, required this.userType});

  final int? id;
  final String? userType;

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(id: json["id"], userType: json["user_type"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "user_type": userType};

  @override
  String toString() {
    return "$id, $userType, ";
  }
}

class Meta {
  Meta({required this.pagination});

  final Pagination? pagination;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]));
  }

  Map<String, dynamic> toJson() => {"pagination": pagination?.toJson()};

  @override
  String toString() {
    return "$pagination, ";
  }
}

class Pagination {
  Pagination({required this.page, required this.pageSize, required this.pageCount, required this.total});

  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(page: json["page"], pageSize: json["pageSize"], pageCount: json["pageCount"], total: json["total"]);
  }

  Map<String, dynamic> toJson() => {"page": page, "pageSize": pageSize, "pageCount": pageCount, "total": total};

  @override
  String toString() {
    return "$page, $pageSize, $pageCount, $total, ";
  }
}
