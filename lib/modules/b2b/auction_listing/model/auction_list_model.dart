import 'package:kgk/kgk.dart';

class AuctionListModel {
  String? id;
  String? name;
  String? imageUrl;
  String? skuNo;
  OrderStatus orderStatus;
  String? type;
  String? bidAmount;
  String? bidPlacedOn;

  AuctionListModel({
    this.id,
    this.name,
    this.imageUrl,
    this.skuNo,
    this.type,
    this.orderStatus = OrderStatus.onGoing,
    this.bidAmount,
    this.bidPlacedOn,
  });
}
