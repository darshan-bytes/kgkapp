class WishlistFilterOptionModel {
  String? sId;
  String? moduleName;
  List<Filters>? filters;
  List<String>? sortFields;

  WishlistFilterOptionModel({this.sId, this.moduleName, this.filters, this.sortFields});

  WishlistFilterOptionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    moduleName = json['module_name'];
    if (json['filters'] != null) {
      filters = <Filters>[];
      json['filters'].forEach((v) {
        filters!.add(Filters.fromJson(v));
      });
    }
    sortFields = json['sort_fields']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['module_name'] = moduleName;
    if (filters != null) {
      data['filters'] = filters!.map((v) => v.toJson()).toList();
    }
    data['sort_fields'] = sortFields;
    return data;
  }
}

class Filters {
  String? type;
  String? title;
  String? key;
  bool? isMultipleSelection;
  List<Options>? options;

  Filters({this.type, this.title, this.key, this.isMultipleSelection, this.options});

  Filters.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    key = json['key'];
    isMultipleSelection = json['is_multiple_selection'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['key'] = key;
    data['is_multiple_selection'] = isMultipleSelection;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? label;
  String? value;

  Options({this.label, this.value});

  Options.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}
