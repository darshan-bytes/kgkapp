import 'package:kgk/kgk.dart';

class PlaceOrderResponse {
  PlaceOrderResponse({
    required this.createdAt,
    required this.updatedAt,
    required this.orderFor,
    required this.orderContext,
    required this.orderContextId,
    required this.products,
    required this.shippingAddressId,
    required this.billingAddressId,
    required this.totalPrice,
    required this.subTotal,
    required this.totalPercentage,
    required this.currency,
    required this.currentCurrencyRate,
    required this.productDescription,
    required this.createdBy,
    required this.orderStatus,
    required this.metaInfo,
    required this.name,
    required this.email,
    required this.phone,
    required this.commodity,
    required this.userType,
    required this.charges,
    required this.promoCode,
    required this.id,
    required this.isDeleted,
    required this.deletedAt,
    required this.uniqueId,
    required this.v,
    required this.items,
    required this.totalQuantity,
    required this.createdByDetails,
    required this.shippingAddressDetails,
    required this.billingAddressDetails,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderFor;
  final String? orderContext;
  final String? orderContextId;
  final List<OrderProduct> products;
  final String? shippingAddressId;
  final String? billingAddressId;
  final String? totalPrice;
  final String? subTotal;
  final String? totalPercentage;
  final String? currency;
  final String? currentCurrencyRate;
  final String? productDescription;
  final String? createdBy;
  final String? orderStatus;
  final MetaInfo? metaInfo;
  final String? name;
  final String? email;
  final String? phone;
  final String? commodity;
  final String? userType;
  final List<BagOrderCharge> charges;
  final BagOrderCharge? promoCode;
  final String? id;
  final bool? isDeleted;
  final dynamic deletedAt;
  final String? uniqueId;
  final String? v;
  final int? items;
  final int? totalQuantity;
  final UserIdDetails? createdByDetails;
  final AddressDetails? shippingAddressDetails;
  final AddressDetails? billingAddressDetails;

  PlaceOrderResponse copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? orderFor,
    String? orderContext,
    String? orderContextId,
    List<OrderProduct>? products,
    String? shippingAddressId,
    String? billingAddressId,
    String? totalPrice,
    String? subTotal,
    String? totalPercentage,
    String? currency,
    dynamic currentCurrencyRate,
    dynamic productDescription,
    String? createdBy,
    String? orderStatus,
    MetaInfo? metaInfo,
    String? name,
    String? email,
    String? phone,
    String? commodity,
    String? userType,
    List<BagOrderCharge>? charges,
    BagOrderCharge? promoCode,
    String? id,
    bool? isDeleted,
    dynamic deletedAt,
    String? uniqueId,
    String? v,
    int? filteredRecords,
    int? totalRecords,
    int? items,
    int? totalQuantity,
    UserIdDetails? createdByDetails,
    AddressDetails? shippingAddressDetails,
    AddressDetails? billingAddressDetails,
  }) {
    return PlaceOrderResponse(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      orderFor: orderFor ?? this.orderFor,
      orderContext: orderContext ?? this.orderContext,
      orderContextId: orderContextId ?? this.orderContextId,
      products: products ?? this.products,
      shippingAddressId: shippingAddressId ?? this.shippingAddressId,
      billingAddressId: billingAddressId ?? this.billingAddressId,
      totalPrice: totalPrice ?? this.totalPrice,
      subTotal: subTotal ?? this.subTotal,
      totalPercentage: totalPercentage ?? this.totalPercentage,
      currency: currency ?? this.currency,
      currentCurrencyRate: currentCurrencyRate ?? this.currentCurrencyRate,
      productDescription: productDescription ?? this.productDescription,
      createdBy: createdBy ?? this.createdBy,
      orderStatus: orderStatus ?? this.orderStatus,
      metaInfo: metaInfo ?? this.metaInfo,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      commodity: commodity ?? this.commodity,
      userType: userType ?? this.userType,
      charges: charges ?? this.charges,
      promoCode: promoCode ?? this.promoCode,
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      uniqueId: uniqueId ?? this.uniqueId,
      v: v ?? this.v,
      items: items ?? this.items,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      createdByDetails: createdByDetails ?? this.createdByDetails,
      shippingAddressDetails: shippingAddressDetails ?? this.shippingAddressDetails,
      billingAddressDetails: billingAddressDetails ?? this.billingAddressDetails,
    );
  }

  factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    return PlaceOrderResponse(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      orderFor: json["order_for"],
      orderContext: json["order_context"],
      orderContextId: json["order_context_id"],
      products: json["products"] == null ? [] : List<OrderProduct>.from(json["products"]!.map((x) => OrderProduct.fromJson(x))),
      shippingAddressId: json["shipping_address_id"],
      billingAddressId: json["billing_address_id"],
      totalPrice: json["total_price"]?.toString(),
      subTotal: json["sub_total"]?.toString(),
      totalPercentage: json["total_percentage"]?.toString(),
      currency: json["currency"]?.toString(),
      currentCurrencyRate: json["current_currency_rate"]?.toString(),
      productDescription: json["product_description"],
      createdBy: json["created_by"]?.toString(),
      orderStatus: json["order_status"],
      metaInfo: json["meta_info"] == null ? null : MetaInfo.fromJson(json["meta_info"]),
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      commodity: json["commodity"],
      userType: json["user_type"],
      charges: json["charges"] == null ? [] : List<BagOrderCharge>.from(json["charges"]!.map((x) => BagOrderCharge.fromJson(x))),
      promoCode: json["promo_code"] == null ? null : BagOrderCharge.fromJson(json["promo_code"]),
      id: json["_id"],
      isDeleted: json["isDeleted"],
      deletedAt: json["deletedAt"],
      uniqueId: json["unique_id"]?.toString(),
      v: json["__v"]?.toString(),
      items: json["total_items"],
      totalQuantity: json["quantity"],
      createdByDetails: json["created_by_details"] == null ? null : UserIdDetails.fromJson(json["created_by_details"]),
      shippingAddressDetails: json["shipping_address_detail"] == null ? null : AddressDetails.fromJson(json["shipping_address_detail"]),
      billingAddressDetails: json["billing_address_detail"] == null ? null : AddressDetails.fromJson(json["billing_address_detail"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "order_for": orderFor,
        "order_context": orderContext,
        "order_context_id": orderContextId,
        "products": products.map((x) => x.toJson()).toList(),
        "shipping_address_id": shippingAddressId,
        "billing_address_id": billingAddressId,
        "total_price": totalPrice,
        "sub_total": subTotal,
        "total_percentage": totalPercentage,
        "currency": currency,
        "current_currency_rate": currentCurrencyRate,
        "product_description": productDescription,
        "created_by": createdBy,
        "order_status": orderStatus,
        "meta_info": metaInfo?.toJson(),
        "name": name,
        "email": email,
        "phone": phone,
        "commodity": commodity,
        "user_type": userType,
        "charges": charges.map((x) => x.toJson()).toList(),
        "promo_code": promoCode?.toJson(),
        "_id": id,
        "isDeleted": isDeleted,
        "deletedAt": deletedAt,
        "unique_id": uniqueId,
        "__v": v,
        "items": items,
        "quantity": totalQuantity,
        "created_by_details": createdByDetails?.toJson(),
        "shipping_address_detail": shippingAddressDetails?.toJson(),
        "billing_address_detail": billingAddressDetails?.toJson(),
      };
}

class MetaInfo {
  MetaInfo({
    required this.paymentCondition,
    required this.discount,
    required this.comments,
  });

  final String? paymentCondition;
  final double? discount;
  final String? comments;

  MetaInfo copyWith({
    String? paymentCondition,
    double? discount,
    String? comments,
  }) {
    return MetaInfo(
      paymentCondition: paymentCondition ?? this.paymentCondition,
      discount: discount ?? this.discount,
      comments: comments ?? this.comments,
    );
  }

  factory MetaInfo.fromJson(Map<String, dynamic> json) {
    return MetaInfo(
      paymentCondition: json["paymentCondition"],
      discount: json["discount"]?.toString().toDouble,
      comments: json["comments"],
    );
  }

  Map<String, dynamic> toJson() => {
        "paymentCondition": paymentCondition,
        "discount": discount,
        "comments": comments,
      };
}

class OrderProduct {
  OrderProduct({
    required this.suid,
    required this.quantity,
    required this.discPercentage,
    required this.id,
    required this.productId,
    required this.productProductId,
    required this.productDescription,
    required this.ctsOrGms,
    required this.yourRate,
    required this.yourDiscount,
    required this.yourAmount,
    required this.originalAmount,
    required this.originalRate,
    required this.image,
  });

  final String? suid;
  final int? quantity;
  final double? discPercentage;
  final String? id;
  final String? productId;
  final String? productProductId;
  final String? productDescription;
  final double? ctsOrGms;
  final String? yourRate;
  final String? yourDiscount;
  final String? yourAmount;
  final String? originalAmount;
  final String? originalRate;
  final String? image;

  OrderProduct copyWith({
    String? suid,
    int? quantity,
    double? discPercentage,
    String? id,
    String? productId,
    String? productProductId,
    String? productDescription,
    double? ctsOrGms,
    String? yourRate,
    String? yourDiscount,
    String? yourAmount,
    String? originalAmount,
    String? originalRate,
    String? image,
  }) {
    return OrderProduct(
      suid: suid ?? this.suid,
      quantity: quantity ?? this.quantity,
      discPercentage: discPercentage ?? this.discPercentage,
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productProductId: productProductId ?? this.productProductId,
      productDescription: productDescription ?? this.productDescription,
      ctsOrGms: ctsOrGms ?? this.ctsOrGms,
      yourRate: yourRate ?? this.yourRate,
      yourDiscount: yourDiscount ?? this.yourDiscount,
      yourAmount: yourAmount ?? this.yourAmount,
      originalAmount: originalAmount ?? this.originalAmount,
      originalRate: originalRate ?? this.originalRate,
      image: image ?? this.image,
    );
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      suid: json["suid"],
      quantity: json["quantity"]?.toString().toInt,
      discPercentage: json["disc_percentage"]?.toString().toDouble,
      id: json["_id"],
      productId: json["id"],
      productProductId: json["productId"],
      productDescription: json["product_description"],
      ctsOrGms: json["cts_or_gms"]?.toString().toDouble,
      yourRate: json["your_rate"]?.toString(),
      yourDiscount: json["your_discount"]?.toString(),
      yourAmount: json["your_amount"]?.toString(),
      originalAmount: json["original_amount"]?.toString(),
      originalRate: json["original_rate"]?.toString(),
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "suid": suid,
        "quantity": quantity,
        "disc_percentage": discPercentage,
        "_id": id,
        "id": productId,
        "productId": productProductId,
        "product_description": productDescription,
        "cts_or_gms": ctsOrGms,
        "your_rate": yourRate,
        "your_discount": yourDiscount,
        "your_amount": yourAmount,
        "original_amount": originalAmount,
        "original_rate": originalRate,
        "image": image,
      };
}

extension PlaceOrderModelExt on PlaceOrderResponse {
  String get getOrderDate {
    if (createdAt == null) return '';
    return createdAt!.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2);
  }

  ProjectStatus? get getOrderStatus {
    switch (orderStatus) {
      case "pending":
        return ProjectStatus.pending;
      case "completed":
        return ProjectStatus.completed;
      case "cancelled":
        return ProjectStatus.cancelled;
      case "on-going":
        return ProjectStatus.onGoing;
      default:
        return null;
    }
  }
}
