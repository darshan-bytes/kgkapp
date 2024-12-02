class SortOptionsModel {
  SortOptionsModel({
    required this.commodity,
    required this.data,
  });

  final String? commodity;
  final List<SortOptions> data;

  SortOptionsModel copyWith({
    String? commodity,
    List<SortOptions>? data,
  }) {
    return SortOptionsModel(
      commodity: commodity ?? this.commodity,
      data: data ?? this.data,
    );
  }

  factory SortOptionsModel.fromJson(Map<String, dynamic> json) {
    return SortOptionsModel(
      commodity: json["commodity"],
      data: json["data"] == null ? [] : List<SortOptions>.from(json["data"]!.map((x) => SortOptions.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "commodity": commodity,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class SortOptions {
  SortOptions({
    required this.label,
    required this.sortKey,
    required this.sortValue,
  });

  final String? label;
  final String? sortKey;
  final String? sortValue;

  SortOptions copyWith({
    String? label,
    String? sortKey,
    String? sortValue,
  }) {
    return SortOptions(
      label: label ?? this.label,
      sortKey: sortKey ?? this.sortKey,
      sortValue: sortValue ?? this.sortValue,
    );
  }

  factory SortOptions.fromJson(Map<String, dynamic> json) {
    return SortOptions(
      label: json["label"],
      sortKey: json["sort_key"],
      sortValue: json["sort_value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "label": label,
        "sort_key": sortKey,
        "sort_value": sortValue,
      };
}
