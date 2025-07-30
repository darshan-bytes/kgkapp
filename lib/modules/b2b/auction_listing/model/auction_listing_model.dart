import 'package:kgk/kgk.dart';

class AuctionListingModel {
  AuctionListingModel({
    required this.filteredRecords,
    required this.totalRecords,
    required this.data,
    required this.page,
    required this.limit,
  });

  int? filteredRecords;
  int? totalRecords;
  List<AuctionDatum> data;
  int? page;
  int? limit;

  AuctionListingModel copyWith({int? filteredRecords, int? totalRecords, List<AuctionDatum>? data, int? page, int? limit}) {
    return AuctionListingModel(
      filteredRecords: filteredRecords ?? this.filteredRecords,
      totalRecords: totalRecords ?? this.totalRecords,
      data: data ?? this.data,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  factory AuctionListingModel.fromJson(Map<String, dynamic> json) {
    return AuctionListingModel(
      filteredRecords: json["filteredRecords"],
      totalRecords: json["totalRecords"],
      data: json["data"] == null ? [] : List<AuctionDatum>.from(json["data"]!.map((x) => AuctionDatum.fromJson(x))),
      page: json["page"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
    "filteredRecords": filteredRecords,
    "totalRecords": totalRecords,
    "data": data.map((x) => x.toJson()).toList(),
    "page": page,
    "limit": limit,
  };

  @override
  String toString() {
    return "$filteredRecords, $totalRecords, $data, $page, $limit, ";
  }
}

class AuctionDatum {
  AuctionDatum({
    required this.auctionId,
    required this.productDescription,
    required this.productImage,
    required this.type,
    required this.productSku,
    required this.productId,
    required this.createdAt,
    required this.auctionStatus,
    required this.bidAmount,
    this.status = ProjectStatus.onGoing,
  });

  final String? auctionId;
  final String? productDescription;
  final String? productImage;
  final String? type;
  final String? productSku;
  final String? productId;
  final DateTime? createdAt;
  final String? auctionStatus;
  final String? bidAmount;
  final ProjectStatus status;

  AuctionDatum copyWith({
    String? auctionId,
    String? productDescription,
    String? productImage,
    String? type,
    String? productSku,
    String? productId,
    DateTime? createdAt,
    String? auctionStatus,
    String? bidAmount,
    ProjectStatus? status,
  }) {
    return AuctionDatum(
      auctionId: auctionId ?? this.auctionId,
      productDescription: productDescription ?? this.productDescription,
      productImage: productImage ?? this.productImage,
      type: type ?? this.type,
      productSku: productSku ?? this.productSku,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      auctionStatus: auctionStatus ?? this.auctionStatus,
      bidAmount: bidAmount ?? this.bidAmount,
      status: status ?? this.status,
    );
  }

  factory AuctionDatum.fromJson(Map<String, dynamic> json) {
    return AuctionDatum(
      auctionId: json["auction_id"],
      productDescription: json["product_description"],
      productImage: json["product_image"],
      type: json["type"],
      productSku: json["product_sku"],
      productId: json["product_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      auctionStatus: json["auction_status"],
      bidAmount: json["bid_amount"],
      status: json["status"] != null ? getAuctionStatus(auctionStatus: json["status"]) : ProjectStatus.onGoing,
    );
  }

  Map<String, dynamic> toJson() => {
    "auction_id": auctionId,
    "product_description": productDescription,
    "product_image": productImage,
    "type": type,
    "product_sku": productSku,
    "product_id": productId,
    "created_at": createdAt?.toIso8601String(),
    "auction_status": auctionStatus,
    "bid_amount": bidAmount,
    "status": status,
  };

  static ProjectStatus getAuctionStatus({required String auctionStatus}) {
    switch (auctionStatus) {
      case "ONGOING":
        return ProjectStatus.onGoing;
      case "WIN":
        return ProjectStatus.winner;
      case "LOST":
        return ProjectStatus.lost;
      case "EXPIRED":
        return ProjectStatus.expired;
      default:
        return ProjectStatus.onGoing;
    }
  }

  @override
  String toString() {
    return "$auctionId, $productDescription, $productImage, $type, $productSku, $productId, $createdAt, $auctionStatus, $bidAmount, $status, ";
  }
}
