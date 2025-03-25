import 'package:kgk/kgk.dart';

class MyOrderDetailsModel {
  String? id;
  String? orderId;
  String? orderDate;
  ProjectStatus orderStatus;
  String? orderTotal;
  String? orderItems;
  String? orderQuantity;
  String? deliveryDate;
  List<String>? orderImages;
  String? orderedBy;
  String? commodity;

  MyOrderDetailsModel({
    this.id,
    this.orderId,
    this.orderStatus = ProjectStatus.orangeInProgress,
    this.orderDate,
    this.orderTotal,
    this.orderItems,
    this.orderQuantity,
    this.deliveryDate,
    this.orderImages,
    this.orderedBy,
    this.commodity,
  });
}
