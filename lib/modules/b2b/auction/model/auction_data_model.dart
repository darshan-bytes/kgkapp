import 'package:kgk/kgk.dart';

class AuctionDataModel {
  AuctionDataModel({
    required this.businessType,
    required this.productId,
    required this.productSku,
    required this.productDescription,
    required this.productImage,
    required this.startDate,
    required this.endDate,
    required this.startingPrice,
    required this.createdBy,
    required this.status,
    required this.currency,
    required this.cscCodes,
    required this.id,
    required this.lastBidAmount,
    required this.updatedBy,
    required this.createdAt,
    required this.bids,
    required this.showPlaceBid,
    required this.myBidValue,
    required this.totalBid,
    required this.createdByDetails,
    required this.updatedByDetails,
  });

  final String? businessType;
  final String? productId;
  final String? productSku;
  final String? productDescription;
  final String? productImage;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? startingPrice;
  final String? createdBy;
  final String? status;
  final String? currency;
  final String? cscCodes;
  final String? id;
  final dynamic lastBidAmount;
  final dynamic updatedBy;
  final DateTime? createdAt;
  final List<Bid> bids;
  final bool? showPlaceBid;
  final String? myBidValue;
  final int? totalBid;
  final CreatedByDetails? createdByDetails;
  final UpdatedByDetails? updatedByDetails;

  AuctionDataModel copyWith({
    String? businessType,
    String? productId,
    String? productSku,
    String? productDescription,
    String? productImage,
    DateTime? startDate,
    DateTime? endDate,
    String? startingPrice,
    String? createdBy,
    String? status,
    String? currency,
    String? cscCodes,
    String? id,
    dynamic lastBidAmount,
    dynamic updatedBy,
    DateTime? createdAt,
    List<Bid>? bids,
    bool? showPlaceBid,
    String? myBidValue,
    int? totalBid,
    CreatedByDetails? createdByDetails,
    UpdatedByDetails? updatedByDetails,
  }) {
    return AuctionDataModel(
      businessType: businessType ?? this.businessType,
      productId: productId ?? this.productId,
      productSku: productSku ?? this.productSku,
      productDescription: productDescription ?? this.productDescription,
      productImage: productImage ?? this.productImage,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startingPrice: startingPrice ?? this.startingPrice,
      createdBy: createdBy ?? this.createdBy,
      status: status ?? this.status,
      currency: currency ?? this.currency,
      cscCodes: cscCodes ?? this.cscCodes,
      id: id ?? this.id,
      lastBidAmount: lastBidAmount ?? this.lastBidAmount,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      bids: bids ?? this.bids,
      showPlaceBid: showPlaceBid ?? this.showPlaceBid,
      myBidValue: myBidValue ?? this.myBidValue,
      totalBid: totalBid ?? this.totalBid,
      createdByDetails: createdByDetails ?? this.createdByDetails,
      updatedByDetails: updatedByDetails ?? this.updatedByDetails,
    );
  }

