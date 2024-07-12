import 'package:kgk/kgk.dart';

class ExhibitionListingModel {
  String? id;
  String? image;
  String? title;
  String? name;
  String? author;
  String? date;
  String? time;
  String? location;
  String? status;
  List<ExhibitionSubListingModel>? exhibitionSubList = [];
  VoidCallback? onTap;

  ExhibitionListingModel({
    this.id,
    this.image,
    this.title,
    this.name,
    this.author,
    this.date,
    this.time,
    this.location,
    this.status,
    this.exhibitionSubList,
    this.onTap,
  });
}

class ExhibitionSubListingModel {
  String? id;
  String? name;
  String? author;
  String? status;

  ExhibitionSubListingModel({
    this.id,
    this.name,
    this.author,
    this.status,
  });
}
