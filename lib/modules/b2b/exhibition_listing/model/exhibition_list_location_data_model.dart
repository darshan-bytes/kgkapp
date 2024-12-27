class ExhibitionListLocationDataModel {
  String? location;
  List<Data>? data;

  ExhibitionListLocationDataModel({this.location, this.data});

  ExhibitionListLocationDataModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? status;
  String? title;
  String? createdBy;
  String? id;

  Data({this.status, this.title, this.createdBy, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    title = json['title'];
    createdBy = json['created_by'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['title'] = title;
    data['created_by'] = createdBy;
    data['id'] = id;
    return data;
  }
}