  factory AuctionDataModel.fromJson(Map<String, dynamic> json) {
    return AuctionDataModel(
      businessType: json["business_type"],
      productId: json["product_id"],
      productSku: json["product_sku"],
      productDescription: json["product_description"],
      productImage: json["product_image"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      startingPrice: json["starting_price"],
      createdBy: json["created_by"],
      status: json["status"],
      currency: json["currency"],
      cscCodes: json["csc_codes"],
      id: json["id"],
      lastBidAmount: json["last_bid_amount"],
      updatedBy: json["updated_by"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      bids: json["bids"] == null ? [] : List<Bid>.from(json["bids"]!.map((x) => Bid.fromJson(x))),
      showPlaceBid: json["show_place_bid"],
      myBidValue: json["my_bid_value"],
      totalBid: json["total_bid"],
      createdByDetails: json["created_by_details"] == null ? null : CreatedByDetails.fromJson(json["created_by_details"]),
      updatedByDetails: json["updated_by_details"] == null ? null : UpdatedByDetails.fromJson(json["updated_by_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "business_type": businessType,
        "product_id": productId,
        "product_sku": productSku,
        "product_description": productDescription,
        "product_image": productImage,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "starting_price": startingPrice,
        "created_by": createdBy,
        "status": status,
        "currency": currency,
        "csc_codes": cscCodes,
        "id": id,
        "last_bid_amount": lastBidAmount,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "bids": bids.map((x) => x.toJson()).toList(),
        "show_place_bid": showPlaceBid,
        "my_bid_value": myBidValue,
        "total_bid": totalBid,
        "created_by_details": createdByDetails?.toJson(),
        "updated_by_details": updatedByDetails?.toJson(),
      };

  @override
  String toString() {
    return "$businessType, $productId, $productSku, $productDescription, $productImage, $startDate, $endDate, $startingPrice, $createdBy, $status, $currency, $cscCodes, $id, $lastBidAmount, $updatedBy, $createdAt, $bids, $showPlaceBid, $myBidValue, $totalBid, $createdByDetails, $updatedByDetails, ";
  }
}

class Bid {
  Bid({
    required this.auctionId,
    required this.bidAmount,
    required this.country,
    required this.id,
    required this.isWinner,
    required this.createdAt,
    required this.isMyBid,
  });

  final String? auctionId;
  final String? bidAmount;
  final String? country;
  final String? id;
  final bool? isWinner;
  final DateTime? createdAt;
  final bool? isMyBid;

  Bid copyWith({
    String? auctionId,
    String? bidAmount,
    String? country,
    String? id,
    bool? isWinner,
    DateTime? createdAt,
    bool? isMyBid,
  }) {
    return Bid(
      auctionId: auctionId ?? this.auctionId,
      bidAmount: bidAmount ?? this.bidAmount,
      country: country ?? this.country,
      id: id ?? this.id,
      isWinner: isWinner ?? this.isWinner,
      createdAt: createdAt ?? this.createdAt,
      isMyBid: isMyBid ?? this.isMyBid,
    );
  }

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      auctionId: json["auction_id"],
      bidAmount: json["bid_amount"].toString().toDouble?.toStringAsFixed(2),
      country: json["country"],
      id: json["id"],
      isWinner: json["is_winner"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      isMyBid: json["is_my_bid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "auction_id": auctionId,
        "bid_amount": bidAmount,
        "country": country,
        "id": id,
        "is_winner": isWinner,
        "created_at": createdAt?.toIso8601String(),
        "is_my_bid": isMyBid,
      };

  @override
  String toString() {
    return "$auctionId, $bidAmount, $country, $id, $isWinner, $createdAt, $isMyBid, ";
  }
}

class CreatedByDetails {
  CreatedByDetails({
    required this.firstname,
    required this.lastname,
    required this.profilePic,
    required this.userAccountId,
    required this.email,
    required this.userType,
    required this.accountType,
    required this.phoneCode,
    required this.phone,
    required this.profilePicUrl,
  });

  final String? firstname;
  final String? lastname;
  final dynamic profilePic;
  final String? userAccountId;
  final String? email;
  final String? userType;
  final String? accountType;
  final dynamic phoneCode;
  final dynamic phone;
  final String? profilePicUrl;

  CreatedByDetails copyWith({
    String? firstname,
    String? lastname,
    dynamic profilePic,
    String? userAccountId,
    String? email,
    String? userType,
    String? accountType,
    dynamic phoneCode,
    dynamic phone,
    String? profilePicUrl,
  }) {
    return CreatedByDetails(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      profilePic: profilePic ?? this.profilePic,
      userAccountId: userAccountId ?? this.userAccountId,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      accountType: accountType ?? this.accountType,
      phoneCode: phoneCode ?? this.phoneCode,
      phone: phone ?? this.phone,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
    );
  }

  factory CreatedByDetails.fromJson(Map<String, dynamic> json) {
    return CreatedByDetails(
      firstname: json["firstname"],
      lastname: json["lastname"],
      profilePic: json["profile_pic"],
      userAccountId: json["user_account_id"],
      email: json["email"],
      userType: json["user_type"],
      accountType: json["account_type"],
      phoneCode: json["phone_code"],
      phone: json["phone"],
      profilePicUrl: json["profile_pic_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "profile_pic": profilePic,
        "user_account_id": userAccountId,
        "email": email,
        "user_type": userType,
        "account_type": accountType,
        "phone_code": phoneCode,
        "phone": phone,
        "profile_pic_url": profilePicUrl,
      };

  @override
  String toString() {
    return "$firstname, $lastname, $profilePic, $userAccountId, $email, $userType, $accountType, $phoneCode, $phone, $profilePicUrl, ";
  }
}

class UpdatedByDetails {
  UpdatedByDetails({
    required this.profilePicUrl,
    required this.firstname,
    required this.lastname,
  });

  final dynamic profilePicUrl;
  final dynamic firstname;
  final dynamic lastname;

  UpdatedByDetails copyWith({
    dynamic profilePicUrl,
    dynamic firstname,
    dynamic lastname,
  }) {
    return UpdatedByDetails(
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
    );
  }

  factory UpdatedByDetails.fromJson(Map<String, dynamic> json) {
    return UpdatedByDetails(
      profilePicUrl: json["profile_pic_url"],
      firstname: json["firstname"],
      lastname: json["lastname"],
    );
  }

  Map<String, dynamic> toJson() => {
        "profile_pic_url": profilePicUrl,
        "firstname": firstname,
        "lastname": lastname,
      };

  @override
  String toString() {
    return "$profilePicUrl, $firstname, $lastname, ";
  }
}

extension CreatedByDetailsExtension on CreatedByDetails {
  String get fullName => "$firstname $lastname";

  String get phoneNumber {
    final String? validPhoneCode = phoneCode?.trim().isNotEmpty == true ? phoneCode : "";
    final String? validPhone = phone?.trim().isNotEmpty == true ? phone : "";

    if (validPhoneCode.isNullOrEmpty && validPhone.isNullOrEmpty) {
      return "-";
    } else {
      return "$validPhoneCode $validPhone";
    }
  }
}
