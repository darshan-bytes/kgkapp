class FaqStrapiModel {
  FaqStrapiModel({
    required this.data,
    required this.meta,
  });

  final List<FaqDatum> data;
  final Meta? meta;

  factory FaqStrapiModel.fromJson(Map<String, dynamic> json){
    return FaqStrapiModel(
      data: json["data"] == null ? [] : List<FaqDatum>.from(json["data"]!.map((x) => FaqDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
    "meta": meta?.toJson(),
  };

  @override
  String toString(){
    return "$data, $meta, ";
  }
}

class FaqDatum {
  FaqDatum({
    required this.id,
    required this.attributes,
  });

  final int? id;
  final FaqAttributes? attributes;

  factory FaqDatum.fromJson(Map<String, dynamic> json){
    return FaqDatum(
      id: json["id"],
      attributes: json["attributes"] == null ? null : FaqAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes?.toJson(),
  };

  @override
  String toString(){
    return "$id, $attributes, ";
  }
}

class FaqAttributes {
  FaqAttributes({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.locale,
    required this.title,
    required this.supportTitle,
    required this.faqs,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? locale;
  final dynamic title;
  final dynamic supportTitle;
  final List<FaqData> faqs;

  factory FaqAttributes.fromJson(Map<String, dynamic> json){
    return FaqAttributes(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      locale: json["locale"],
      title: json["title"],
      supportTitle: json["support_title"],
      faqs: json["faqs"] == null ? [] : List<FaqData>.from(json["faqs"]!.map((x) => FaqData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "publishedAt": publishedAt?.toIso8601String(),
    "locale": locale,
    "title": title,
    "support_title": supportTitle,
    "faqs": faqs.map((x) => x.toJson()).toList(),
  };

  @override
  String toString(){
    return "$createdAt, $updatedAt, $publishedAt, $locale, $title, $supportTitle, $faqs, ";
  }
}

class FaqData {
  FaqData({
    required this.id,
    required this.question,
    required this.answer,
    required this.title,
  });

  final int? id;
  final String? question;
  final String? answer;
  final String? title;

  factory FaqData.fromJson(Map<String, dynamic> json){
    return FaqData(
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

  @override
  String toString(){
    return "$id, $question, $answer, $title, ";
  }
}

class Meta {
  Meta({
    required this.pagination,
  });

  final FaqPagination? pagination;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      pagination: json["pagination"] == null ? null : FaqPagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "pagination": pagination?.toJson(),
  };

  @override
  String toString(){
    return "$pagination, ";
  }
}

class FaqPagination {
  FaqPagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  factory FaqPagination.fromJson(Map<String, dynamic> json){
    return FaqPagination(
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
  String toString(){
    return "$page, $pageSize, $pageCount, $total, ";
  }
}
