import 'package:kgk/kgk.dart';

class MyOrderDetailsModel {
  String? id;
  String? orderId;
  String? orderDate;
  ProjectStatus orderStatus;
  String? orderTotal;
  String? orderItems;
  String? orderQuantity;

  MyOrderDetailsModel({
    this.id,
    this.orderId,
    this.orderStatus = ProjectStatus.orangeInProgress,
    this.orderDate,
    this.orderTotal,
    this.orderItems,
    this.orderQuantity,
  });
}
