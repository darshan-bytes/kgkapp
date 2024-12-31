class ExhibitionListLocationDataModel {
  String? location;
  List<VenueListModel>? data;

  ExhibitionListLocationDataModel({this.location, this.data});

  ExhibitionListLocationDataModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    if (json['data'] != null) {
      data = <VenueListModel>[];
      json['data'].forEach((v) {
        data!.add(new VenueListModel.fromJson(v));
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

class VenueListModel {
  String? status;
  String? title;
  String? createdBy;
  String? id;

  VenueListModel({this.status, this.title, this.createdBy, this.id});

  VenueListModel.fromJson(Map<String, dynamic> json) {
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
