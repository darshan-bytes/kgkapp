class SortOptionsModel {
  SortOptionsModel({required this.commodity, required this.data});

  final String? commodity;
  final List<SortOptions> data;

  SortOptionsModel copyWith({String? commodity, List<SortOptions>? data}) {
    return SortOptionsModel(commodity: commodity ?? this.commodity, data: data ?? this.data);
  }

  factory SortOptionsModel.fromJson(Map<String, dynamic> json) {
    return SortOptionsModel(
      commodity: json["commodity"],
      data: json["data"] == null ? [] : List<SortOptions>.from(json["data"]!.map((x) => SortOptions.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {"commodity": commodity, "data": data.map((x) => x.toJson()).toList()};
}

class SortOptions {
  String? name;
  String? sortKey;
  String? sortValue;
  bool? isDefault;

  SortOptions({this.name, this.sortKey, this.sortValue, this.isDefault});

  SortOptions.fromJson(Map<String, dynamic> json) {
    name = json['label'];
    sortKey = json['sort_key'];
    sortValue = json['sort_value'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = name;
    data['sort_key'] = sortKey;
    data['sort_value'] = sortValue;
    data['is_default'] = isDefault;
    return data;
  }
}
