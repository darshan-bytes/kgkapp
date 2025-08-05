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
  MetaInfo({required this.paymentCondition, required this.discount, required this.comments});

  final String? paymentCondition;
  final double? discount;
  final String? comments;

  MetaInfo copyWith({String? paymentCondition, double? discount, String? comments}) {
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

  Map<String, dynamic> toJson() => {"paymentCondition": paymentCondition, "discount": discount, "comments": comments};
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
    required this.ourAmount,
    required this.originalAmount,
    required this.originalRate,
    required this.image,
    required this.customizationData,
    required this.orderProductId,
    required this.ourRate,
    required this.ourDiscount,
    required this.yourOriginalAmount,
    required this.jewellery,
    required this.diamond,
    required this.styleNo,
  });

  final String? suid;
  final int? quantity;
  final double? discPercentage;
  final dynamic customizationData;
  final String? id;
  final String? productId;
  final String? productProductId;
  final String? productDescription;
  final double? ctsOrGms;
  final String? yourRate;
  final String? yourDiscount;
  final String? yourAmount;
  final String? ourAmount;
  final String? originalAmount;
  final String? originalRate;
  final String? image;
  final String? orderProductId;
  final String? ourRate;
  final String? ourDiscount;
  final String? yourOriginalAmount;
  final OrderJewelleryProduct? jewellery;
  final OrderDiamondProduct? diamond;
  final String? styleNo;

  //style_no

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
      ourAmount: json["our_amount"]?.toString(),
      originalAmount: json["original_amount"]?.toString(),
      originalRate: json["original_rate"]?.toString(),
      image: json["image"],
      customizationData: json["customization_data"],
      orderProductId: json["id"],
      ourRate: json["our_rate"]?.toString(),
      ourDiscount: json["our_discount"]?.toString(),
      yourOriginalAmount: json["your_original_amount"]?.toString(),
      jewellery: json["jewellery"] == null ? null : OrderJewelleryProduct.fromJson(json["jewellery"]),
      diamond: json["diamond"] == null ? null : OrderDiamondProduct.fromJson(json["diamond"]),
      styleNo: json["style_no"],
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
    "our_amount": ourAmount,
    "original_amount": originalAmount,
    "original_rate": originalRate,
    "image": image,
    "customization_data": customizationData,
    "order_product_id": orderProductId,
    "our_rate": ourRate,
    "our_discount": ourDiscount,
    "your_original_amount": yourOriginalAmount,
    "jewellery": jewellery?.toJson(),
    "diamond": diamond?.toJson(),
    "style_no": styleNo,
  };
}

extension PlaceOrderModelExt on PlaceOrderResponse {
  String get getOrderDate {
    if (createdAt == null) return '';
    return createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2) ?? '';
  }

  Commodity? get getCommodity {
    return Commodity.values.firstWhereOrNull((element) => element.name.toLowerCase() == commodity?.toLowerCase());
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
      case "delay":
        return ProjectStatus.delay;
      default:
        return null;
    }
  }
}

class OrderDiamondProduct {
  OrderDiamondProduct({
    required this.id,
    required this.productDescription,
    required this.productId,
    required this.rappaportPrice,
    required this.yourRate,
    required this.yourDiscount,
    required this.yourAmount,
    required this.yourOriginalAmount,
    required this.originalAmount,
    required this.originalRate,
    required this.image,
    required this.suid,
  });

  final String? id;
  final String? productDescription;
  final String? productId;
  final String? rappaportPrice;
  final double? yourRate;
  final double? yourDiscount;
  final double? yourAmount;
  final double? yourOriginalAmount;
  final double? originalAmount;
  final double? originalRate;
  final String? image;
  final String? suid;

  factory OrderDiamondProduct.fromJson(Map<String, dynamic> json) {
    return OrderDiamondProduct(
      id: json["id"],
      productDescription: json["product_description"],
      productId: json["productId"],
      rappaportPrice: json["rappaport_price"],
      yourRate: json["your_rate"]?.toString().toDouble,
      yourDiscount: json["your_discount"]?.toString().toDouble,
      yourAmount: json["your_amount"]?.toString().toDouble,
      yourOriginalAmount: json["your_original_amount"]?.toString().toDouble,
      originalAmount: json["original_amount"]?.toString().toDouble,
      originalRate: json["original_rate"]?.toString().toDouble,
      image: json["image"],
      suid: json["suid"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_description": productDescription,
    "productId": productId,
    "rappaport_price": rappaportPrice,
    "your_rate": yourRate,
    "your_discount": yourDiscount,
    "your_amount": yourAmount,
    "your_original_amount": yourOriginalAmount,
    "original_amount": originalAmount,
    "original_rate": originalRate,
    "image": image,
    "suid": suid,
  };
}

class OrderJewelleryProduct {
  OrderJewelleryProduct({
    required this.id,
    required this.productId,
    required this.productDescription,
    required this.kgkCollection,
    required this.yourRate,
    required this.yourDiscount,
    required this.yourAmount,
    required this.yourOriginalAmount,
    required this.originalAmount,
    required this.originalRate,
    required this.suid,
    required this.styleNo,
    required this.image,
    required this.jewelleryType,
    required this.metalKaratage,
  });

  final String? id;
  final String? productId;
  final String? productDescription;
  final String? kgkCollection;
  final double? yourRate;
  final double? yourDiscount;
  final double? yourAmount;
  final double? yourOriginalAmount;
  final double? originalAmount;
  final double? originalRate;
  final String? suid;
  final String? styleNo;
  final String? image;
  final String? jewelleryType;
  final dynamic metalKaratage;

  factory OrderJewelleryProduct.fromJson(Map<String, dynamic> json) {
    return OrderJewelleryProduct(
      id: json["id"],
      productId: json["productId"],
      productDescription: json["product_description"],
      kgkCollection: json["kgk_collection"],
      yourRate: json["your_rate"]?.toString().toDouble,
      yourDiscount: json["your_discount"]?.toString().toDouble,
      yourAmount: json["your_amount"]?.toString().toDouble,
      yourOriginalAmount: json["your_original_amount"]?.toString().toDouble,
      originalAmount: json["original_amount"]?.toString().toDouble,
      originalRate: json["original_rate"]?.toString().toDouble,
      suid: json["suid"],
      styleNo: json["style_no"],
      image: json["image"],
      jewelleryType: json["jewellery_type"],
      metalKaratage: json["metal_karatage"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "product_description": productDescription,
    "kgk_collection": kgkCollection,
    "your_rate": yourRate,
    "your_discount": yourDiscount,
    "your_amount": yourAmount,
    "your_original_amount": yourOriginalAmount,
    "original_amount": originalAmount,
    "original_rate": originalRate,
    "suid": suid,
    "style_no": styleNo,
    "image": image,
    "jewellery_type": jewelleryType,
    "metal_karatage": metalKaratage,
  };
}
