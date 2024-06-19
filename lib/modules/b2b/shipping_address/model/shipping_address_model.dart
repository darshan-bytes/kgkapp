
class ShippingAddressModel {
  int id;
  String? firstName;
  String? lastName;
  String? streetAddress;
  String? apartment;
  String? city;
  String? state;
  String? zipCode;
  String? phoneNumber;
  bool isDefault;
  bool isSelected;

  ShippingAddressModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.streetAddress,
      this.apartment,
    this.city,
    this.state,
    this.zipCode,
    this.phoneNumber,
    required this.isDefault,
    required this.isSelected
  });
}
