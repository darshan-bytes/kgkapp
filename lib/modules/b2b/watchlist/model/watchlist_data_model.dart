import 'package:kgk/kgk.dart';

class WatchlistData {
  String? sId;
  int? userId;
  bool? status;
  String? name;
  List<WatchlistProducts>? products;
  WatchlistDuration? duration;
  String? endDate;
  bool? isDeleted;
  String? deletedAt;
  int? iV;
  DateTime? expiresAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  WatchlistData({
    this.sId,
    this.userId,
    this.status,
    this.name,
    this.products,
    this.duration,
    this.endDate,
    this.expiresAt,
    this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  WatchlistData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    status = json['status'];
    name = json['name'];
    if (json['products'] != null) {
      products = <WatchlistProducts>[];
      json['products'].forEach((v) {
        products!.add(WatchlistProducts.fromJson(v));
      });
    }
    duration = json['duration'] != null ? WatchlistDuration.fromJson(json['duration']) : null;
    endDate = json['endDate'];
    expiresAt = DateTime.tryParse(json["expiresAt"] ?? "");
    isDeleted = json['isDeleted'];
    deletedAt = json['deletedAt'];
    createdAt = DateTime.tryParse(json["createdAt"] ?? "");
    updatedAt = DateTime.tryParse(json["updatedAt"] ?? "");
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['status'] = status;
    data['name'] = name;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    data['endDate'] = endDate;
    data['expiresAt'] = expiresAt?.toIso8601String();
    data['isDeleted'] = isDeleted;
    data['deletedAt'] = deletedAt;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['__v'] = iV;
    return data;
  }
}

extension WatchlistDataExtension on WatchlistData {
  ProjectStatus get displayStatus {
    return status == true ? ProjectStatus.active : ProjectStatus.inActive;
  }

  String get displayFromDate => createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA) ?? "";

  String get displayToDate => expiresAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA) ?? "";
}

class WatchlistProducts {
  String? productId;
  String? commodity;

  bool? notifyOnPriceDrop;
  bool? notifyOnAvailability;
  bool? notifyOnDiscount;
  JewelleryDataModel? jewelleryData;
  DiamondDataModel? diamondData;
  GemstoneDatum? gemstoneData;

  WatchlistProducts({
    this.productId,
    this.commodity,
    this.notifyOnPriceDrop,
    this.notifyOnAvailability,
    this.notifyOnDiscount,
  });

  WatchlistProducts.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    commodity = json['commodity'];
    notifyOnPriceDrop = json['notifyOnPriceDrop'];
    notifyOnAvailability = json['notifyOnAvailability'];
    notifyOnDiscount = json['notifyOnDiscount'];
    if (json['productData'] != null) {
      switch (displayCommodity) {
        case Commodity.diamond:
          diamondData = DiamondDataModel.fromJson(json['productData']);
          break;
        case Commodity.jewellery:
          jewelleryData = JewelleryDataModel.fromJson(json['productData']);
          break;
        case Commodity.gemstone:
          gemstoneData = GemstoneDatum.fromJson(json['productData']);
          break;
        default:
          diamondData = DiamondDataModel.fromJson(json['productData']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['commodity'] = commodity;
    data['notifyOnPriceDrop'] = notifyOnPriceDrop;
    data['notifyOnAvailability'] = notifyOnAvailability;
    data['notifyOnDiscount'] = notifyOnDiscount;
    switch (displayCommodity) {
      case Commodity.diamond:
        data['productData'] = diamondData?.toJson();
        break;
      case Commodity.jewellery:
        data['productData'] = jewelleryData?.toJson();
        break;
      case Commodity.gemstone:
        data['productData'] = gemstoneData?.toJson();
        break;
      default:
        data['productData'] = diamondData?.toJson();
    }
    return data;
  }
}

extension WatchlistProductsExtension on WatchlistProducts {
  Commodity get displayCommodity =>
      Commodity.values.firstWhereOrNull((element) => element.value == commodity?.toLowerCase()) ?? Commodity.diamond;
}

class NotificationSettings {
  bool? notifyOnPriceDrop;
  bool? notifyOnAvailability;
  bool? notifyOnDiscount;
  int? notifyBeforeEndDate;

  NotificationSettings({this.notifyOnPriceDrop, this.notifyOnAvailability, this.notifyOnDiscount, this.notifyBeforeEndDate});

  NotificationSettings.fromJson(Map<String, dynamic> json) {
    notifyOnPriceDrop = json['notifyOnPriceDrop'];
    notifyOnAvailability = json['notifyOnAvailability'];
    notifyOnDiscount = json['notifyOnDiscount'];
    notifyBeforeEndDate = json['notifyBeforeEndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notifyOnPriceDrop'] = notifyOnPriceDrop;
    data['notifyOnAvailability'] = notifyOnAvailability;
    data['notifyOnDiscount'] = notifyOnDiscount;
    data['notifyBeforeEndDate'] = notifyBeforeEndDate;
    return data;
  }
}

class WatchlistDuration {
  int? hours;
  int? minutes;
  int? days;

  WatchlistDuration({this.hours, this.minutes, this.days});

  WatchlistDuration.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    minutes = json['minutes'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hours'] = hours;
    data['minutes'] = minutes;
    data['days'] = days;
    return data;
  }
}

extension WatchlistDurationExtension on WatchlistDuration {
  Duration get durationExt {
    return Duration(days: days ?? 0, hours: hours ?? 0, minutes: minutes ?? 0);
  }

  String get displayDuration {
    return '${days ?? 0}d ${hours ?? 0}h ${minutes ?? 0}m';
  }
}
