import 'package:kgk/kgk.dart';

class ExhibitionDetailsOrdersModel {
  String? totalAmount;
  String? orderName;
  String? market;
  String? marketImageUrl;
  String? items;
  String? approvedByImageUrl;
  String? approvedBy;
  int? id;

  ExhibitionDetailsOrdersModel({
    this.totalAmount,
    this.orderName,
    this.market,
    this.marketImageUrl,
    this.items,
    this.approvedByImageUrl,
    this.approvedBy,
    this.id,
  });

  @override
  bool operator ==(Object other) {
    return other is ExhibitionDetailsOrdersModel && other.orderName == orderName && other.id == id;
  }

  @override
  int get hashCode => orderName.hashCode ^ id.hashCode;
}
