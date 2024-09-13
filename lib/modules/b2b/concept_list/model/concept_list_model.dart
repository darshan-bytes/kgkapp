import 'package:kgk/kgk.dart';

class ConceptListModel{
  String? id;
  String? name;
  String? designId;
  String? origin;
  ProjectStatus? status;
  String? date;

  ConceptListModel({
    this.id,
    this.name,
    this.designId,
    this.origin,
    this.status,
    this.date,
  });

  factory ConceptListModel.fromJson(Map<String, dynamic> json) {
    return ConceptListModel(
      id: json['id'],
      name: json['name'],
      designId: json['designId'],
      origin: json['origin'],
      status: json['status'],
      date: json['date'],
    );
  }
}