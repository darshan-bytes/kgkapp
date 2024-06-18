import 'package:kgk/kgk.dart';

class CompanyListModel {
  String? image;
  String? title;
  VoidCallback? onTap;

  CompanyListModel({this.image, this.title, this.onTap});

  @override
  bool operator ==(Object other) {
    return other is CompanyListModel && other.image == image && other.title == title && other.onTap == onTap;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ onTap.hashCode;
}
