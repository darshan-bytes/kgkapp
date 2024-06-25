class AddressDetails {
  int? id;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  bool? isDefaultShipping;
  bool? isDefaultBilling;

  AddressDetails({
    this.id,
    this.firstName,
    this.lastName,
    this.contactNumber,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.isDefaultShipping = false,
    this.isDefaultBilling = false,
  });

  @override
  String toString() {
    return 'AddressDetails{id:$id, firstName: $firstName, lastName: $lastName, contactNumber: $contactNumber, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, state: $state, country: $country, zipCode: $zipCode, isDefaultShipping: $isDefaultShipping, isDefaultBilling: $isDefaultBilling}';
  }

  @override
  bool operator ==(Object other) {
    return other is AddressDetails &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.contactNumber == contactNumber &&
        other.addressLine1 == addressLine1 &&
        other.addressLine2 == addressLine2 &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.zipCode == zipCode &&
        other.isDefaultShipping == isDefaultShipping &&
        other.isDefaultBilling == isDefaultBilling;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        contactNumber.hashCode ^
        addressLine1.hashCode ^
        addressLine2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        zipCode.hashCode ^
        isDefaultShipping.hashCode ^
        isDefaultBilling.hashCode;
  }
}

extension AddressDetailsExtension on AddressDetails {
  String get fullName => '$firstName $lastName';

  String get fullAddress => '$addressLine1, $addressLine2, $city, $state, $country, $zipCode';
}
