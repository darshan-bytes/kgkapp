import 'package:kgk/kgk.dart';

class HomeStrapiModel {
  HomeStrapiModel({
    required this.data,
    required this.meta,
  });

  final List<HomeStrapiModelDatum> data;
  final Meta? meta;

  factory HomeStrapiModel.fromJson(Map<String, dynamic> json) {
    return HomeStrapiModel(
      data: json["data"] == null ? [] : List<HomeStrapiModelDatum>.from(json["data"]!.map((x) => HomeStrapiModelDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "meta": meta?.toJson(),
      };

  @override
  String toString() {
    return "$data, $meta, ";
  }
}

class HomeStrapiModelDatum {
  HomeStrapiModelDatum({
    required this.id,
    required this.attributes,
  });

  final int? id;
  final DatumAttributes? attributes;

  factory HomeStrapiModelDatum.fromJson(Map<String, dynamic> json) {
    return HomeStrapiModelDatum(
      id: json["id"],
      attributes: json["attributes"] == null ? null : DatumAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes?.toJson(),
      };

  @override
  String toString() {
    return "$id, $attributes, ";
  }
}

class DatumAttributes {
  DatumAttributes({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.home,
    required this.locale,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final List<Home> home;
  final String? locale;

  factory DatumAttributes.fromJson(Map<String, dynamic> json) {
    return DatumAttributes(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      home: json["home"] == null ? [] : List<Home>.from(json["home"]!.map((x) => Home.fromJson(x))),
      locale: json["locale"],
    );
  }

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
        "home": home.map((x) => x.toJson()).toList(),
        "locale": locale,
      };

  @override
  String toString() {
    return "$createdAt, $updatedAt, $publishedAt, $home, $locale";
  }
}

class Home {
  Home({
    required this.id,
    required this.component,
    required this.data,
    required this.slug,
    required this.category,
    required this.info,
  });

  final int? id;
  final String? component;
  final dynamic data;
  final Slug? slug;
  final String? category;
  final Info? info;

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      id: json["id"],
      component: json["__component"],
      data: json["data"],
      slug: json["slug"] == null ? null : Slug.fromJson(json["slug"]),
      category: json["category"],
      info: json["info"] == null ? null : Info.fromJson(json["info"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "__component": component,
        "data": data,
        "slug": slug?.toJson(),
        "category": category,
        "info": info?.toJson(),
      };

  @override
  String toString() {
    return "$id, $component, $data, $slug, $category, $info";
  }
}

class DataDatum {
  DataDatum({
    required this.id,
    required this.redirectTo,
    required this.redirectionType,
    required this.title,
    required this.image,
  });

  final int? id;
  final String? redirectTo;
  final String? redirectionType;
  final String? title;
  final ImageModel? image;

  factory DataDatum.fromJson(Map<String, dynamic> json) {
    return DataDatum(
      id: json["id"],
      redirectTo: json["redirectTo"],
      redirectionType: json["redirectionType"],
      title: json["title"],
      image: json["image"] == null ? null : ImageModel.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "redirectTo": redirectTo,
        "redirectionType": redirectionType,
        "title": title,
        "image": image?.toJson(),
      };

  @override
  String toString() {
    return "$id, $redirectTo, $redirectionType, $title, $image, ";
  }
}

class ImageModel {
  ImageModel({
    required this.data,
  });

  final ImageData? data;

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      data: json["data"] == null ? null : ImageData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return "$data, ";
  }
}

class ImageData {
  ImageData({
    required this.id,
    required this.attributes,
  });

  final int? id;
  final DataAttributes? attributes;

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json["id"],
      attributes: json["attributes"] == null ? null : DataAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes?.toJson(),
      };

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
  Formats({
    required this.small,
    required this.thumbnail,
    required this.large,
    required this.medium,
  });

  final Large? small;
  final Large? thumbnail;
  final Large? large;
  final Large? medium;

  factory Formats.fromJson(Map<String, dynamic> json) {
    return Formats(
      small: json["small"] == null ? null : Large.fromJson(json["small"]),
      thumbnail: json["thumbnail"] == null ? null : Large.fromJson(json["thumbnail"]),
      large: json["large"] == null ? null : Large.fromJson(json["large"]),
      medium: json["medium"] == null ? null : Large.fromJson(json["medium"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "small": small?.toJson(),
        "thumbnail": thumbnail?.toJson(),
        "large": large?.toJson(),
        "medium": medium?.toJson(),
      };

  @override
  String toString() {
    return "$small, $thumbnail, $large, $medium, ";
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

  @override
  String toString() {
    return "$ext, $url, $hash, $mime, $name, $path, $size, $width, $height, $sizeInBytes, ";
  }
}

class DataData {
  DataData({
    required this.id,
    required this.title,
    required this.headline,
    required this.tagline,
    required this.sectionTitle,
    required this.redirectTo,
    required this.redirectionType,
    required this.image,
  });

  final int? id;
  final String? title;
  final dynamic headline;
  final String? tagline;
  final dynamic sectionTitle;
  final String? redirectTo;
  final String? redirectionType;
  final ImageModel? image;

  factory DataData.fromJson(Map<String, dynamic> json) {
    return DataData(
      id: json["id"],
      title: json["title"],
      headline: json["headline"],
      tagline: json["tagline"],
      sectionTitle: json["section_title"],
      redirectTo: json["redirectTo"],
      redirectionType: json["redirectionType"],
      image: json["image"] == null ? null : ImageModel.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "headline": headline,
        "tagline": tagline,
        "section_title": sectionTitle,
        "redirectTo": redirectTo,
        "redirectionType": redirectionType,
        "image": image?.toJson(),
      };

  @override
  String toString() {
    return "$id, $title, $headline, $tagline, $sectionTitle, $redirectTo, $redirectionType, $image, ";
  }
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

  HomeSlug get homeSlug => HomeSlug.values.firstWhereOrNull((element) => element.value == slug) ?? HomeSlug.unknown;

  factory Slug.fromJson(Map<String, dynamic> json) {
    return Slug(
      id: json["id"],
      slug: json["slug"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
      };

  @override
  String toString() {
    return "$id, $slug, ";
  }
}

class Meta {
  Meta({
    required this.pagination,
  });

  final Pagination? pagination;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
      };

  @override
  String toString() {
    return "$pagination, ";
  }
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

  factory Pagination.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return "$page, $pageSize, $pageCount, $total, ";
  }
}
