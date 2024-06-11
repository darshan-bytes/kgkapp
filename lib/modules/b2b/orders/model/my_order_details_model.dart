import 'package:kgk/kgk.dart';

class MyOrderDetailsModel {
  String? id;
  String? orderId;
  String? orderDate;
  OrderStatus orderStatus;
  String? orderTotal;
  String? orderItems;
  String? orderQuantity;

  MyOrderDetailsModel({
    this.id,
    this.orderId,
    this.orderStatus = OrderStatus.inProgress,
    this.orderDate,
    this.orderTotal,
    this.orderItems,
    this.orderQuantity,
  });
}
