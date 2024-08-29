import 'package:kgk/kgk.dart';

class WatchlistData {
  String? sId;
  int? userId;
  bool? status;
  String? name;
  List<WatchlistProducts>? products;
  WatchlistDuration? duration;
  String? endDate;
  String? expiresAt;
  bool? isDeleted;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

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
    expiresAt = json['expiresAt'];
    isDeleted = json['isDeleted'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['expiresAt'] = expiresAt;
    data['isDeleted'] = isDeleted;
    data['deletedAt'] = deletedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

extension WatchlistDataExtension on WatchlistData {
  ProjectStatus get displayStatus {
    // ProjectStatus.active;
    return status == true ? ProjectStatus.active : ProjectStatus.inActive;
  }
}

class WatchlistProducts {
  String? productId;
  String? commodity;
  NotificationSettings? notificationSettings;

  WatchlistProducts({this.productId, this.commodity, this.notificationSettings});

  WatchlistProducts.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    commodity = json['commodity'];
    notificationSettings = json['notificationSettings'] != null ? NotificationSettings.fromJson(json['notificationSettings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['commodity'] = commodity;
    if (notificationSettings != null) {
      data['notificationSettings'] = notificationSettings!.toJson();
    }
    return data;
  }
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
  String get displayDuration {
    return '${hours ?? 0}h : ${minutes ?? 0}m : ${days ?? 0}s';
  }
}
