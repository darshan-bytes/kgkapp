class AddressDetails {
  AddressDetails({
    this.customerOrgId,
    this.firstName,
    this.lastName,
    this.streetAddress,
    this.apartment,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.phone = const [],
    this.createdBy,
    this.isDefaultShipping = false,
    this.isDefaultBilling = false,
    this.id,
    this.isDeleted,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final int? customerOrgId;
  final String? firstName;
  final String? lastName;
  final String? streetAddress;
  final String? apartment;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;
  final List<CustomerPhoneNumber> phone;
  final int? createdBy;
  final bool isDefaultShipping;
  final bool isDefaultBilling;
  final String? id;
  final bool? isDeleted;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  AddressDetails copyWith({
    int? customerOrgId,
    String? firstName,
    String? lastName,
    String? streetAddress,
    String? apartment,
    String? city,
    String? state,
    String? country,
    String? zipCode,
    List<CustomerPhoneNumber>? phone,
    int? createdBy,
    bool? isShippingDefault,
    bool? isBillingDefault,
    String? id,
    bool? isDeleted,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return AddressDetails(
      customerOrgId: customerOrgId ?? this.customerOrgId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      streetAddress: streetAddress ?? this.streetAddress,
      apartment: apartment ?? this.apartment,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      phone: phone ?? this.phone,
      createdBy: createdBy ?? this.createdBy,
      isDefaultShipping: isShippingDefault ?? isDefaultShipping,
      isDefaultBilling: isBillingDefault ?? isDefaultBilling,
      id: id ?? this.id,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory AddressDetails.fromJson(Map<String, dynamic> json) {
    return AddressDetails(
      customerOrgId: json["customer_org_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      streetAddress: json["street_address"],
      apartment: json["apartment"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      zipCode: json["zip_code"],
      phone: json["phone"] == null ? [] : List<CustomerPhoneNumber>.from(json["phone"]!.map((x) => CustomerPhoneNumber.fromJson(x))),
      createdBy: json["created_by"],
      isDefaultShipping: json["is_shipping_default"],
      isDefaultBilling: json["is_billing_default"],
      id: json["_id"],
      isDeleted: json["isDeleted"],
      deletedAt: DateTime.tryParse(json["deletedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "customer_org_id": customerOrgId,
        "first_name": firstName,
        "last_name": lastName,
        "street_address": streetAddress,
        "apartment": apartment,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
        "phone": phone.map((x) => x.toJson()).toList(),
        "created_by": createdBy,
        "is_shipping_default": isDefaultShipping,
        "is_billing_default": isDefaultBilling,
        "_id": id,
        "isDeleted": isDeleted,
        "deletedAt": deletedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressDetails &&
          runtimeType == other.runtimeType &&
          customerOrgId == other.customerOrgId &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          streetAddress == other.streetAddress &&
          apartment == other.apartment &&
          city == other.city &&
          state == other.state &&
          country == other.country &&
          zipCode == other.zipCode &&
          phone == other.phone &&
          createdBy == other.createdBy &&
          id == other.id &&
          isDeleted == other.isDeleted &&
          deletedAt == other.deletedAt &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          v == other.v;

  @override
  int get hashCode =>
      customerOrgId.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      streetAddress.hashCode ^
      apartment.hashCode ^
      city.hashCode ^
      state.hashCode ^
      country.hashCode ^
      zipCode.hashCode ^
      phone.hashCode ^
      createdBy.hashCode ^
      id.hashCode ^
      isDeleted.hashCode ^
      deletedAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}

extension AddressDetailsExtension on AddressDetails {
  String get fullName => "$firstName $lastName";

  String get fullAddress => "$apartment, $streetAddress, $city, $state, $country, $zipCode";

  String? get contactNumber => phone.isNotEmpty ? "${phone.first.phoneCode} ${phone.first.phoneNumber}" : null;
}

class CustomerPhoneNumber {
  CustomerPhoneNumber({
    required this.phoneCode,
    required this.phoneNumber,
  });

  final String? phoneCode;
  final String? phoneNumber;

  CustomerPhoneNumber copyWith({
    String? phoneCode,
    String? phoneNumber,
  }) {
    return CustomerPhoneNumber(
      phoneCode: phoneCode ?? this.phoneCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory CustomerPhoneNumber.fromJson(Map<String, dynamic> json) {
    return CustomerPhoneNumber(
      phoneCode: json["phone_code"],
      phoneNumber: json["phone_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
      };
}
