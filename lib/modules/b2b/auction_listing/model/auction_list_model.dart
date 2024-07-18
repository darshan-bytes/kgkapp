import 'package:kgk/kgk.dart';

class AuctionListModel {
  String? id;
  String? name;
  String? imageUrl;
  String? skuNo;
  ProjectStatus orderStatus;
  String? type;
  String? bidAmount;
  String? bidPlacedOn;
  String? percentageOff;

  AuctionListModel({
    this.id,
    this.name,
    this.imageUrl,
    this.skuNo,
    this.type,
    this.orderStatus = ProjectStatus.onGoing,
    this.bidAmount,
    this.bidPlacedOn,
    this.percentageOff,
  });
}
