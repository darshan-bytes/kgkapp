import 'package:kgk/kgk.dart';

class ExhibitionStrapiDataModel {
  ExhibitionStrapiDataModel({required this.data, required this.meta});

  final List<ExhibitionDatum> data;
  final ExhibitionMeta? meta;

  factory ExhibitionStrapiDataModel.fromJson(Map<String, dynamic> json) {
    return ExhibitionStrapiDataModel(
      data: json["data"] == null ? [] : List<ExhibitionDatum>.from(json["data"]!.map((x) => ExhibitionDatum.fromJson(x))),
      meta: json["meta"] == null ? null : ExhibitionMeta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {"data": data.map((x) => x.toJson()).toList(), "meta": meta?.toJson()};
}

class ExhibitionDatum {
  ExhibitionDatum({required this.id, required this.attributes});

  final int? id;
  final ExhibitionDatumAttributes? attributes;

  factory ExhibitionDatum.fromJson(Map<String, dynamic> json) {
    return ExhibitionDatum(
      id: json["id"],
      attributes: json["attributes"] == null ? null : ExhibitionDatumAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "attributes": attributes?.toJson()};
}

class ExhibitionDatumAttributes {
  ExhibitionDatumAttributes({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.exhibition,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? locale;
  final List<Exhibition> exhibition;

  factory ExhibitionDatumAttributes.fromJson(Map<String, dynamic> json) {
    return ExhibitionDatumAttributes(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      locale: json["locale"],
      exhibition: json["Exhibition"] == null ? [] : List<Exhibition>.from(json["Exhibition"]!.map((x) => Exhibition.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "publishedAt": publishedAt?.toIso8601String(),
    "locale": locale,
    "Exhibition": exhibition.map((x) => x.toJson()).toList(),
  };
}

class Exhibition {
  Exhibition({
    required this.id,
    required this.component,
    required this.title,
    required this.description,
    required this.button1,
    required this.button2,
    required this.image,
  });

  final int? id;
  final String? component;
  final String? title;
  final String? description;
  final ExhibitionButton? button1;
  final ExhibitionButton? button2;
  final ExhibitionImage? image;

  factory Exhibition.fromJson(Map<String, dynamic> json) {
    return Exhibition(
      id: json["id"],
      component: json["__component"],
      title: json["Title"],
      description: json["Description"],
      button1: json["Button_1"] == null ? null : ExhibitionButton.fromJson(json["Button_1"]),
      button2: json["Button_2"] == null ? null : ExhibitionButton.fromJson(json["Button_2"]),
      image: json["Image"] == null ? null : ExhibitionImage.fromJson(json["Image"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "__component": component,
    "Title": title,
    "Description": description,
    "Button_1": button1?.toJson(),
    "Button_2": button2,
    "Image": image?.toJson(),
  };
}

class ExhibitionButton {
  ExhibitionButton({
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

  factory ExhibitionButton.fromJson(Map<String, dynamic> json) {
    return ExhibitionButton(
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

class ExhibitionImage {
  ExhibitionImage({required this.id, required this.title, required this.url, required this.mobileImage, required this.image});

  final int? id;
  final String? title;
  final dynamic url;
  final ExhibitionImageClass? mobileImage;
  final ExhibitionImageClass? image;

  factory ExhibitionImage.fromJson(Map<String, dynamic> json) {
    return ExhibitionImage(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      mobileImage: json["mobile_image"] == null ? null : ExhibitionImageClass.fromJson(json["mobile_image"]),
      image: json["image"] == null ? null : ExhibitionImageClass.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "title": title, "url": url, "mobile_image": mobileImage?.toJson(), "image": image?.toJson()};

  String? get imageUrl => (mobileImage ?? image)?.data?.attributes?.url?.setStrapiMediaUrl;
}

class ExhibitionImageClass {
  ExhibitionImageClass({required this.data});

  final ExhibitionData? data;

  factory ExhibitionImageClass.fromJson(Map<String, dynamic> json) {
    return ExhibitionImageClass(data: json["data"] == null ? null : ExhibitionData.fromJson(json["data"]));
  }

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class ExhibitionData {
  ExhibitionData({required this.id, required this.attributes});

  final int? id;
  final ExhibitionDataAttributes? attributes;

  factory ExhibitionData.fromJson(Map<String, dynamic> json) {
    return ExhibitionData(
      id: json["id"],
      attributes: json["attributes"] == null ? null : ExhibitionDataAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "attributes": attributes?.toJson()};
}

class ExhibitionDataAttributes {
  ExhibitionDataAttributes({
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
  final ExhibitionFormats? formats;
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

  factory ExhibitionDataAttributes.fromJson(Map<String, dynamic> json) {
    return ExhibitionDataAttributes(
      name: json["name"],
      alternativeText: json["alternativeText"],
      caption: json["caption"],
      width: json["width"],
      height: json["height"],
      formats: json["formats"] == null ? null : ExhibitionFormats.fromJson(json["formats"]),
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

class ExhibitionFormats {
  ExhibitionFormats({required this.small, required this.medium, required this.thumbnail});

  final ExhibitionMedium? small;
  final ExhibitionMedium? medium;
  final ExhibitionMedium? thumbnail;

  factory ExhibitionFormats.fromJson(Map<String, dynamic> json) {
    return ExhibitionFormats(
      small: json["small"] == null ? null : ExhibitionMedium.fromJson(json["small"]),
      medium: json["medium"] == null ? null : ExhibitionMedium.fromJson(json["medium"]),
      thumbnail: json["thumbnail"] == null ? null : ExhibitionMedium.fromJson(json["thumbnail"]),
    );
  }

  Map<String, dynamic> toJson() => {"small": small?.toJson(), "medium": medium?.toJson(), "thumbnail": thumbnail?.toJson()};
}

class ExhibitionMedium {
  ExhibitionMedium({
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

  factory ExhibitionMedium.fromJson(Map<String, dynamic> json) {
    return ExhibitionMedium(
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

class ExhibitionMeta {
  ExhibitionMeta({required this.pagination});

  final ExhibitionPagination? pagination;

  factory ExhibitionMeta.fromJson(Map<String, dynamic> json) {
    return ExhibitionMeta(pagination: json["pagination"] == null ? null : ExhibitionPagination.fromJson(json["pagination"]));
  }

  Map<String, dynamic> toJson() => {"pagination": pagination?.toJson()};
}

class ExhibitionPagination {
  ExhibitionPagination({required this.page, required this.pageSize, required this.pageCount, required this.total});

  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  factory ExhibitionPagination.fromJson(Map<String, dynamic> json) {
    return ExhibitionPagination(page: json["page"], pageSize: json["pageSize"], pageCount: json["pageCount"], total: json["total"]);
  }

  Map<String, dynamic> toJson() => {"page": page, "pageSize": pageSize, "pageCount": pageCount, "total": total};
}
