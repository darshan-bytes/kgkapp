class AddressDetails {
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? zipCode;

  AddressDetails({
    this.firstName,
    this.lastName,
    this.contactNumber,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  });

  AddressDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipCode'] = zipCode;
    return data;
  }

  @override
  String toString() {
    return 'AddressDetails{addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, state: $state, country: $country, zipCode: $zipCode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressDetails &&
        other.addressLine1 == addressLine1 &&
        other.addressLine2 == addressLine2 &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.zipCode == zipCode;
  }

  @override
  int get hashCode {
    return addressLine1.hashCode ^ addressLine2.hashCode ^ city.hashCode ^ state.hashCode ^ country.hashCode ^ zipCode.hashCode;
  }
}

extension AddressDetailsExtension on AddressDetails {
  String get fullName => '$firstName $lastName';

  String get fullAddress => '$addressLine1, $addressLine2, $city, $state, $country, $zipCode';
}
