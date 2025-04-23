import 'package:kgk/kgk.dart';

class TemplateListModel {
  String? title;
  List<B2BCustomListingDataModel>? templateSubList = [];

  TemplateListModel({this.title, this.templateSubList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TemplateListModel && other.title == title && other.templateSubList == templateSubList;
  }

  @override
  int get hashCode => title.hashCode ^ templateSubList.hashCode;
}
