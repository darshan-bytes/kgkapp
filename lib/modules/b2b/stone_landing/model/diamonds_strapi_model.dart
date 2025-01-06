import 'package:kgk/kgk.dart';

// class DiamondsStrapiModel {
//   DiamondsStrapiModel({
//     required this.data,
//     required this.meta,
//   });
//
//   final List<DiamondsStrapiModelDatum> data;
//   final Meta? meta;
//
//   factory DiamondsStrapiModel.fromJson(Map<String, dynamic> json) {
//     return DiamondsStrapiModel(
//       data: json["data"] == null ? [] : List<DiamondsStrapiModelDatum>.from(json["data"]!.map((x) => DiamondsStrapiModelDatum.fromJson(x))),
//       meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "data": data.map((x) => x.toJson()).toList(),
//         "meta": meta?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$data, $meta, ";
//   }
// }

// new
class DiamondsStrapiModel {
  DiamondsStrapiModel({
    required this.data,
    required this.meta,
  });

  final List<DiamondsStrapiModelDatum> data;
  final Meta? meta;

  factory DiamondsStrapiModel.fromJson(Map<String, dynamic> json){
    return DiamondsStrapiModel(
      data: json["data"] == null ? [] : List<DiamondsStrapiModelDatum>.from(json["data"]!.map((x) => DiamondsStrapiModelDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
    "meta": meta?.toJson(),
  };

}

// class DiamondsStrapiModelDatum {
//   DiamondsStrapiModelDatum({
//     required this.id,
//     required this.attributes,
//   });
//
//   final int? id;
//   final PurpleAttributes? attributes;
//
//   factory DiamondsStrapiModelDatum.fromJson(Map<String, dynamic> json) {
//     return DiamondsStrapiModelDatum(
//       id: json["id"],
//       attributes: json["attributes"] == null ? null : PurpleAttributes.fromJson(json["attributes"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "attributes": attributes?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $attributes, ";
//   }
// }

// new
class DiamondsStrapiModelDatum {
  DiamondsStrapiModelDatum({
    required this.id,
    required this.attributes,
  });

  final int? id;
  final PurpleAttributes? attributes;

  factory DiamondsStrapiModelDatum.fromJson(Map<String, dynamic> json){
    return DiamondsStrapiModelDatum(
      id: json["id"],
      attributes: json["attributes"] == null ? null : PurpleAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes?.toJson(),
  };

}

// class PurpleAttributes {
//   PurpleAttributes({
//     required this.createdAt,
//     required this.updatedAt,
//     required this.publishedAt,
//     required this.locale,
//     required this.diamonds,
//   });
//
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final DateTime? publishedAt;
//   final String? locale;
//   final List<DiamondData> diamonds;
//
//   factory PurpleAttributes.fromJson(Map<String, dynamic> json) {
//     return PurpleAttributes(
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//       publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
//       locale: json["locale"],
//       diamonds: json["diamonds"] == null ? [] : List<DiamondData>.from(json["diamonds"]!.map((x) => DiamondData.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "publishedAt": publishedAt?.toIso8601String(),
//         "locale": locale,
//         "diamonds": diamonds.map((x) => x.toJson()).toList(),
//       };
//
//   @override
//   String toString() {
//     return "$createdAt, $updatedAt, $publishedAt, $locale, $diamonds, ";
//   }
// }

// new
class PurpleAttributes {
  PurpleAttributes({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.diamonds,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? locale;
  final List<DiamondData> diamonds;

  factory PurpleAttributes.fromJson(Map<String, dynamic> json){
    return PurpleAttributes(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      locale: json["locale"],
      diamonds: json["diamonds"] == null ? [] : List<DiamondData>.from(json["diamonds"]!.map((x) => DiamondData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "publishedAt": publishedAt?.toIso8601String(),
    "locale": locale,
    "diamonds": diamonds.map((x) => x?.toJson()).toList(),
  };

}

// class DiamondData {
//   DiamondData({
//     required this.id,
//     required this.component,
//     required this.slug,
//     required this.userType,
//     required this.businessType,
//     required this.button,
//     required this.poster,
//     required this.details,
//     required this.country,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.banner,
//     required this.headline,
//     required this.about,
//     required this.faQs,
//   });
//
//   final int? id;
//   final String? component;
//   final Slug? slug;
//   final UserType? userType;
//   final BusinessType? businessType;
//   final List<Button> button;
//   final Poster? poster;
//   final Details? details;
//   final List<Country> country;
//   final String? title;
//   final String? description;
//   final DiamondImage? image;
//   final List<Banner> banner;
//   final dynamic headline;
//   final About? about;
//   final List<Faq> faQs;
//
//   factory DiamondData.fromJson(Map<String, dynamic> json) {
//     return DiamondData(
//       id: json["id"],
//       component: json["__component"],
//       slug: json["slug"] == null ? null : Slug.fromJson(json["slug"]),
//       userType: json["user_type"] == null ? null : UserType.fromJson(json["user_type"]),
//       businessType: json["business_type"] == null ? null : BusinessType.fromJson(json["business_type"]),
//       button: json["button"] == null ? [] : List<Button>.from(json["button"]!.map((x) => Button.fromJson(x))),
//       poster: json["poster"] == null ? null : Poster.fromJson(json["poster"]),
//       details: json["details"] == null ? null : Details.fromJson(json["details"]),
//       country: json["country"] == null ? [] : List<Country>.from(json["country"]!.map((x) => Country.fromJson(x))),
//       title: json["title"],
//       description: json["description"],
//       image: json["image"] == null ? null : DiamondImage.fromJson(json["image"]),
//       banner: json["banner"] == null ? [] : List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x))),
//       headline: json["headline"],
//       about: json["about"] == null ? null : About.fromJson(json["about"]),
//       faQs: json["FAQs"] == null ? [] : List<Faq>.from(json["FAQs"]!.map((x) => Faq.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "__component": component,
//         "slug": slug?.toJson(),
//         "user_type": userType?.toJson(),
//         "business_type": businessType?.toJson(),
//         "button": button.map((x) => x.toJson()).toList(),
//         "poster": poster?.toJson(),
//         "details": details?.toJson(),
//         "country": country.map((x) => x.toJson()).toList(),
//         "title": title,
//         "description": description,
//         "image": image?.toJson(),
//         "banner": banner.map((x) => x.toJson()).toList(),
//         "headline": headline,
//         "about": about?.toJson(),
//         "FAQs": faQs.map((x) => x.toJson()).toList(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $component, $slug, $userType, $businessType, $button, $poster, $details, $country, $title, $description, $image, $banner, $headline, $about, $faQs, ";
//   }
// }

// new
class DiamondData {
  DiamondData({
    required this.id,
    required this.component,
    required this.slug,
    required this.button,
    required this.userType,
    required this.businessType,
    required this.poster,
    required this.info,
    required this.title,
    required this.description,
    required this.backgroundImage,
    required this.details,
    required this.country,
    required this.image,
    required this.mobileImage,
    required this.banner,
    required this.headline,
    required this.about,
    required this.faQs,
    required this.points,
  });

  final int? id;
  final String? component;
  final Slug? slug;
  final dynamic? button;
  final UserType? userType;
  final BusinessType? businessType;
  final About? poster;
  final Info? info;
  final String? title;
  final String? description;
  final BackgroundImage? backgroundImage;
  final Details? details;
  final List<About> country;
  final AboutImage? image;
  final AboutImage? mobileImage;
  final List<Banner> banner;
  final dynamic headline;
  final About? about;
  final List<Faq> faQs;
  final List<Details> points;

  factory DiamondData.fromJson(Map<String, dynamic> json){
    return DiamondData(
      id: json["id"],
      component: json["__component"],
      slug: json["slug"] == null ? null : Slug.fromJson(json["slug"]),
      button: json["button"],
      userType: json["user_type"] == null ? null : UserType.fromJson(json["user_type"]),
      businessType: json["business_type"] == null ? null : BusinessType.fromJson(json["business_type"]),
      poster: json["poster"] == null ? null : About.fromJson(json["poster"]),
      info: json["info"] == null ? null : Info.fromJson(json["info"]),
      title: json["title"],
      description: json["description"],
      backgroundImage: json["background_image"] == null ? null : BackgroundImage.fromJson(json["background_image"]),
      details: json["details"] == null ? null : Details.fromJson(json["details"]),
      country: json["country"] == null ? [] : List<About>.from(json["country"]!.map((x) => About.fromJson(x))),
      image: json["image"] == null ? null : AboutImage.fromJson(json["image"]),
      mobileImage: json["mobile_image"] == null ? null : AboutImage.fromJson(json["mobile_image"]),
      banner: json["banner"] == null ? [] : List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x))),
      headline: json["headline"],
      about: json["about"] == null ? null : About.fromJson(json["about"]),
      faQs: json["FAQs"] == null ? [] : List<Faq>.from(json["FAQs"]!.map((x) => Faq.fromJson(x))),
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
    "title": title,
    "description": description,
    "background_image": backgroundImage?.toJson(),
    "details": details?.toJson(),
    "country": country.map((x) => x?.toJson()).toList(),
    "image": image?.toJson(),
    "mobile_image": mobileImage?.toJson(),
    "banner": banner.map((x) => x?.toJson()).toList(),
    "headline": headline,
    "about": about?.toJson(),
    "FAQs": faQs.map((x) => x?.toJson()).toList(),
    "points": points.map((x) => x?.toJson()).toList(),
  };

}

// class About {
//   About({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.tag,
//     required this.redirecTo,
//     required this.redirectionType,
//     required this.image,
//   });
//
//   final int? id;
//   final String? title;
//   final String? description;
//   final dynamic tag;
//   final String? redirecTo;
//   final dynamic redirectionType;
//   final AboutImage? image;
//
//   factory About.fromJson(Map<String, dynamic> json) {
//     return About(
//       id: json["id"],
//       title: json["title"],
//       description: json["description"],
//       tag: json["tag"],
//       redirecTo: json["RedirecTo"],
//       redirectionType: json["RedirectionType"],
//       image: json["image"] == null ? null : AboutImage.fromJson(json["image"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "tag": tag,
//         "RedirecTo": redirecTo,
//         "RedirectionType": redirectionType,
//         "image": image?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $title, $description, $tag, $redirecTo, $redirectionType, $image, ";
//   }
// }

// new
class About {
  About({
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
  final AboutImage? mobileImage;
  final AboutImage? image;

  factory About.fromJson(Map<String, dynamic> json){
    return About(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      tag: json["tag"],
      redirecTo: json["RedirecTo"],
      redirectionType: json["RedirectionType"],
      mobileImage: json["mobile_image"] == null ? null : AboutImage.fromJson(json["mobile_image"]),
      image: json["image"] == null ? null : AboutImage.fromJson(json["image"]),
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

// class AboutImage {
//   AboutImage({
//     required this.data,
//   });
//
//   final List<PurpleDatum> data;
//
//   factory AboutImage.fromJson(Map<String, dynamic> json) {
//     return AboutImage(
//       data: json["data"] == null ? [] : List<PurpleDatum>.from(json["data"]!.map((x) => PurpleDatum.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "data": data.map((x) => x.toJson()).toList(),
//       };
//
//   @override
//   String toString() {
//     return "$data, ";
//   }
// }

// new
class AboutImage {
  AboutImage({
    required this.data,
  });

  final dynamic data;

  factory AboutImage.fromJson(Map<String, dynamic> json){
    return AboutImage(
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
  };

}

// class PurpleDatum {
//   PurpleDatum({
//     required this.id,
//     required this.attributes,
//   });
//
//   final int? id;
//   final FluffyAttributes? attributes;
//
//   factory PurpleDatum.fromJson(Map<String, dynamic> json) {
//     return PurpleDatum(
//       id: json["id"],
//       attributes: json["attributes"] == null ? null : FluffyAttributes.fromJson(json["attributes"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "attributes": attributes?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $attributes, ";
//   }
// }

// new
class PurpleDatum {
  PurpleDatum({
    required this.id,
    required this.attributes,
  });

  final int? id;
  final FluffyAttributes? attributes;

  factory PurpleDatum.fromJson(Map<String, dynamic> json){
    return PurpleDatum(
      id: json["id"],
      attributes: json["attributes"] == null ? null : FluffyAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes?.toJson(),
  };

}

// class FluffyAttributes {
//   FluffyAttributes({
//     required this.name,
//     required this.alternativeText,
//     required this.caption,
//     required this.width,
//     required this.height,
//     required this.formats,
//     required this.hash,
//     required this.ext,
//     required this.mime,
//     required this.size,
//     required this.url,
//     required this.previewUrl,
//     required this.provider,
//     required this.providerMetadata,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   final String? name;
//   final dynamic alternativeText;
//   final dynamic caption;
//   final int? width;
//   final int? height;
//   final PurpleFormats? formats;
//   final String? hash;
//   final String? ext;
//   final String? mime;
//   final double? size;
//   final String? url;
//   final dynamic previewUrl;
//   final String? provider;
//   final dynamic providerMetadata;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   factory FluffyAttributes.fromJson(Map<String, dynamic> json) {
//     return FluffyAttributes(
//       name: json["name"],
//       alternativeText: json["alternativeText"],
//       caption: json["caption"],
//       width: json["width"],
//       height: json["height"],
//       formats: json["formats"] == null ? null : PurpleFormats.fromJson(json["formats"]),
//       hash: json["hash"],
//       ext: json["ext"],
//       mime: json["mime"],
//       size: json["size"],
//       url: json["url"],
//       previewUrl: json["previewUrl"],
//       provider: json["provider"],
//       providerMetadata: json["provider_metadata"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "alternativeText": alternativeText,
//         "caption": caption,
//         "width": width,
//         "height": height,
//         "formats": formats?.toJson(),
//         "hash": hash,
//         "ext": ext,
//         "mime": mime,
//         "size": size,
//         "url": url,
//         "previewUrl": previewUrl,
//         "provider": provider,
//         "provider_metadata": providerMetadata,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
//
//   @override
//   String toString() {
//     return "$name, $alternativeText, $caption, $width, $height, $formats, $hash, $ext, $mime, $size, $url, $previewUrl, $provider, $providerMetadata, $createdAt, $updatedAt, ";
//   }
// }

//
class FluffyAttributes {
  FluffyAttributes({
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
  final PurpleFormats? formats;
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

  factory FluffyAttributes.fromJson(Map<String, dynamic> json){
    return FluffyAttributes(
      name: json["name"],
      alternativeText: json["alternativeText"],
      caption: json["caption"],
      width: json["width"],
      height: json["height"],
      formats: json["formats"] == null ? null : PurpleFormats.fromJson(json["formats"]),
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

// class PurpleFormats {
//   PurpleFormats({
//     required this.thumbnail,
//   });
//
//   final Large? thumbnail;
//
//   factory PurpleFormats.fromJson(Map<String, dynamic> json) {
//     return PurpleFormats(
//       thumbnail: json["thumbnail"] == null ? null : Large.fromJson(json["thumbnail"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "thumbnail": thumbnail?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$thumbnail, ";
//   }
// }

// new
class PurpleFormats {
  PurpleFormats({
    required this.small,
    required this.medium,
    required this.thumbnail,
    required this.large,
  });

  final Large? small;
  final Large? medium;
  final Large? thumbnail;
  final Large? large;

  factory PurpleFormats.fromJson(Map<String, dynamic> json){
    return PurpleFormats(
      small: json["small"] == null ? null : Large.fromJson(json["small"]),
      medium: json["medium"] == null ? null : Large.fromJson(json["medium"]),
      thumbnail: json["thumbnail"] == null ? null : Large.fromJson(json["thumbnail"]),
      large: json["large"] == null ? null : Large.fromJson(json["large"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "small": small?.toJson(),
    "medium": medium?.toJson(),
    "thumbnail": thumbnail?.toJson(),
    "large": large?.toJson(),
  };

}

// class Large {
//   Large({
//     required this.ext,
//     required this.url,
//     required this.hash,
//     required this.mime,
//     required this.name,
//     required this.path,
//     required this.size,
//     required this.width,
//     required this.height,
//     required this.sizeInBytes,
//   });
//
//   final String? ext;
//   final String? url;
//   final String? hash;
//   final String? mime;
//   final String? name;
//   final dynamic path;
//   final double? size;
//   final int? width;
//   final int? height;
//   final int? sizeInBytes;
//
//   factory Large.fromJson(Map<String, dynamic> json) {
//     return Large(
//       ext: json["ext"],
//       url: json["url"],
//       hash: json["hash"],
//       mime: json["mime"],
//       name: json["name"],
//       path: json["path"],
//       size: json["size"],
//       width: json["width"],
//       height: json["height"],
//       sizeInBytes: json["sizeInBytes"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "ext": ext,
//         "url": url,
//         "hash": hash,
//         "mime": mime,
//         "name": name,
//         "path": path,
//         "size": size,
//         "width": width,
//         "height": height,
//         "sizeInBytes": sizeInBytes,
//       };
//
//   @override
//   String toString() {
//     return "$ext, $url, $hash, $mime, $name, $path, $size, $width, $height, $sizeInBytes, ";
//   }
// }

// new
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

  factory Large.fromJson(Map<String, dynamic> json){
    return Large(
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

// full new
class BackgroundImage {
  BackgroundImage({
    required this.id,
    required this.title,
    required this.url,
    required this.mobileImage,
    required this.image,
  });

  final int? id;
  final dynamic title;
  final dynamic url;
  final AboutImage? mobileImage;
  final AboutImage? image;

  factory BackgroundImage.fromJson(Map<String, dynamic> json){
    return BackgroundImage(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      mobileImage: json["mobile_image"] == null ? null : AboutImage.fromJson(json["mobile_image"]),
      image: json["image"] == null ? null : AboutImage.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "mobile_image": mobileImage?.toJson(),
    "image": image?.toJson(),
  };

}

// class Banner {
//   Banner({
//     required this.id,
//     required this.title,
//     required this.tag,
//     required this.buttonLabel,
//     required this.buttonUrl,
//     required this.buttonTarget,
//     required this.description,
//     required this.redirectTo,
//     required this.redirectionType,
//     required this.image,
//   });
//
//   final int? id;
//   final String? title;
//   final dynamic tag;
//   final String? buttonLabel;
//   final dynamic buttonUrl;
//   final dynamic buttonTarget;
//   final String? description;
//   final dynamic redirectTo;
//   final dynamic redirectionType;
//   final BannerImage? image;
//
//   factory Banner.fromJson(Map<String, dynamic> json) {
//     return Banner(
//       id: json["id"],
//       title: json["title"],
//       tag: json["tag"],
//       buttonLabel: json["button_label"],
//       buttonUrl: json["button_url"],
//       buttonTarget: json["button_target"],
//       description: json["description"],
//       redirectTo: json["redirectTo"],
//       redirectionType: json["redirectionType"],
//       image: json["image"] == null ? null : BannerImage.fromJson(json["image"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "tag": tag,
//         "button_label": buttonLabel,
//         "button_url": buttonUrl,
//         "button_target": buttonTarget,
//         "description": description,
//         "redirectTo": redirectTo,
//         "redirectionType": redirectionType,
//         "image": image?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $title, $tag, $buttonLabel, $buttonUrl, $buttonTarget, $description, $redirectTo, $redirectionType, $image, ";
//   }
// }

// new
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
    required this.mobileImage,
    required this.image,
  });

  final int? id;
  final String? title;
  final dynamic tag;
  final String? buttonLabel;
  final String? buttonUrl;
  final String? buttonTarget;
  final String? description;
  final dynamic redirectTo;
  final dynamic redirectionType;
  final AboutImage? mobileImage;
  final AboutImage? image;

  factory Banner.fromJson(Map<String, dynamic> json){
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
      mobileImage: json["mobile_image"] == null ? null : AboutImage.fromJson(json["mobile_image"]),
      image: json["image"] == null ? null : AboutImage.fromJson(json["image"]),
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
    "mobile_image": mobileImage?.toJson(),
    "image": image?.toJson(),
  };

}

// class BannerImage {
//   BannerImage({
//     required this.data,
//   });
//
//   final List<Dat> data;
//
//   factory BannerImage.fromJson(Map<String, dynamic> json) {
//     return BannerImage(
//       data: json["data"] == null ? [] : List<Dat>.from(json["data"]!.map((x) => Dat.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "data": data.map((x) => x.toJson()).toList(),
//       };
//
//   @override
//   String toString() {
//     return "$data, ";
//   }
// }

// new
class BusinessType {
  BusinessType({
    required this.id,
    required this.businessTypes,
  });

  final int? id;
  final List<String> businessTypes;

  factory BusinessType.fromJson(Map<String, dynamic> json){
    return BusinessType(
      id: json["id"],
      businessTypes: json["business_types"] == null ? [] : List<String>.from(json["business_types"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_types": businessTypes.map((x) => x).toList(),
  };

}

class ButtonElement {
  ButtonElement({
    required this.id,
    required this.label,
    required this.url,
    required this.target,
    required this.redirectTo,
    required this.redirectionType,
  });

  final int? id;
  final String? label;
  final String? url;
  final String? target;
  final String? redirectTo;
  final String? redirectionType;

  factory ButtonElement.fromJson(Map<String, dynamic> json){
    return ButtonElement(
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

}

class Details {
  Details({
    required this.id,
    required this.title,
    required this.description,
  });

  final int? id;
  final String? title;
  final String? description;

  factory Details.fromJson(Map<String, dynamic> json){
    return Details(
      id: json["id"],
      title: json["title"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
  };

}

class Faq {
  Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.title,
  });

  final int? id;
  final String? question;
  final String? answer;
  final dynamic title;

  factory Faq.fromJson(Map<String, dynamic> json){
    return Faq(
      id: json["id"],
      question: json["question"],
      answer: json["answer"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "title": title,
  };

}

class Info {
  Info({
    required this.id,
    required this.title,
    required this.headline,
    required this.tagline,
    required this.sectionTitle,
  });

  final int? id;
  final String? title;
  final dynamic headline;
  final dynamic tagline;
  final dynamic sectionTitle;

  factory Info.fromJson(Map<String, dynamic> json){
    return Info(
      id: json["id"],
      title: json["title"],
      headline: json["headline"],
      tagline: json["tagline"],
      sectionTitle: json["section_title"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "headline": headline,
    "tagline": tagline,
    "section_title": sectionTitle,
  };

}

class Slug {
  Slug({
    required this.id,
    required this.slug,
  });

  final int? id;
  final String? slug;

  factory Slug.fromJson(Map<String, dynamic> json){
    return Slug(
      id: json["id"],
      slug: json["slug"],
    );
  }

  LandingSlug get landingSlug => LandingSlug.values.firstWhereOrNull((element) => element.value == slug) ?? LandingSlug.unknown;

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
  };

}

class UserType {
  UserType({
    required this.id,
    required this.userType,
  });

  final int? id;
  final String? userType;

  factory UserType.fromJson(Map<String, dynamic> json){
    return UserType(
      id: json["id"],
      userType: json["user_type"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_type": userType,
  };

}

class Meta {
  Meta({
    required this.pagination,
  });

  final Pagination? pagination;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "pagination": pagination?.toJson(),
  };

}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      page: json["page"],
      pageSize: json["pageSize"],
      pageCount: json["pageCount"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "pageSize": pageSize,
    "pageCount": pageCount,
    "total": total,
  };

}

// pending integration

// class Dat {
//   Dat({
//     required this.id,
//     required this.attributes,
//   });
//
//   final int? id;
//   final DataAttributes? attributes;
//
//   factory Dat.fromJson(Map<String, dynamic> json) {
//     return Dat(
//       id: json["id"],
//       attributes: json["attributes"] == null ? null : DataAttributes.fromJson(json["attributes"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "attributes": attributes?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $attributes, ";
//   }
// }
//
// class DataAttributes {
//   DataAttributes({
//     required this.name,
//     required this.alternativeText,
//     required this.caption,
//     required this.width,
//     required this.height,
//     required this.formats,
//     required this.hash,
//     required this.ext,
//     required this.mime,
//     required this.size,
//     required this.url,
//     required this.previewUrl,
//     required this.provider,
//     required this.providerMetadata,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   final String? name;
//   final dynamic alternativeText;
//   final dynamic caption;
//   final int? width;
//   final int? height;
//   final FluffyFormats? formats;
//   final String? hash;
//   final String? ext;
//   final String? mime;
//   final double? size;
//   final String? url;
//   final dynamic previewUrl;
//   final String? provider;
//   final dynamic providerMetadata;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   factory DataAttributes.fromJson(Map<String, dynamic> json) {
//     return DataAttributes(
//       name: json["name"],
//       alternativeText: json["alternativeText"],
//       caption: json["caption"],
//       width: json["width"],
//       height: json["height"],
//       formats: json["formats"] == null ? null : FluffyFormats.fromJson(json["formats"]),
//       hash: json["hash"],
//       ext: json["ext"],
//       mime: json["mime"],
//       size: json["size"],
//       url: json["url"],
//       previewUrl: json["previewUrl"],
//       provider: json["provider"],
//       providerMetadata: json["provider_metadata"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "alternativeText": alternativeText,
//         "caption": caption,
//         "width": width,
//         "height": height,
//         "formats": formats?.toJson(),
//         "hash": hash,
//         "ext": ext,
//         "mime": mime,
//         "size": size,
//         "url": url,
//         "previewUrl": previewUrl,
//         "provider": provider,
//         "provider_metadata": providerMetadata,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
//
//   @override
//   String toString() {
//     return "$name, $alternativeText, $caption, $width, $height, $formats, $hash, $ext, $mime, $size, $url, $previewUrl, $provider, $providerMetadata, $createdAt, $updatedAt, ";
//   }
// }
//
// class FluffyFormats {
//   FluffyFormats({
//     required this.large,
//     required this.small,
//     required this.medium,
//     required this.thumbnail,
//   });
//
//   final Large? large;
//   final Large? small;
//   final Large? medium;
//   final Large? thumbnail;
//
//   factory FluffyFormats.fromJson(Map<String, dynamic> json) {
//     return FluffyFormats(
//       large: json["large"] == null ? null : Large.fromJson(json["large"]),
//       small: json["small"] == null ? null : Large.fromJson(json["small"]),
//       medium: json["medium"] == null ? null : Large.fromJson(json["medium"]),
//       thumbnail: json["thumbnail"] == null ? null : Large.fromJson(json["thumbnail"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "large": large?.toJson(),
//         "small": small?.toJson(),
//         "medium": medium?.toJson(),
//         "thumbnail": thumbnail?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$large, $small, $medium, $thumbnail, ";
//   }
// }
//
// class BusinessType {
//   BusinessType({
//     required this.id,
//     required this.businessType,
//   });
//
//   final int? id;
//   final String? businessType;
//
//   factory BusinessType.fromJson(Map<String, dynamic> json) {
//     return BusinessType(
//       id: json["id"],
//       businessType: json["business_type"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "business_type": businessType,
//       };
//
//   @override
//   String toString() {
//     return "$id, $businessType, ";
//   }
// }
//
// class Button {
//   Button({
//     required this.id,
//     required this.label,
//     required this.url,
//     required this.target,
//     required this.redirectTo,
//     required this.redirectionType,
//   });
//
//   final int? id;
//   final String? label;
//   final dynamic url;
//   final String? target;
//   final String? redirectTo;
//   final String? redirectionType;
//
//   factory Button.fromJson(Map<String, dynamic> json) {
//     return Button(
//       id: json["id"],
//       label: json["label"],
//       url: json["url"],
//       target: json["target"],
//       redirectTo: json["redirectTo"],
//       redirectionType: json["redirectionType"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "label": label,
//         "url": url,
//         "target": target,
//         "redirectTo": redirectTo,
//         "redirectionType": redirectionType,
//       };
//
//   @override
//   String toString() {
//     return "$id, $label, $url, $target, $redirectTo, $redirectionType, ";
//   }
// }
//
// class Country {
//   Country({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.tag,
//     required this.redirecTo,
//     required this.redirectionType,
//     required this.image,
//     required this.mobileImage,
//   });
//
//   final int? id;
//   final String? title;
//   final dynamic description;
//   final dynamic tag;
//   final String? redirecTo;
//   final dynamic redirectionType;
//   final CountryImage? image;
//   final CountryImage? mobileImage;
//
//   factory Country.fromJson(Map<String, dynamic> json) {
//     return Country(
//       id: json["id"],
//       title: json["title"],
//       description: json["description"],
//       tag: json["tag"],
//       redirecTo: json["RedirecTo"],
//       redirectionType: json["RedirectionType"],
//       image: json["image"] == null ? null : CountryImage.fromJson(json["image"]),
//       mobileImage: json["mobile_image"] == null ? null : CountryImage.fromJson(json["mobile_image"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "tag": tag,
//         "RedirecTo": redirecTo,
//         "RedirectionType": redirectionType,
//         "image": image?.toJson(),
//         "mobile_image": mobileImage?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $title, $description, $tag, $redirecTo, $redirectionType, $image, $mobileImage";
//   }
// }
//
// class CountryImage {
//   CountryImage({
//     required this.data,
//   });
//
//   final List<FluffyDatum> data;
//
//   factory CountryImage.fromJson(Map<String, dynamic> json) {
//     return CountryImage(
//       data: json["data"] == null ? [] : List<FluffyDatum>.from(json["data"]!.map((x) => FluffyDatum.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "data": data.map((x) => x.toJson()).toList(),
//       };
//
//   @override
//   String toString() {
//     return "$data, ";
//   }
// }
//
// class FluffyDatum {
//   FluffyDatum({
//     required this.id,
//     required this.attributes,
//   });
//
//   final int? id;
//   final TentacledAttributes? attributes;
//
//   factory FluffyDatum.fromJson(Map<String, dynamic> json) {
//     return FluffyDatum(
//       id: json["id"],
//       attributes: json["attributes"] == null ? null : TentacledAttributes.fromJson(json["attributes"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "attributes": attributes?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $attributes, ";
//   }
// }
//
// class TentacledAttributes {
//   TentacledAttributes({
//     required this.name,
//     required this.alternativeText,
//     required this.caption,
//     required this.width,
//     required this.height,
//     required this.formats,
//     required this.hash,
//     required this.ext,
//     required this.mime,
//     required this.size,
//     required this.url,
//     required this.previewUrl,
//     required this.provider,
//     required this.providerMetadata,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   final String? name;
//   final dynamic alternativeText;
//   final dynamic caption;
//   final int? width;
//   final int? height;
//   final TentacledFormats? formats;
//   final String? hash;
//   final String? ext;
//   final String? mime;
//   final double? size;
//   final String? url;
//   final dynamic previewUrl;
//   final String? provider;
//   final dynamic providerMetadata;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   factory TentacledAttributes.fromJson(Map<String, dynamic> json) {
//     return TentacledAttributes(
//       name: json["name"],
//       alternativeText: json["alternativeText"],
//       caption: json["caption"],
//       width: json["width"],
//       height: json["height"],
//       formats: json["formats"] == null ? null : TentacledFormats.fromJson(json["formats"]),
//       hash: json["hash"],
//       ext: json["ext"],
//       mime: json["mime"],
//       size: json["size"].toDouble(),
//       url: json["url"],
//       previewUrl: json["previewUrl"],
//       provider: json["provider"],
//       providerMetadata: json["provider_metadata"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "alternativeText": alternativeText,
//         "caption": caption,
//         "width": width,
//         "height": height,
//         "formats": formats?.toJson(),
//         "hash": hash,
//         "ext": ext,
//         "mime": mime,
//         "size": size,
//         "url": url,
//         "previewUrl": previewUrl,
//         "provider": provider,
//         "provider_metadata": providerMetadata,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//       };
//
//   @override
//   String toString() {
//     return "$name, $alternativeText, $caption, $width, $height, $formats, $hash, $ext, $mime, $size, $url, $previewUrl, $provider, $providerMetadata, $createdAt, $updatedAt, ";
//   }
// }
//
// class TentacledFormats {
//   TentacledFormats({
//     required this.small,
//     required this.thumbnail,
//   });
//
//   final Large? small;
//   final Large? thumbnail;
//
//   factory TentacledFormats.fromJson(Map<String, dynamic> json) {
//     return TentacledFormats(
//       small: json["small"] == null ? null : Large.fromJson(json["small"]),
//       thumbnail: json["thumbnail"] == null ? null : Large.fromJson(json["thumbnail"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "small": small?.toJson(),
//         "thumbnail": thumbnail?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$small, $thumbnail, ";
//   }
// }
//
// class Details {
//   Details({
//     required this.id,
//     required this.title,
//     required this.description,
//   });
//
//   final int? id;
//   final String? title;
//   final String? description;
//
//   factory Details.fromJson(Map<String, dynamic> json) {
//     return Details(
//       id: json["id"],
//       title: json["title"],
//       description: json["description"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//       };
//
//   @override
//   String toString() {
//     return "$id, $title, $description, ";
//   }
// }
//
// class Faq {
//   Faq({
//     required this.id,
//     required this.question,
//     required this.answer,
//     required this.title,
//   });
//
//   final int? id;
//   final String? question;
//   final String? answer;
//   final dynamic title;
//
//   factory Faq.fromJson(Map<String, dynamic> json) {
//     return Faq(
//       id: json["id"],
//       question: json["question"],
//       answer: json["answer"],
//       title: json["title"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "question": question,
//         "answer": answer,
//         "title": title,
//       };
//
//   @override
//   String toString() {
//     return "$id, $question, $answer, $title, ";
//   }
// }
//
// class DiamondImage {
//   DiamondImage({
//     required this.data,
//   });
//
//   final Dat? data;
//
//   factory DiamondImage.fromJson(Map<String, dynamic> json) {
//     return DiamondImage(
//       data: json["data"] == null ? null : Dat.fromJson(json["data"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$data, ";
//   }
// }
//
// class Poster {
//   Poster({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.tag,
//     required this.redirecTo,
//     required this.redirectionType,
//     required this.image,
//     required this.mobileImage,
//   });
//
//   final int? id;
//   final String? title;
//   final String? description;
//   final dynamic tag;
//   final String? redirecTo;
//   final String? redirectionType;
//   final BannerImage? image;
//   final BannerImage? mobileImage;
//
//   factory Poster.fromJson(Map<String, dynamic> json) {
//     return Poster(
//       id: json["id"],
//       title: json["title"],
//       description: json["description"],
//       tag: json["tag"],
//       redirecTo: json["RedirecTo"],
//       redirectionType: json["RedirectionType"],
//       image: json["image"] == null ? null : BannerImage.fromJson(json["image"]),
//       mobileImage: json["mobile_image"] == null ? null : BannerImage.fromJson(json["mobile_image"]),
//
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "tag": tag,
//         "RedirecTo": redirecTo,
//         "RedirectionType": redirectionType,
//         "image": image?.toJson(),
//         "mobile_image": mobileImage?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$id, $title, $description, $tag, $redirecTo, $redirectionType, $image, $mobileImage";
//   }
// }
//
// class Slug {
//   Slug({
//     required this.id,
//     required this.slug,
//   });
//
//   final int? id;
//   final String? slug;
//
//   factory Slug.fromJson(Map<String, dynamic> json) {
//     return Slug(
//       id: json["id"],
//       slug: json["slug"],
//     );
//   }
//
//   LandingSlug get landingSlug => LandingSlug.values.firstWhereOrNull((element) => element.value == slug) ?? LandingSlug.unknown;
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "slug": slug,
//       };
//
//   @override
//   String toString() {
//     return "$id, $slug, ";
//   }
// }
//
// class UserType {
//   UserType({
//     required this.id,
//     required this.userType,
//   });
//
//   final int? id;
//   final String? userType;
//
//   factory UserType.fromJson(Map<String, dynamic> json) {
//     return UserType(
//       id: json["id"],
//       userType: json["user_type"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_type": userType,
//       };
//
//   @override
//   String toString() {
//     return "$id, $userType, ";
//   }
// }
//
// class Meta {
//   Meta({
//     required this.pagination,
//   });
//
//   final Pagination? pagination;
//
//   factory Meta.fromJson(Map<String, dynamic> json) {
//     return Meta(
//       pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "pagination": pagination?.toJson(),
//       };
//
//   @override
//   String toString() {
//     return "$pagination, ";
//   }
// }
//
// class Pagination {
//   Pagination({
//     required this.page,
//     required this.pageSize,
//     required this.pageCount,
//     required this.total,
//   });
//
//   final int? page;
//   final int? pageSize;
//   final int? pageCount;
//   final int? total;
//
//   factory Pagination.fromJson(Map<String, dynamic> json) {
//     return Pagination(
//       page: json["page"],
//       pageSize: json["pageSize"],
//       pageCount: json["pageCount"],
//       total: json["total"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "page": page,
//         "pageSize": pageSize,
//         "pageCount": pageCount,
//         "total": total,
//       };
//
//   @override
//   String toString() {
//     return "$page, $pageSize, $pageCount, $total, ";
//   }
// }
