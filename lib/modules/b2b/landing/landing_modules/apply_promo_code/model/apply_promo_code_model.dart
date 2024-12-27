import 'package:kgk/kgk.dart';

class ApplyPromoCodeModel {
  String? id;
  String? title;
  String? code;
  String? type;
  int? value;
  String? startDate;
  String? endDate;
  int? createdBy;
  String? description;
  String? status;

  ApplyPromoCodeModel(
      {this.id, this.title, this.code, this.type, this.value, this.startDate, this.endDate, this.createdBy, this.description, this.status});

  ApplyPromoCodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    type = json['type'];
    value = json['value'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdBy = json['created_by'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['type'] = type;
    data['value'] = value;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_by'] = createdBy;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}

extension ApplyPromoCodeModelExtension on ApplyPromoCodeModel {
  String get offerValidTillEXT {
    if (endDate == null) {
      return '';
    }

    return APPStrings.offerValidTillX.tr.interpolate(["${startDate ?? ""} - ${endDate ?? ""}"]);
  }
}
