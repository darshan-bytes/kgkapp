import 'package:kgk/kgk.dart';

class AddressModel {
  String? storeName;
  String? storeDistance;
  String? storeAddress;
  String? latitude;
  String? longitude;
  bool isExpanded;
  GlobalKey<SmartExpansionTileState> addressDetailsKey;

  AddressModel({
    this.storeName,
    this.storeDistance,
    this.storeAddress,
    this.isExpanded = false,
    required this.addressDetailsKey,
    this.latitude,
    this.longitude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModel &&
          runtimeType == other.runtimeType &&
          storeName == other.storeName &&
          storeDistance == other.storeDistance &&
          storeAddress == other.storeAddress &&
          isExpanded == other.isExpanded &&
          addressDetailsKey == other.addressDetailsKey &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      storeName.hashCode ^
      storeDistance.hashCode ^
      storeAddress.hashCode ^
      isExpanded.hashCode ^
      addressDetailsKey.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
}
